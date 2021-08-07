import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:novel/pages/Global/global_colors.dart';
import 'package:novel/pages/home/bookCity/book_home.dart';
import 'package:novel/pages/home/bookCity/list_book.dart';


class BookCity extends StatefulWidget {
  @override
  _BookCityState createState() => _BookCityState();
}

class _BookCityState extends State<BookCity> with AutomaticKeepAliveClientMixin {
  final List<Tab> tabs = <Tab>[
     Tab(text:'首页'),
     Tab(text:'书单')
  ];
  TabController  controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final  width = MediaQuery.of(context).size.width;
    final  height = MediaQuery.of(context).size.height;
      return DefaultTabController(
          length: tabs.length,
          child:Scaffold(
              appBar: PreferredSize(
                    child: AppBar(
                      backgroundColor: Colors.white,
                      title:Text('首页',style: TextStyle(color: Global.greyColor,fontSize: 25),),
                      centerTitle: true,
                    ),
                preferredSize: Size.fromHeight(height*0.08),
              ),
              body:Home(),
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
