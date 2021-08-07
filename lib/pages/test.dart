import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'data.dart';
  void main(){
    runApp(MyApp());
  }
  class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
  }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter'),
      ),
      body: SingleChildScrollView(
        child:   Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0),child: Text('type1'),),
            Container(
              height: 300,
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
                pagination: SwiperPagination(),
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0),child: Text('type2'),),
            Container(
              height: 300,
              child: Swiper(
                itemCount: image1.length,
                itemWidth: 300,
                autoplay: true,
                itemBuilder: (BuildContext context,int index){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:Image.network(
                      image1[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                viewportFraction: 0,
                scale: 0.9,
                layout: SwiperLayout.STACK,
                autoplayDelay: 100,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0),child: Text('type'),),
          ],
        ),
      ),
    );
  }
}
