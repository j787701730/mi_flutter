import 'package:flutter/material.dart';
import 'package:mi_flutter/pages/cart.dart';
import 'package:mi_flutter/pages/class.dart';
import 'package:mi_flutter/pages/find.dart';
import 'package:mi_flutter/pages/home.dart';
import 'package:mi_flutter/pages/personal.dart';

import 'no_splash_factory.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MI Flutter',
      theme:
          ThemeData(primaryColor: Colors.white, platform: TargetPlatform.iOS),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  List nav = [Home(), Class(), Find(), Cart(), Personal()];
  var _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _pageChanged(int index) {
    if (mounted)
      setState(() {
        if (_tabIndex != index) _tabIndex = index;
      });
  }

  _badge(w, count) {
    double size = count == '' ? 10 : 16;
    return Positioned(
      left: w / 4 / 2 + 6,
      top: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: size,
        height: size,
        child: Center(
          child: Text(
            '$count',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double navIconSize = 20.0;
    return Scaffold(
      backgroundColor: Color(0xffF5F6FA),
//      appBar: AppBar(
//        elevation: 0,
//        title: Text('文杰强人锁男'),
//        centerTitle: false,
//      ),
      body: PageView.builder(
          //要点1
          physics: NeverScrollableScrollPhysics(),
          //禁止页面左右滑动切换
          controller: _pageController,
          onPageChanged: _pageChanged,
          //回调函数
          itemCount: nav.length,
          itemBuilder: (context, index) => nav[index]),
      bottomNavigationBar: Theme(
          data: ThemeData(
              splashFactory: NoSplashFactory(), highlightColor: Color(0xffff)),
          child: Container(
            color: Colors.white,
            height: 50,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xffED5B00),
              unselectedItemColor: Color(0xff747474),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Container(
                      width: w / nav.length,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Image.network(
                              _tabIndex == 0
                                  ? 'https://i8.mifile.cn/v1/a1/02d4f63a-3bda-210a-5727-110fdf2e3fe1.png'
                                  : 'https://i8.mifile.cn/v1/a1/7a7d0ce7-3859-b188-424d-a0695f5eef0e.png',
                              width: navIconSize,
                              height: navIconSize,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          _badge(w, '')
                        ],
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        '首页',
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: Container(
                      width: w / nav.length,
                      child: Stack(children: <Widget>[
                        Center(
                          child: Image.network(
                            _tabIndex == 1
                                ? 'https://i8.mifile.cn/v1/a1/cc2d5c56-7b00-ec76-02c6-00aed4a08ac9.png'
                                : 'https://i8.mifile.cn/v1/a1/461abe53-55e2-eb46-4817-7909ecd1e2a6.png',
                            width: navIconSize,
                            height: navIconSize,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        _badge(w, 2)
                      ]),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        '分类',
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: Container(
                        width: w / nav.length,
                        child: Stack(children: <Widget>[
                          Center(
                            child: Image.network(
                              _tabIndex == 2
                                  ? 'https://i8.mifile.cn/v1/a1/4d4dcd34-9b1c-c55c-bdbf-12533decd69f.png'
                                  : 'https://i8.mifile.cn/v1/a1/152f3bf2-6218-0414-c0c6-a0adfaf4d410.png',
                              width: navIconSize,
                              height: navIconSize,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          _badge(w, 3)
                        ])),
                    title: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        '发现',
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: Container(
                      width: w / nav.length,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Image.network(
                              _tabIndex == 3
                                  ? 'https://i8.mifile.cn/v1/a1/389a48f2-539f-4d28-e9bb-757813dc88a4.png'
                                  : 'https://i8.mifile.cn/v1/a1/9b29cf63-a59a-8b07-36db-5fe0bc309317.png',
                              width: navIconSize,
                              height: navIconSize,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          _badge(w, '')
                        ],
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        '购物车',
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: Container(
                      width: w / nav.length,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Image.network(
                              _tabIndex == 4
                                  ? 'https://i8.mifile.cn/v1/a1/6984fc74-6273-aa75-89e0-f35e04d9e8aa.png'
                                  : 'https://i8.mifile.cn/v1/a1/835193c2-c643-1d65-e194-17da8e9d0fb9.png',
                              width: navIconSize,
                              height: navIconSize,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          _badge(w, '')
                        ],
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        '我',
                      ),
                    )),
              ],
              currentIndex: _tabIndex,
              onTap: (index) {
                if (mounted)
                  setState(() {
                    _tabIndex = index;
                  });
                _pageController.jumpToPage(index);
              },
            ),
          )),
    );
  }
}
