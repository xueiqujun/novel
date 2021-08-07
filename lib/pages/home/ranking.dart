import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:novel/Json/RankingTypeDate.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/home/ranking/ranking_book.dart';
import 'package:novel/pages/search/Search.dart';
class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> with AutomaticKeepAliveClientMixin{
  /*  splashColor: Colors.transparent,
    highlightColor: Colors.transparent,*/
  List<Tab>tabs ;
  List<RankingBooks>  tabbarview;
    var  RD;
    void getRankingDate() async{
    try{
      Dio dio =new Dio();
      Response response =await dio.get(
          Global.novelAPI+"/ranking/gender",
      );
        var date = RakingDataType.fromJson(response.data);
        RD =date;
       tabs= date.male.map((data){
         return Tab(
           key: ValueKey(data.id),
           text: '${data.shortTitle}',
         );
       }).toList();
      tabbarview = date.male.map((data){
         return RankingBooks(data.id);
       }).toList();
      setState(() {

      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getRankingDate();
  }

  @override
  Widget build(BuildContext context){
      super.build(context);
   return  RD==null ?  Container() :  DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          // titleSpacing: NavigationToolbar.kMiddleSpacing,
          centerTitle: true,
          toolbarHeight: 100,
          title: Text(
            '排行榜',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10
                ),
          ),
          actions: [
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon:Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size:28 ,

                ),
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return  SearchBooks();
                  }));
            })
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(254, 62, 57, 1),Color.fromRGBO(254, 103, 74, 1)]
              )
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorSize:TabBarIndicatorSize.label ,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: tabbarview,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
