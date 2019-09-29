import 'dart:core';
import 'dart:core' as prefix0;

import 'package:flutter/material.dart';
import './data/class-data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Class extends StatefulWidget {
  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> {
  PageController _pageController;
  ScrollController controller;
  int tabIndex = 0;

  double _itemHeight = 70;
  double allHeight = 0;

  GlobalKey leftMenuKey = GlobalKey();

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
    allHeight = _itemHeight * data.length;
    _pageController = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _jump(index) {
    double height = leftMenuKey.currentContext.size.height;
    if (controller.offset + height < (index + 1) * _itemHeight ||
        controller.offset >= index * _itemHeight) {
      if (allHeight - index * _itemHeight > height) {
        controller.animateTo(index * _itemHeight,
            duration: new Duration(microseconds: 200), curve: Curves.ease);
      } else {
        controller.animateTo(allHeight - height,
            duration: new Duration(microseconds: 200), curve: Curves.ease);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width;
//    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('分类'),
//        titleSpacing: 0,
        actions: <Widget>[
          Container(
            width: 56,
            child: Center(
              child: Icon(
                Icons.message,
                size: 24,
                color: Color(0xff909090),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              key: leftMenuKey,
              width: 100,
              child: ListView(
                controller: controller,
                children: data.map<Widget>((item) {
                  int index = data.indexOf(item);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        tabIndex = index;
                      });
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                        height: _itemHeight,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: _itemHeight / 2,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                              width: 3,
                              color: tabIndex == index ? Color(0xffED5B00) : Colors.transparent,
                            ))),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${item['category_name']}',
                                style: TextStyle(
                                  color: tabIndex == index ? Color(0xffED5B00) : Color(0xff1E1E1E),
                                ),
                              ),
                            ),
                          ),
                        )),
                  );
                }).toList(),
              ),
            ),
            Expanded(
                flex: 1,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
//        physics: NeverScrollableScrollPhysics(), // 禁止左右滑动
                  children: data.map<Widget>((item) {
                    return Com(item);
                  }).toList(),
                  onPageChanged: (index) {
                    setState(() {
                      tabIndex = index;
                      _jump(index);
                    });
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class Com extends StatefulWidget {
  final props;

  Com(this.props);

  @override
  _ComState createState() => _ComState();
}

class _ComState extends State<Com> with AutomaticKeepAliveClientMixin {
  @override
  get wantKeepAlive => true;

  ScrollController _controller = ScrollController();
  bool scro = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      scro = true;
    });
    _controller.addListener(() {});
  }

  @override
  void didUpdateWidget(Com oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      scro = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragDown: (xxx) {
        if (_controller.offset < 0 ||
            _controller.position.pixels > _controller.position.maxScrollExtent) {
          setState(() {
            scro = false;
          });
        }
      },
      child: ListView(
        controller: _controller,
        shrinkWrap: true,
        physics: scro ? ScrollPhysics() : NeverScrollableScrollPhysics(),
//        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(right: 10),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.props['category_list'].map<Widget>((li) {
              Widget com = Container();
              switch (li['view_type']) {
                case 'cells_auto_fill':
                  com = CachedNetworkImage(
                    imageUrl: '${li['body']['items'][0]['img_url_webp']}',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                  break;
                case 'category_title':
                  com = Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 1,
                          width: 15,
                          color: Color(0xffEFEFEF),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            '${li['body']['category_name']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 15,
                          color: Color(0xffEFEFEF),
                        ),
                      ],
                    ),
                  );
                  break;
                case 'category_group':
                  com = Wrap(
                    children: li['body']['items'].map<Widget>((li2) {
                      return Container(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        width: (width - 110) / 3,
                        child: Column(
                          children: <Widget>[
                            CachedNetworkImage(
                              height: 56,
                              imageUrl: '${li2['img_url_webp']}',
                              placeholder: (context, url) => Container(
                                height: 56,
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
//                            Image.network(
//                              '${li2['img_url_webp']}',
//                              height: 56,
//                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15, bottom: 5),
                              child: Text(
                                '${li2['product_name']}',
                                style: TextStyle(),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  );
                  break;
              }
              return com;
            }).toList(),
          ),
        ],
      ),
    );
  }
}
