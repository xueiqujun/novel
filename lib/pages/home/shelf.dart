import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:novel/Json/book_chapters.dart';
import 'package:novel/db/db_helper.dart';
import 'package:novel/pages/Global/colors.dart';
import 'package:novel/pages/Global/dimens.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/search/Search.dart';
import 'package:novel/pages/util/utils.dart';
import '../data.dart';
import 'books_details/book_chapters_content_page.dart';
import 'event/event_bus.dart';

class Shelf extends StatefulWidget {
  @override
  _ShelfState createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> with AutomaticKeepAliveClientMixin{
  var _dbHelper = DbHelper();
  List _listBean = [];
  List _bookChapter = [];
   var date;
  StreamSubscription booksSubscription;
  final String _emptyTitle = "添加书籍";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    booksSubscription = eventBus.on<BooksEvent>().listen((event) {
      print("");
      getDbData();
    });
    getDbData();
    getData();
    setState(() {
    });
  }
  void getData() async {
    Dio dio =new Dio();
    try{
      Response response =await dio.get(
          'http://api.pingcc.cn/fictionChapter/search/19419'
      );
      date = BooksChapter.fromJson(response.data);
      _bookChapter=this.date.data.data;
      Global.bookChapter = _bookChapter;
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors:[Color.fromRGBO(116, 81, 171, 1),Color.fromRGBO(139, 148, 244, 1)]
              )
          ),
        ),
        title: Text(
          '我的书架',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body:SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    GridView.builder(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _listBean.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        return itemView(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemView(int index) {
    String readProgress = _listBean[index].readProgress;
    bool addBookshelfItem = false;
    if (_listBean[index].title == _emptyTitle) {
      addBookshelfItem = true;
    }

    var position = index == 0 ? 0 : index % 3;
    var axisAlignment;
    if (position == 0) {
      axisAlignment = CrossAxisAlignment.start;
    } else if (position == 1) {
      axisAlignment = CrossAxisAlignment.center;
    } else if (position == 2) {
      axisAlignment = CrossAxisAlignment.end;
    }
    return Column(
      crossAxisAlignment: axisAlignment,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            child: addBookshelfItem
                ? Image.asset(
              "images/icon_bookshelf_empty_add.png",
              height: 121,
              width: 92,
              fit: BoxFit.cover,
            ): Image.network(
              _listBean[index].image,
              height: 121,
              width: 105,
              fit: BoxFit.cover,
            ),
            onLongPress: () {
              if (!addBookshelfItem) {
                showDeleteDialog(index);
              }
            },
            onTap: () {
              if (addBookshelfItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchBooks()),
                );
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BookContentPage(
                      _listBean[index].bookUrl,
                      _listBean[index].bookId,
                      _listBean[index].image,
                      _listBean[index].chaptersIndex,
                      _listBean[index].isReversed == 1,
                      _listBean[index].title,
                      _listBean[index].offset,
                      _bookChapter,
                      _listBean[index].bookStar
                  );
                }));
              }
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 96,
          child: Text(
            _listBean[index].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: Dimens.textSizeM,
              color: addBookshelfItem ? MyColors.textBlack9 : MyColors.textBlack3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }



  showDeleteDialog(int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("删除书籍"),
          content: Text("删除此书后，书籍源文件及阅读进度也将被删除"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                _dbHelper.deleteBooks(_listBean[index].bookId).then((i) {
                  setState(() {
                    _listBean.removeAt(index);
                  });
                });
              },
              child: Text("确定"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("取消"),
            ),
          ],
        );
      },
    );
  }

  /// 从数据库查询书架书籍
  void getDbData() async {
    await _dbHelper.getTotalList().then((list) {
      _listBean.clear();
      list.reversed.forEach((item) {
        BookshelfBean todoItem = BookshelfBean.fromMap(item);
        setState(() {
          _listBean.add(todoItem);
        });
      });
      setAddItem();
    }).catchError((e) {});
    for(int i=0;i<_listBean.length;i++){
      print(_listBean[i].bookStar);
    }
  }

  /// add 样式 item
  void setAddItem() {
    ///无bookstar
   ///标签
    BookshelfBean todoItem = BookshelfBean(_emptyTitle, null, "", "", "", 0, 0, 0,14177365);
    setState(() {
      _listBean.add(todoItem);
    });
  }

  @override
  void dispose() {
    super.dispose();
    booksSubscription.cancel();
    _dbHelper.close();
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
