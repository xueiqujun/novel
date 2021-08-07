import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/home/books_details/books_details.dart';
import 'package:novel/pages/home/books_details/yuenov_details.dart';
import 'package:novel/Json/nove_type_search.dart';
class TypeSearch extends StatefulWidget {
  String selectNovelType;
  int selectSex;
  var manType;
  var womanType;
  TypeSearch(this.selectSex,this.selectNovelType,this.manType,this.womanType);
  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<TypeSearch> {
  var date;
  int start = 20;
  int end = 20;
  List _listItems = [];
  String tempSexKey;
  String tempSelectNovelType;
  int selectSex;
  ScrollController _listviewcontroller = new ScrollController();
  String selectNovelType;
  String sexKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.selectSex==1){
      sexKey = "male";
    }else{
      sexKey = "female";
    }
    this.tempSexKey = this.sexKey;
    this.tempSelectNovelType =this.widget.selectNovelType;


    this.selectSex =widget.selectSex;
    this.selectNovelType = widget.selectNovelType;
    _listviewcontroller.addListener(() {
      var maxScroll = _listviewcontroller.position.maxScrollExtent;
      var pixel = _listviewcontroller.position.pixels;
      if(maxScroll==pixel){
        _addSearchBooks();
      }
    });
    getDate();
  }
  void getDate()async{
    if(this.selectSex==1){
      this.sexKey = "male";
    }else{
      this.sexKey = "female";
    }
    Dio dio = new Dio();
    Response response = new Response();
    response =await dio.get('http://api.zhuishushenqi.com/book/by-categories?gender=${this.sexKey}&type=hot&major=${widget.selectNovelType}&start=0&limit=20');
    date = TypeSearchJson.fromJson(response.data);
    _listItems = date.books;
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return _listItems.isNotEmpty? Scaffold(
      appBar: AppBar(
        title:Text('${this.widget.selectNovelType}'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(255, 193, 88,1),Color.fromRGBO(254, 156,66, 1)]
              )
          ),
        ),
      ),
      endDrawer: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 40),
        width: MediaQuery.of(context).size.width*0.8,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: 50,
                  child: Stack(
                    children: [
                      Positioned(left: MediaQuery.of(context).size.width*0.35,child: Text('筛选',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w400),)),
                      Positioned(right: 15, child: IconButton(icon: Icon(Icons.close,size: 30,color: Colors.black,),onPressed: (){
                        Navigator.pop(context);
                      },))
                    ],
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(onTap: (){selectSex=1;setState(() {});},child: Text('男生',style: TextStyle(fontSize: 18,color:selectSex==1?Colors.red :Colors.black),)),
                Padding(padding: EdgeInsets.only(left: 20)),
                GestureDetector(onTap: (){selectSex=0;setState(() {});},child: Text('女生',style: TextStyle(fontSize: 18,color:selectSex==0?Colors.red :Colors.black)))
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Container(width: MediaQuery.of(context).size.width*0.8,height: 60,color: Color.fromRGBO(255 ,193 ,193, 1),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectSex==1 ? widget.manType.length : widget.womanType.length,
                  itemBuilder: (BuildContext context,int index){
                    return selectSex==1? GestureDetector(
                      onTap: (){
                       this.selectNovelType = this.widget.manType[index].name;
                        setState(() {

                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.manType[index].name,style: TextStyle(color:selectSex==1? (this.selectNovelType==widget.manType[index].name?Colors.red:Colors.black) : Colors.black, fontSize: 16,fontWeight: FontWeight.w400),),
                          Padding(padding: EdgeInsets.only(left: 80)),
                        ],
                      ),
                    ):GestureDetector(
                      onTap: (){
                        this.selectNovelType = this.widget.womanType[index].name;
                        setState(() {

                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.womanType[index].name,style: TextStyle(color:selectSex==0? (this.selectNovelType==widget.womanType[index].name?Colors.red:Colors.black) : Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),
                          Padding(padding: EdgeInsets.only(left: 80)),
                        ],
                      ),
                    );
                  }),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: 80,
              color: Colors.red,
              child: Row(
                children: [
                  Expanded(child:MaterialButton(onPressed: (){Navigator.pop(context);},padding:EdgeInsets.all(0),child: Container(width: double.maxFinite,height:double.maxFinite , color: Color.fromRGBO(	205 ,193 ,197, 1),child: Center(child: Text('取消',style: TextStyle(fontSize: 25,color: Colors.black),),),)),flex: 1,),
                  Expanded(child:MaterialButton(onPressed: (){
                    Navigator.pop(context);
                    this.widget.selectNovelType = this.selectNovelType;
                  _listItems=[];
                  getDate();
                  },
                      padding:EdgeInsets.all(0),child: Container(width: double.maxFinite,height:double.maxFinite,color: Color.fromRGBO(165,42 ,42, 1),child: Center(child: Text('确定',style: TextStyle(fontSize: 25,color: Colors.white),),),)),flex: 1,)
                ],
              ),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.red,
        onRefresh:_pullRefresh,
        child: ListView.separated(
          controller: _listviewcontroller,
          itemCount: _listItems.length,
          separatorBuilder: (BuildContext context ,int index){
            return Divider(
              height: 2,
              color: Global.greyColor,
            );
          },
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return BooksDetails(this._listItems[index].id);
                }));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  height: 130,
                  padding: EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image.network(
                        Global.coverAPI+_listItems[index].cover,
                        fit: BoxFit.cover,
                      ),
                      Padding(padding: EdgeInsets.all(6)),
                      Expanded(
                        child: Column(
                          /*  mainAxisAlignment: MainAxisAlignment.spaceBetween,*/
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_listItems[index].title}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.person,color:Global.greyColor,size: 17,),
                                Text('${_listItems[index].author}')
                              ],
                            ),
                            Text(
                              '${_listItems[index].shortIntro}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ),
            );
          },
        ),
      ),
    ): Scaffold(
      body: Center(
          child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.lightBlue)
      ),
    );
  }
///数据刷新
  Future _pullRefresh() async{
    _listItems.clear();
    getDate();
    return null;
  }

  void _addSearchBooks() async{
    Dio dio = new Dio();
    Response response = new Response();
    response =await dio.get('http://api.zhuishushenqi.com/book/by-categories?gender=${this.sexKey }&type=hot&major=${widget.selectNovelType}&start=${this.start}&limit=${this.end}');
    date = TypeSearchJson.fromJson(response.data);
    _listItems.addAll(date.books);
    this.start +=20;
    setState(() {

    });
  }
}
