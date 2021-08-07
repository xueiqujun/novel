import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:novel/Json/yuenov_chapters_json.dart';
import 'package:novel/pages/Global/colors.dart';
import 'package:novel/pages/Global/dimens.dart';

import 'book_chapters_content_page.dart';

///小说目录章节页

class YuenovBookChaptersPage extends StatefulWidget {
  final int _bookId;
  final String _bookName;


  YuenovBookChaptersPage(this._bookId,this._bookName);

  @override
  State<StatefulWidget> createState() {
    return YuenovBookChaptersPageState();
  }
}

class YuenovBookChaptersPageState extends State<YuenovBookChaptersPage> {
  var _listBean = [];
  bool _isReversed = false;
  var date;
  bool iswait =true;

  @override
  void initState() {
    super.initState();

    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: titleView(),
      ),
      body:iswait? Center(
        child: Loading(indicator: BallPulseIndicator(),size: 100.0,color: MyColors.textPrimaryColor),
      ) :ListView.separated(
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
    );
  }

  Widget titleView() {
    return Container(
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
                    width: 20,
                    height: Dimens.titleHeight,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_listBean != null && _listBean.length > 0) {
                setState(() {
                  _isReversed = !_isReversed;
                  _listBean = _listBean.reversed.toList();
                });
              }
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
          )
        ],
      ),
    );
  }

  void getData() async {
    Dio dio =new Dio();
    try{
      Response response =await dio.get(
          'http://yuenov.com:15555/app/open/api/chapter/getByBookId?bookId=${widget._bookId}',
      );
      date = YuenovChaptersJson.fromJson(response.data);
      getListBeanDate();
    }catch(e){
      print(e);
    }
  }
  getListBeanDate() async{
    _listBean=this.date.data.chapters;
    setState(() {
      this.iswait =false;
    });
    print(_listBean.length);
  }
  Widget itemView(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {

          }));
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
                  _listBean[index].name,
                  style: TextStyle(
                      fontSize: Dimens.textSizeM, color: MyColors.textBlack9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
