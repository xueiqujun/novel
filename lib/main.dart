import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novel/pages/home/book_city.dart';
import 'package:novel/pages/home/my_setting.dart';
import 'package:novel/pages/home/ranking.dart';
import 'package:novel/pages/home/search.dart';
import 'package:novel/pages/home/shelf.dart';
import 'package:novel/pages/search/Search.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  List<BottomNavigationBarItem> bottomNavigationBarItem;
  int _currIndex = 0;
  List<Widget> _page;
  @override
void initState() {
    // TODO: implement initState
    super.initState();
    List<BottomNavigationBarItem> _item=[
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text(
            '书城',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400
            ),
          )
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart,
          ),
          title: Text(
            '排行',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400
            ),
          )
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.menu_book_outlined,
          ),
          title: Text(
            '读书',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400
            ),
          )
      ),
      BottomNavigationBarItem(
          icon:Icon(
            Icons.search
          ),
        title: Text(  '分类',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
          ),
        )
      ),
     BottomNavigationBarItem(
          icon: Icon(
            Icons.self_improvement,
          ),
          title: Text(
            '我的',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400
            ),
          )
      ),
    ];
    bottomNavigationBarItem = _item;
    _page = [BookCity(),Ranking(),Shelf(),Search(),MySetting()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: this._currIndex,
        children: _page,
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: this.bottomNavigationBarItem,
        type:BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor:  Color.fromRGBO(243, 156, 18, 1),
        unselectedItemColor: Color.fromRGBO(132, 129, 122, 1),
        selectedIconTheme:IconThemeData(
          color: Color.fromRGBO(243, 156, 18, 1)
        ) ,
        unselectedIconTheme: IconThemeData(
          color: Color.fromRGBO(132, 129, 122, 1)
        ),
        /*unselectedFontSize:12,*/
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
        ),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15
        ),
        showUnselectedLabels: true,
        onTap:(index){
          this._currIndex =index;
          setState(() {

          });
        },
        currentIndex: this._currIndex,
      ),

    );
  }
}
