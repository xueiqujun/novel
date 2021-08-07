import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:novel/Json/books_context.dart';
import 'package:novel/db/db_helper.dart';
import 'package:novel/pages/Global/colors.dart';
import 'package:novel/pages/Global/dimens.dart';
import 'package:novel/pages/home/event/event_bus.dart';
import 'package:novel/widget/load_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'book_info_page.dart';

class BookContentPage extends StatefulWidget {
  /// 书籍章节内容 url
  String _bookUrl;

  /// 书籍 id
  String _bookId;

  /// 书籍图片
  String _bookImage;

  /// 保存到数据库里的书名
  String _bookName;

  /// 目录选择的 item 索引
  int _index = 0;
  double _initOffset = 0;
  /// 章节是否倒序
  bool _isReversed;
  var listben =[];
  int bookStar=0;
  BookContentPage(this._bookUrl, this._bookId, this._bookImage, this._index, this._isReversed, this._bookName, this._initOffset,this.listben,this.bookStar);

  @override
  State<StatefulWidget> createState() {
    return BookContentPageState();
  }
}

class BookContentPageState extends State<BookContentPage>
    with OnLoadReloadListener {
  var _dbHelper = DbHelper();
  static final double _addBookshelfWidth = 95;
  static final double _bottomHeight = 230;
  static final double _sImagePadding = 20;


  LoadStatus _loadStatus = LoadStatus.LOADING;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _content = "";
  double _height = 0;
  double _bottomPadding = _bottomHeight;
  double _imagePadding = _sImagePadding;
  double _addBookshelfPadding = _addBookshelfWidth;
  int _duration = 200;
  double _spaceValue = 1.8;
  double _textSizeValue = 18;
  bool _isNighttime = false;
  bool _isAddBookshelf = false;
  List _listBean = [];
  String _title = "";
  double _offset = 0;
  ScrollController _controller;

  @override
  void initState() {
    print(this.widget._bookImage);
    super.initState();
    _offset = this.widget._initOffset;
    _spGetTextSizeValue().then((value) {
      setState(() {
        _textSizeValue = value;
      });
    });
    _spGetSpaceValue().then((value) {
      setState(() {
        _spaceValue = value;
      });
    });
    getData();
    _listBean =widget.listben;
    setStemStyle();
    isAddBookshelf().then((isAdd) {
      setState(() {
        _isAddBookshelf = isAdd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isNighttime ? Colors.black : Colors.white,
      //侧滑菜单显示章节
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Colors.black,
            ),
            Container(
              height: 50,
              color: MyColors.homeGrey,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    this.widget._isReversed = !this.widget._isReversed;
                    this.widget._index =
                        _listBean.length - 1 - this.widget._index;
                    _listBean = _listBean.reversed.toList();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "目录",
                      style: TextStyle(
                          fontSize: Dimens.titleTextSize,
                          color: MyColors.textPrimaryColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(
                      "images/icon_chapters_turn.png",
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),

            /// 章节目录 list
            Expanded(
              child: ListView.separated(
                itemCount: _listBean.length,
                itemBuilder: (context, index) {
                  return itemView(index);
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(Dimens.leftMargin, 0, 0, 0),
                    child: Divider(height: 1, color: MyColors.dividerDarkColor),
                  );
                },
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _bottomPadding == 0 ? _bottomPadding = _bottomHeight : _bottomPadding = 0;
                _height == Dimens.titleHeight ? _height = 0 :_height = Dimens.titleHeight;
                _imagePadding == 0 ? _imagePadding = _sImagePadding : _imagePadding = 0;
                _addBookshelfPadding == 0 ? _addBookshelfPadding = _addBookshelfWidth : _addBookshelfPadding = 0;
              });
            },
            child: _loadStatus == LoadStatus.LOADING
                ? LoadingView()
                : _loadStatus == LoadStatus.FAILURE
                    ? FailureView(this)
                    : SingleChildScrollView(
                        controller: _controller,
                        padding: EdgeInsets.fromLTRB(
                          16,
                          16 + MediaQuery.of(context).padding.top,
                          9,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _title,
                              style: TextStyle(
                                fontSize: _textSizeValue + 2,
                                color: Color(0xFF9F8C54),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              _content,
                              style: TextStyle(
                                color: _isNighttime
                                    ? MyColors.contentColor
                                    : MyColors.black,
                                fontSize: _textSizeValue,
                                height: _spaceValue,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),

                            /// 章节切换
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 125,
                                  textColor: MyColors.textPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(125)),
                                    side: BorderSide(
                                        color: MyColors.textPrimaryColor,
                                        width: 1),
                                  ),
                                  onPressed: () {
                                    if (this.widget._isReversed) {
                                      if (this.widget._index >=
                                          _listBean.length - 1) {
                                        Toast.show(
                                             "没有上一章了",
                                            context,
                                          gravity: 1
                                        );
                                      } else {
                                        setState(() {
                                          _loadStatus = LoadStatus.LOADING;
                                        });
                                        this.widget._initOffset = 0;
                                        ++this.widget._index;
                                        getData();
                                      }
                                    } else {
                                      if (this.widget._index == 0) {
                                        Toast.show(
                                            "没有上一章了",
                                            context,
                                          gravity: 1
                                        );
                                      } else {
                                        setState(() {
                                          _loadStatus = LoadStatus.LOADING;
                                        });
                                        this.widget._initOffset = 0;
                                        --this.widget._index;

                                        getData();
                                      }
                                    }
                                  },
                                  child: Text("上一章"),
                                ),
                                MaterialButton(
                                  minWidth: 125,
                                  textColor: MyColors.textPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(125)),
                                    side: BorderSide(
                                        color: MyColors.textPrimaryColor,
                                        width: 1),
                                  ),
                                  onPressed: () {
                                    if (!this.widget._isReversed) {
                                      if (this.widget._index >=
                                          _listBean.length - 1) {
                                        Toast.show(
                                            "没有下一章了",
                                            context,
                                          gravity: 1
                                        );
                                      } else {
                                        setState(() {
                                          _loadStatus = LoadStatus.LOADING;
                                        });
                                        this.widget._initOffset = 0;
                                        ++this.widget._index;

                                        getData();
                                      }
                                    } else {
                                      if (this.widget._index == 0) {
                                        Toast.show(
                                            "没有下一章了",
                                            context,
                                          gravity: 1
                                        );
                                      } else {
                                        setState(() {
                                          _loadStatus = LoadStatus.LOADING;
                                        });
                                        _controller = ScrollController();
                                        this.widget._initOffset = 0;
                                        --this.widget._index;
                                        getData();
                                      }
                                    }
                                  },
                                  child: Text("下一章"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
          ),
          settingView(),

          /// 加入书架
          _isAddBookshelf
              ? Container()
              : Positioned(
                  top: 78,
                  right: 0,
                  child: AnimatedContainer(
                    duration:Duration(milliseconds: 2),
                    width: _addBookshelfWidth,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(_addBookshelfPadding, 30, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                         Toast.show("加入书架成功", context,duration: 1,gravity: 1);
                          addBookshelf();
                          setState(() {
                            _isAddBookshelf = true;
                          });
                        },
                        child: AnimatedContainer(
                          width: _addBookshelfWidth,
                          duration: Duration(milliseconds: _duration),
                          padding: EdgeInsets.fromLTRB(10, 7, 0, 7),
                          decoration: BoxDecoration(
                            color: MyColors.contentBgColor,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(50),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/icon_add_bookshelf.png",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "加入书架",
                                style: TextStyle(
                                  color: MyColors.contentColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          //状态栏颜色
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).padding.top,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  //隐藏设置view
  void closeSettingView() {
    setState(() {
      _bottomPadding = 250;
      _height = 0;
      _imagePadding = _sImagePadding;
      _addBookshelfPadding = _addBookshelfWidth;
    });
  }

  /// 设置弹窗 View
  Widget settingView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        AnimatedContainer(
          height: _height,
          duration: Duration(milliseconds: _duration),
          child: Container(
            height: Dimens.titleHeight,
            color: MyColors.contentBgColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimens.leftMargin, 0, Dimens.rightMargin, 0),
                      child: Image.asset(
                        'images/icon_title_back.png',
                        width: 20,
                        height: Dimens.titleHeight,
                        color: MyColors.contentColor,
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                BookInfoPage(this.widget._bookId, true)),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Image.asset(
                        'images/icon_bookshelf_more.png',
                        width: 3.0,
                        height: Dimens.titleHeight,
                        color: MyColors.contentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        Container(
          margin: EdgeInsets.fromLTRB(Dimens.leftMargin, 0, 0, 0),
          width: _sImagePadding * 2,
          height: _sImagePadding * 2,
          child: AnimatedPadding(
            duration: Duration(milliseconds: _duration),
            padding: EdgeInsets.fromLTRB(
                _imagePadding, _imagePadding, _imagePadding, _imagePadding),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isNighttime = !_isNighttime;
                });
              },
              child: Image.asset(
                _isNighttime
                    ? "images/icon_content_daytime.png"
                    : "images/icon_content_nighttime.png",
                height: 36,
                width: 36,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: _bottomHeight,
          child: AnimatedContainer(
            duration: Duration(milliseconds: _duration),
            padding: EdgeInsets.fromLTRB(0, _bottomPadding, 0, 0),
            child: Container(
              height: _bottomHeight,
              padding: EdgeInsets.fromLTRB(Dimens.leftMargin, 0, Dimens.rightMargin, 0),
              color: MyColors.contentBgColor,
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "字号",
                        style: TextStyle(
                            color: MyColors.contentColor,
                            fontSize: Dimens.textSizeM),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Image.asset(
                        "images/icon_content_font_small.png",
                        color: MyColors.white,
                        width: 28,
                        height: 18,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            valueIndicatorColor: MyColors.textPrimaryColor,
                            inactiveTrackColor: MyColors.white,
                            activeTrackColor: MyColors.textPrimaryColor,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            trackHeight: 2.5,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                            value: _textSizeValue,
                            label: "字号：$_textSizeValue",
                            divisions: 20,
                            min: 10,
                            max: 30,
                            onChanged: (double value) {
                              setState(() {
                                _textSizeValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              _spSetTextSizeValue(value);
                            },
                          ),
                        ),
                      ),
                      Image.asset(
                        "images/icon_content_font_big.png",
                        color: MyColors.white,
                        width: 28,
                        height: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "间距",
                        style: TextStyle(
                            color: MyColors.contentColor,
                            fontSize: Dimens.textSizeM),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Image.asset(
                        "images/icon_content_space_big.png",
                        color: MyColors.white,
                        width: 28,
                        height: 18,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            valueIndicatorColor: MyColors.textPrimaryColor,
                            inactiveTrackColor: MyColors.white,
                            activeTrackColor: MyColors.textPrimaryColor,
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            trackHeight: 2.5,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                            value: _spaceValue,
                            label: "字间距：$_spaceValue",
                            min: 1.0,
                            divisions: 20,
                            max: 3.0,
                            onChanged: (double value) {
                              setState(() {
                                _spaceValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              _spSetSpaceValue(value);
                            },
                          ),
                        ),
                      ),
                      Image.asset(
                        "images/icon_content_space_small.png",
                        color: MyColors.white,
                        width: 28,
                        height: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print("openDrawer");
                          closeSettingView();
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Image.asset(
                          "images/icon_content_catalog.png",
                          height: 50,
                        ),
                      ),
                      Image.asset(
                        "images/icon_content_setting.png",
                        height: 50,
                      ),
                      Image.asset(
                        "images/icon_content_brightness.png",
                        height: 50,
                      ),
                      Image.asset(
                        "images/icon_content_read.png",
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemView(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            setState(() {
              _loadStatus = LoadStatus.LOADING;
              this.widget._initOffset = 0;
              this.widget._index = index;
              print(index);
              this.widget._bookUrl =  'http://api.pingcc.cn/fictionContent/search/${_listBean[index].chapterId}';
              getData();
            });
          });
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              Dimens.leftMargin, 16, Dimens.rightMargin, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 0),

              ),
              Expanded(
                child: Text(
                  _listBean[index].title,
                  style: TextStyle(
                    fontSize: Dimens.textSizeM,
                    color: this.widget._index == index
                        ? MyColors.textPrimaryColor
                        : MyColors.textBlack9,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showVipDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("该章节为 Vip 章节，请联系作者"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("确定"),
            )
          ],
        );
      },
    );
  }

  /// 添加到书架
  void addBookshelf() {
    double index = (this.widget._index * 100 / _listBean.length);
    if (this.widget._isReversed) {
      index = 100 - index;
    }
    if (index < 0.1) {
      index = 0.1;
    }
    var bookshelfBean = BookshelfBean(
      this.widget._bookName,
      this.widget._bookImage,
      index.toStringAsFixed(1),
      this.widget._bookUrl,
      this.widget._bookId,
      _offset,
      this.widget._isReversed ? 1 : 0,
      this.widget._index,
      this.widget.bookStar
    );
    if (_isAddBookshelf) {
      _dbHelper.updateBooks(bookshelfBean).then((i) {});
    } else {
      _dbHelper.addBookshelfItem(bookshelfBean);
    }
    eventBus.fire(new BooksEvent());
  }

  /// 获取书籍内容
  void getData() async {
      _content='';
      _controller = new ScrollController(initialScrollOffset: this.widget._initOffset, keepScrollOffset: false);
      _controller.addListener(() {
        _offset = _controller.offset;
      });
      Dio dio =new Dio();
      try{
        Response response;
        response = await dio.get("http://api.pingcc.cn/fictionContent/search/${this.widget.bookStar+widget._index}");
        var date;
        date = BooksContext.fromJson(response.data);
        for(int i=0;i<date.data.data.content.length;i++){
          _content+="  ";
          _content+=date.data.data.content[i];
        }
        _title=_listBean[widget._index].title;
        _loadStatus =LoadStatus.SUCCESS;
        setState(() {

        });
      }catch(e){
        print(e);
      }
      _content = _content.replaceAll("\t", "\n").replaceAll("\n\n\n\n", "\n\n");
      _content=_content.replaceAll('第(1/3)页\n\n', '').replaceAll('第(2/3)页\n\n', '').replaceAll('第(3/3)页\n\n', '');
      _content=_content.replaceAll('(本章未完,请翻页)\n', '').replaceAll('笔趣阁阅读网址：n.biqukan.com', '');

  }




  //设置状态栏文字颜色
  void setStemStyle() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
  }

  /// 判断是否加入书架

  Future<bool> isAddBookshelf() async {
    var bookList = await _dbHelper.queryBooks(this.widget._bookId);
    if (bookList != null) {
      return true;
    } else {
      return false;
    }
  }

  _spSetSpaceValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('spaceValue', value);
  }

  _spSetTextSizeValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textSizeValue', value);
  }

  Future<double> _spGetSpaceValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getDouble('spaceValue');
    return value ?? 1.3;
  }

  Future<double> _spGetTextSizeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getDouble('textSizeValue');
    return value ?? 18;
  }

  @override
  void onReload() {
    _loadStatus = LoadStatus.LOADING;
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
    isAddBookshelf().then((isAdd) {
      _isAddBookshelf = true;
      addBookshelf();
    });
  }
}
