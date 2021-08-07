import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:novel/Json/yuenov_details_json.dart';
import 'package:novel/pages/Global/colors.dart';
import 'package:novel/pages/Global/dimens.dart';
import 'package:novel/pages/home/books_details/yuenov_chapters_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'book_chapters_page.dart';

class yuenov_details extends StatefulWidget {
  var bookInfo;
  yuenov_details(this.bookInfo);
  @override
  _BooksDetailsState createState() => _BooksDetailsState();
}

class _BooksDetailsState extends State<yuenov_details> {
  var date;
  bool isRead = false;
  Color _iconColor = Color.fromARGB(255, 255, 255, 255);
  Color _titleBgColor = Color.fromARGB(0, 255, 255, 255);
  Color _titleTextColor = Color.fromARGB(0, 0, 0, 0);
  ScrollController _controller = new ScrollController();
  bool _isDividerGone = true;
  void getBooks ()async{
   Dio dio =new Dio();
   Response response =await dio.get('http://yuenov.com:15555/app/open/api/book/getDetail?bookId=${widget.bookInfo}');
   date = YuenovDetailsJson.fromJson(response.data);
   setState(() {

   });
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
    print(widget.bookInfo);
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return date!=null ? Scaffold(
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
                Navigator.pop(context);
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
                "${date.data.desc}",
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
                Text(
                  "写书评",
                  style: TextStyle(
                      fontSize: Dimens.textSizeL, color: Color(0xFF33C3A5)),
                )
              ],
            ),
          ),
          commentList(),
          Container(
            child: Text(
              "查看更多评论（268）",
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
            "${date.data.title}",
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
            'http://pt.yuenov.com:15555${date.data.coverImg}',
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
                  "${date.data.title}",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: Dimens.titleTextSize, color: MyColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${date.data.author}",
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
                      "${date.data.categoryName}",
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
                      "${date.data.word}",
                      style: TextStyle(
                          fontSize: Dimens.textSizeL, color: MyColors.white),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 3, 4),
                      child: Text(
                        "9.0",
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
        bodyChildView(
            'images/icon_details_bookshelf_add.png', "加入书架", 0,addBooksShelf),
        bodyChildView('images/icon_details_chapter.png', "${date.data.chapterNum}"+ "章", 1,openBooksDirectory),
        bodyChildView('images/icon_details_reward.png', "支持作品", 2,supportBooks),
        bodyChildView('images/icon_details_download.png', "批量下载", 3,download),
      ],
    );
  }
  void addBooksShelf(){

  }
  void openBooksDirectory(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return BookChaptersPage(date.data.bookId.toString(), date.data.title, 'http://pt.yuenov.com:15555${date.data.coverImg}');
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
        children: <Widget>[
          itemView("嘻嘻", "求更新，不够看", 4.5, "9", true),
          itemView("书友805699513", "不错不错。", 5, "8", false),
          itemView("书友007", "没看先点赞", 5, "5", true),
          itemView("书友00888", "好文章不错，就是更新太慢了。", 3, "1", false),
          itemView("书友00666", "打卡", 5, "9", true),
        ],
      ),
    );
  }
  Widget itemView(String name, String content, double rate, String likeNum, bool image) {
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
                likeNum,
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
