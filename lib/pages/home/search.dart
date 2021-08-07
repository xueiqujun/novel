import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/search/NovelTypeSearch.dart';
import 'package:novel/Json/search_type.dart';
class Search extends StatefulWidget {
  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<Search> with AutomaticKeepAliveClientMixin{

  bool typeSelect = true;
  var date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }
  void getDate() async{
    Dio dio =new Dio();
    Response response =await dio.get('http://api.zhuishushenqi.com/cats/lv2/statistics');
    date = searchType.fromJson(response.data);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(225, 175, 244, 1),Color.fromRGBO(219, 204, 245, 1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.4,0.6]
              )
          ),
        ) ,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0,0.5],
                colors:[Color.fromRGBO(220, 220, 220, 1),Color.fromRGBO(245, 245, 245, 1)]
            )
        ),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.start ,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    )
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        this.typeSelect = true;
                        setState(() {

                        });
                      },
                      child: Container(
                          height: 50,
                          color:typeSelect? Color.fromRGBO(139, 0, 0, 1) : Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('男生',style: TextStyle(
                                fontSize: 20,
                                color: typeSelect ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),)
                            ],
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          this.typeSelect = false;
                        });
                      },
                      child: Container(
                          height: 50,
                          color:!typeSelect? Color.fromRGBO(139, 0, 0, 1) : Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('女生',style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: !typeSelect ? Colors.white : Colors.black,
                              ),)
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: date!=null ? TypeSelectInfo() :Container()
            )
          ],
        ),
      ),
    );
  }

  Widget TypeSelectInfo(){
    return ListView(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: typeSelect ? List.generate(date.male.length, (index){
            return Container(
                width: 190,
                height: 120,
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return TypeSearch(1,date.male[index].name,date.male,date.female);
                    }));
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 120,
                        child:  Image.network(
                          Global.coverAPI+date.male[index].bookCover[0],
                          fit:BoxFit.fill ,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Center(
                        child: Text(date.male[index].name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                )
            );
          }) : List.generate(date.female.length, (index){
            return Container(
                width: 190,
                height: 120,
                child:GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                      return TypeSearch(0,date.female[index].name,date.male,date.female);
                    }));
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 120,
                        child:  Image.network(
                          Global.coverAPI+date.female[index].bookCover[0],
                          fit:BoxFit.fill ,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Center(
                        child: Text(date.female[index].name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                )
            );
          }),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
