import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:novel/Json/Booksdetails.dart';
import 'package:novel/Json/ReviewDate.dart';
import 'package:novel/db/db_helper.dart';
import 'package:novel/pages/Global/colors.dart';
import 'package:novel/pages/Global/dimens.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/home/event/event_bus.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'book_chapters_content_page.dart';
import 'book_chapters_page.dart';

class BooksDetails extends StatefulWidget {
  String bookId;
  BooksDetails(this.bookId);
  @override
  _BooksDetailsState createState() => _BooksDetailsState();
}

class _BooksDetailsState extends State<BooksDetails> {
  var date;
  bool isRead = false;
  bool _isAddBookshelf = false;
  BookshelfBean _bookshelfBean;
  var _dbHelper = DbHelper();
  Color _iconColor = Color.fromARGB(255, 255, 255, 255);
  Color _titleBgColor = Color.fromARGB(0, 255, 255, 255);
  Color _titleTextColor = Color.fromARGB(0, 0, 0, 0);
  ScrollController _controller = new ScrollController();
  bool _isDividerGone = true;
  int _reviewCount;

  var reviewDate;
   void getBooks ()async{
     print(Global.novelAPI+"/book/${widget.bookId}");
     Dio dio =new Dio();
     try{
       Response response;
       response=await dio.get(Global.novelAPI+"/book/${widget.bookId}"
       );
      date = BooksDetailsJson.fromJson(response.data);
      print(date);
     }catch(e){
       print(e);
     }
   }
   
