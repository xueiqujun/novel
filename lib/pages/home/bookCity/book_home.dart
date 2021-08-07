import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:novel/Json/backinfo.dart';
import 'package:novel/Json/novelinfo.dart';
import 'package:novel/pages/home/books_details/books_details.dart';
import 'package:novel/pages/search/Search.dart';
import '../../data.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/Json/qltjJSON.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
   var date2;
  String introduction;
  String name;
  String author;
  var date1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   getQLTJDate();
   getRXTJDate();
  }
  void getQLTJDate()async{
    Dio dio =new Dio();
    try{
      Response response = await dio.get(Global.novelAPI+"/book/fuzzy-search?query=斗破&start=1&limit=6");
      print(response);
      date1 = qltjJson.fromJson(response.data);
      date1 = date1.books;
    }catch(e){
      print(e);
    }
  }
  void getRXTJDate()async{
    Dio dio =new Dio();
    try{
      Response response = await dio.get(Global.novelAPI+"/book/fuzzy-search?query=火&start=1&limit=6");
      print(response);
      date2 = qltjJson.fromJson(response.data);
      date2 = date2.books;
      this.introduction=date2[0].shortIntro;
      this.name = date2[0].title;
      this.author = date2[0].author;
      setState(() {

      });
    }catch(e){
      print(e);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return this.date1!=null&&this.date2!=null ? Container(
      padding:EdgeInsets.only(left: width * 0.03,right: width * 0.03,top: height*0.02,bottom: 0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return  SearchBooks();
             }));
            },
            child: Container(
              width: width,
              height: height*0.04,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color.fromRGBO(169, 169, 169, 0.5),
                borderRadius: BorderRadius.all(Radius.circular(23)),
              ),
              child: Row(
                children: [
                  Container(
                    width:8 ,
                  ),
                  Icon(
                      Icons.search,
                    color:Color.fromRGBO(118, 116, 116, 1.0),
                  ),
                  Text(
                    ' 搜索更多作品或作品',
                    style: TextStyle(
                      color: Color.fromRGBO(118, 116, 116, 1.0),
                    ),
                  ),
                ],
              )
            ),
          ),
          Padding(padding: EdgeInsets.all(8)),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Container(
                    height: height * 0.2,
                    child: Swiper(
                      itemCount: image1.length,
                      autoplay: true,
                      onTap: (index){
                        print(index);
                      },
                      itemBuilder: (BuildContext context,int index){
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:Image.network(
                              image1[index],
                              fit: BoxFit.cover,
                            )
                        );
                      },
                      viewportFraction: 0.8,
                      scale: 0.9,
                      pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeColor: Color.fromRGBO(243, 156, 18, 1)
                        )
                      ),
                      layout: SwiperLayout.DEFAULT,

                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.waves_rounded,
                        color:Color.fromRGBO(243, 156, 18, 1),
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Text(
                        '强烈推荐',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 10,
                    children: date1.map<Widget>((date){
                      return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                  return BooksDetails(date.id);
                                }));
                              },
                            child: Container(
                              key: ValueKey("${date.author}+${date.title}"),
                              width: width/3.5,
                              height:210,
                              child: Column(
                                children: [
                                  Image.network(
                                    Global.coverAPI+date.cover,
                                    width: width/3.5,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 8)),
                                  Container(
                                    width: width/3.5,
                                    height: 45,
                                    child: Text(
                                        '${date.title}',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow:TextOverflow.ellipsis ,
                                      style: TextStyle(
                                        fontSize:16,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 4)),
                                  Container(
                                    width: width/3.5,
                                    height: 20,
                                    child: Text(
                                      '${date.author}',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow:TextOverflow.ellipsis ,
                                      style: TextStyle(
                                          fontSize:16,
                                          color: Color.fromRGBO(132, 129, 122, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      );
                    }).toList(),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.radio,
                        color:Color.fromRGBO(243, 156, 18, 1),
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Text(
                        '任性推荐',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: height * 0.2,
                    child: Swiper(
                      itemCount: date2.length,
                      autoplay: false,
                      onTap: (index){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                          return BooksDetails(date2[index].id);
                        }));
                      },
                      onIndexChanged: (index){
                        setState(() {
                          this.introduction=date2[index].shortIntro;
                          this.name = date2[index].title;
                          this.author = date2[index].author;
                        });
                      },
                      itemBuilder: (BuildContext context,int index){
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:Center(
                              child: Container(
                                child: Image.network(
                                  Global.coverAPI+date2[index].cover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                        );
                      },
                      viewportFraction: 0.2,
                      scale: 0.3,
                      outer: true,
                      fade:0.8,
                      pagination: SwiperPagination(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        builder: DotSwiperPaginationBuilder(
                          color:Color.fromRGBO(169, 169, 169, 1),
                          activeColor: Color.fromRGBO(243, 156, 18, 1),
                          space: 3
                        )
                      ),
                    ),
                  ),
                  Text(
                    '${this.name}',
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline_outlined,
                        color: Color.fromRGBO(169, 169, 169, 1),
                      ),
                      Padding(padding: EdgeInsets.only(left: 4)),
                      Text(
                          '${this.author}',
                        maxLines: 1,
                        overflow:TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize:13,
                          fontWeight: FontWeight.bold,
                          color:Color.fromRGBO(169, 169, 169, 1),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    '${this.introduction}',
                    maxLines: 2,
                    overflow:TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize:14,
                      fontWeight: FontWeight.w400,
                      color:Color.fromRGBO(169, 169, 169, 1),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ):Container(color: Colors.white,);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}