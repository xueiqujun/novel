import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:novel/Json/RankingData.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/home/books_details/books_details.dart';

import '../../data.dart';

class RankingBooks extends StatefulWidget {
  String RankingType;
  RankingBooks(this.RankingType);
  @override
  _RankingBooksState createState() => _RankingBooksState(RankingType);
}

class _RankingBooksState extends State<RankingBooks> with AutomaticKeepAliveClientMixin{
  String type;
  double AHeight;
  var Rankingdate;
  _RankingBooksState(this.type);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AHeight=0;
    getRakingDate();
  }
  void getRakingDate()async{
    Dio dio = new Dio();
    try{
      Response response =await dio.get(
        Global.novelAPI +"/ranking/${type}"
      );
      Rankingdate=RankingDate.fromJson(response.data);
      print(Rankingdate.ranking.books[1].id);
      setState(() {

      });
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery
        .of(context)
        .size
        .width;
   var height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      color: Colors.grey[300],
      child: Stack(
        children: [
          ClipPath(
            clipper: BottomClipper(),
            child: AnimatedContainer(
              width: width,
              duration: Duration(
                  milliseconds: 500
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                   colors: [Color.fromRGBO(254, 62, 57, 1),Color.fromRGBO(254, 103, 74, 1)]
                )
              ),
              height:150 -  AHeight,
            ),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: width * 0.05,right: width * 0.05),
            child: NotificationListener(
              onNotification: (ScrollNotification note){
                setState(() {
                  if(note.metrics.pixels.toDouble()>150){
                    AHeight=150;
                  }else{
                    AHeight = note.metrics.pixels.toDouble();
                  }
                });

              },
              child: RefreshIndicator(
                onRefresh: (){
                  return OnRefresh();
                },
                child: Rankingdate==null ? Container() : ListView.builder(
                    itemCount:Rankingdate.ranking.books.length,
                    itemBuilder:(BuildContext context,int index){
                      return GestureDetector(
                        key: ValueKey("${index}"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context){
                            return BooksDetails(Rankingdate.ranking.books[index].id);
                          }));
                        },
                        child: Container(
                            width: width,
                            margin: EdgeInsets.only(bottom: 8),
                            height: height * 0.15,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  Global.coverAPI+"${Rankingdate.ranking.books[index].cover}",
                                  width: width*0.18,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: width* 0.55,
                                  height: height,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${Rankingdate.ranking.books[index].title}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text(
                                        '${Rankingdate.ranking.books[index].author}/${Rankingdate.ranking.books[index].majorCate}',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(5),),
                                      Text(
                                        '${Rankingdate.ranking.books[index].shortIntro}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index+1}',
                                    style: TextStyle(
                                        fontSize: 45,
                                        color: index==0?  Color.fromRGBO(255, 136, 77, 1):Color.fromRGBO(132, 129, 122, 1),
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ))
                              ],
                            )
                        ),
                      );
                    }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> OnRefresh()async {
    await loadingNetData();
  }

  loadingNetData() {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class BottomClipper extends CustomClipper<Path>{
  @override
 Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width/2, size.height , size.width, size.height*0.7);
    path.lineTo(size.width, 0);
    path.close();
   return path;
  }


  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
   return false;
  }
}