   getReviewDate()async{
     Dio dio = new Dio();
     try {
       Response response=await dio.get('http://api.zhuishushenqi.com/post/review/by-book?book=${widget.bookId}&sort=updated&start=0&limit=20');
       this.reviewDate = ReviewDate.fromJson(response.data);
       this._reviewCount = this.reviewDate.total;
       this.reviewDate=this.reviewDate.reviews;
       setState(() {

       });
     }catch (e) {
       print(e);
     }
   }
   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      //170
      if (_controller.offset <= 170) {
        setState(() {
          double num = (1 - _controller.offset / 170) * 255;
          _iconColor =
              Color.fromARGB(255, num.toInt(), num.toInt(), num.toInt());
          _titleBgColor = Color.fromARGB(255 - num.toInt(), 255, 255, 255);
          if (_controller.offset > 90) {
            _titleTextColor = Color.fromARGB(255 - num.toInt(), 0, 0, 0);
          } else {
            _titleTextColor = Color.fromARGB(0, 0, 0, 0);
          }
          if (_controller.offset > 160) {
            _isDividerGone = false;
          } else {
            _isDividerGone = true;
          }
        });
      } else {
        setState(() {
          _isDividerGone = false;
          _iconColor = Color.fromARGB(255, 0, 0, 0);
          _titleTextColor = Color.fromARGB(255, 0, 0, 0);
          _titleBgColor = Color.fromARGB(255, 255, 255, 255);
        });
      }
    });
     getBooks();
    getDbData();
    getReviewDate();
  }
  void getDbData() async {
    var list = await _dbHelper.queryBooks(this.widget.bookId);
    if (list != null) {
      print("getDbData1");
      _bookshelfBean = list;
        _isAddBookshelf = true;
    } else {
      print("getDbData2");
        _isAddBookshelf = false;

    }
  }
  @override
  Widget build(BuildContext context) {
    return reviewDate!=null ? Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          contentView(),
          titleView(),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: MaterialButton(
              height: Dimens.titleHeight,
              color: MyColors.textPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BookContentPage(
                    'http://api.pingcc.cn/fictionContent/search/${Global.bookChapter[0].chapterId}',
                    this.widget.bookId,
                    Global.coverAPI+date.cover,
                    0,
                    false,
                    date.title,
                    0,
                    Global.bookChapter,
                    int.parse(Global.bookChapter[0].chapterId)
                  );
                }));
              },
              child: Text(
               isRead ? "继续阅读":"开始阅读",
                style: TextStyle(color: MyColors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    ): Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child:  CircularPercentIndicator(
            radius: 120,
            lineWidth: 10.0,
            percent: 1,
            animation: true,
            animationDuration: 1000,
            circularStrokeCap: CircularStrokeCap.round,
            restartAnimation: true,
            center: Text('加载中...'),
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
        ),
      ),
    );
  }
  Widget contentView() {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          coverView(),
          bodyView(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  Dimens.leftMargin, 20, Dimens.rightMargin, 20),
              child: Text(
                "${date.longIntro}",
                style: TextStyle(
                    fontSize: Dimens.textSizeM, color: MyColors.black),
              )),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                Dimens.leftMargin, 12, Dimens.rightMargin, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "最新书评",
                  style: TextStyle(
                      fontSize: Dimens.textSizeM, color: MyColors.textBlack3),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 3, 0),
                  child: Image.asset(
                    'images/icon_info_edit.png',
                    width: 16,
                    height: 16,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print("书评");
                  },
                  child: Text(
                    "写书评",
                    style: TextStyle(
                        fontSize: Dimens.textSizeL, color: Color(0xFF33C3A5)),
                  ),
                )
              ],
            ),
          ),
          commentList(),
          Container(
            child: Text(
              "查看更多评论（${this._reviewCount}）",
              style: TextStyle(
                  color: MyColors.textPrimaryColor, fontSize: Dimens.textSizeL),
            ),
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
          ),
          Container(
            alignment: Alignment.center,
            color: MyColors.dividerColor,

            padding: EdgeInsets.fromLTRB(0, 14, 0, 68),
          ),
        ],
      ),
    );
  }
  Widget titleView() {
    return Container(
      color: _titleBgColor,
      constraints: BoxConstraints.expand(height: Dimens.titleHeight),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              left: 0,
              child: Material(
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
                      color: _iconColor,
                      width: 20,
                      height: Dimens.titleHeight,
                    ),
                  ),
                ),
              )),
          Text(
            "${date.title}",
            style: TextStyle(
                fontSize: Dimens.titleTextSize, color: _titleTextColor),
            overflow: TextOverflow.ellipsis,
          ),
          Positioned(
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Dimens.leftMargin, 0, Dimens.rightMargin, 0),
                  child: Image.asset(
                    'images/icon_share.png',
                    color: _iconColor,
                    width: 18,
                    height: Dimens.titleHeight,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Offstage(
              offstage: _isDividerGone,
              child: Divider(height: 1, color: MyColors.dividerDarkColor),
            ),
          ),
        ],
      ),
    );
  }
  Widget coverView() {
    return Container(
      color: MyColors.infoBgColor,
      padding:
      EdgeInsets.fromLTRB(Dimens.leftMargin, 68, Dimens.rightMargin, 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            "${Global.coverAPI+date.cover}",
            height: 137,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${date.title}",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: Dimens.titleTextSize, color: MyColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${date.author}",
                  style: TextStyle(
                      fontSize: Dimens.textSizeM, color: MyColors.white),
                ),
                SizedBox(
                  height: 61,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                     "${date.majorCateV2}",
                      style: TextStyle(
                          fontSize: Dimens.textSizeL, color: MyColors.white),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(11, 0, 11, 0),
                      color: Color(0x50FFFFFF),
                      width: 1,
                      height: 12,
                      child: Text(""),
                    ),
                    Text(
                     "${date.wordCount}字",
                      style: TextStyle(
                          fontSize: Dimens.textSizeL, color: MyColors.white),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 3, 4),
                      child: Text(
                             "${date.rating.score}",
                        style: TextStyle(
                            color: MyColors.fractionColor, fontSize: 23),
                      ),
                    ),
                    Text(
                      "分",
                      style: TextStyle(
                          color: MyColors.white, fontSize: Dimens.textSizeL),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget bodyView() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        bodyChildView(_isAddBookshelf ? 'images/icon_details_bookshelf_add.png' : 'images/icon_details_bookshelf.png', _isAddBookshelf ? "已在书架" : "加入书架", 0,addBooksShelf),
        bodyChildView('images/icon_details_chapter.png', "${date.chaptersCount}"+ "章", 1,openBooksDirectory),
        bodyChildView('images/icon_details_reward.png', "支持作品", 2,supportBooks),
        bodyChildView('images/icon_details_download.png', "批量下载", 3,download),
      ],
    );
  }
  void addBooksShelf(){
    if (!_isAddBookshelf) {
      ///标签
      var bean = BookshelfBean(this.date.title, Global.coverAPI+date.cover, "0", "http://api.pingcc.cn/fictionContent/search/14177365", "${this.widget.bookId}", 0, 0, 0,14177365);
      _dbHelper.addBookshelfItem(bean);
      this._bookshelfBean = bean;
      setState(() {
        _isAddBookshelf = true;
      });
      eventBus.fire(new BooksEvent());
    }
  }
  void openBooksDirectory(){
     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
       return BookChaptersPage(date.id,date.title,Global.coverAPI+date.cover);
     }));
  }
  void supportBooks(){
     print("支持");
  }
  void download(){
     print("下载");
  }
  Widget bodyChildView(String img, String content, int tap,Function() fun) {
    return Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap:fun,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                img,
                width: 34,
                height: 34,
                fit: BoxFit.contain,
              ),
              Text(
                content,
                style: TextStyle(
                    color: MyColors.textBlack3, fontSize: Dimens.textSizeM),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget commentList() {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimens.leftMargin, 0, Dimens.rightMargin, 0),
      child: Column(
        children: reviewDate.map<Widget>((date){
          return itemView(date.author.nickname, date.content, date.rating, date.likeCount, false);
        }).toList(),
      ),
    );
  }
  Widget itemView(String name, String content, int rate, int likeNum, bool image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            new ClipOval(
              child: new SizedBox(
                width: 32,
                height: 32,
                child: new Image.asset("images/icon_default_avatar.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,
                      style: TextStyle(
                          color: MyColors.textBlack6,
                          fontSize: Dimens.textSizeL)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),

                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
          child: Text(
            content,
            style: TextStyle(
                color: MyColors.textBlack3, fontSize: Dimens.textSizeL),
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              "2019.05.09",
              style: TextStyle(color: MyColors.textBlack9, fontSize: 12),
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: image
                  ? Image.asset(
                "images/icon_like_true.png",
                width: 18,
                height: 18,
              )
                  : Image.asset(
                "images/icon_like_false.png",
                width: 18,
                height: 18,
              ),
              onTap: () {

              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(2, 0, 20, 0),
              child: Text(
                likeNum.toString(),
                style: TextStyle(color: MyColors.textBlack9, fontSize: 12),
              ),
            ),
            Image.asset(
              "images/icon_comment.png",
              width: 18,
              height: 18,
            ),
          ],
        ),
        SizedBox(
          height: 18,
        )
      ],
    );
  }
}
