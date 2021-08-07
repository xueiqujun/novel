import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:novel/Json/searchBooks.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/home/books_details/books_details.dart';
import 'package:toast/toast.dart';
class SearchBooks extends StatefulWidget {
  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<SearchBooks> {
  TextEditingController _controller=new TextEditingController();
  FocusNode _focusNode =new FocusNode();
  var date;
  int start = 1;
  int end = 20;
  List _listItems = [];
  String _name;
  ScrollController _listviewcontroller = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        print("获得焦点");
      }else{
        print("失去焦点");
      }
    });
    _listviewcontroller.addListener(() {
      var maxScroll = _listviewcontroller.position.maxScrollExtent;
      var pixel = _listviewcontroller.position.pixels;
     if(maxScroll==pixel){
       _addSearchBooks();
     }
    });
  }
  void search(String name)async{
    start = 1;
    end = 20;
    _listItems=[];
    _name=name;
    Toast.show('数据加载中...', context,gravity: Toast.CENTER,duration: 1);
    print(Global.novelAPI+"/book/fuzzy-search?query=${name}&start=${start}&limit=${end}");
    Dio dio =new Dio();
    try{
      Response response =await dio.get(
        Global.novelAPI+"/book/fuzzy-search?query=${name}&start=${start}&limit=${end}"
      );
      print(response);
     date = SearchBooksJson.fromJson(response.data);
    for(int i=0;i<date.books.length;i++){
      _listItems.add(date.books[i]);
    }
     setState(() {

     });

    }catch(e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromRGBO(254, 62, 57, 1),Color.fromRGBO(254, 103, 74, 1)]
            )
          ),
          padding: EdgeInsets.all(8),
            child:Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8 ,
                      maxHeight: 30
                    ),
                    child: TextField(
                      focusNode:_focusNode,
                      cursorColor: Global.greyColor,
                      onSubmitted: (name){
                        search(name);
                      },
                      controller:_controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: "作者名/作品名",
                        hintStyle: TextStyle(
                          color:Global.greyColor,
                          fontSize: 14
                        ),
                        prefixIcon:Icon(
                          Icons.search,
                          color: Global.greyColor,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Transform.translate(
                      offset: Offset(0,-5),
                      child: Text(
                        '取消',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ),
      body: _listItems ==null? Container : RefreshIndicator(
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
                    return BooksDetails(_listItems[index].id);
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
                        Global.coverAPI+"${_listItems[index].cover}",
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
    );
  }

  Future _pullRefresh() async{
    _listItems.clear();
    search(_name);
    return null;
  }

  void _addSearchBooks() async{
    start = end;
    end = end+20;
    Dio dio =new Dio();
    Toast.show('数据加载中...', context,gravity: Toast.CENTER,duration: 1);
  try{
    print(Global.novelAPI+"/book/fuzzy-search?query=${_name}&start=${start}&limit=${end}");
    Response response =await dio.get(
        Global.novelAPI+"/book/fuzzy-search?query=${_name}&start=${start}&limit=${end}"
    );
    print(response);
    for(int i=0;i<date.books.length;i++){
      _listItems.add(date.books[i]);
    }

    setState(() {

    });
  }catch(e){
    print(e);
  }
  }
}
