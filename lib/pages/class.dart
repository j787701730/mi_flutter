import 'package:flutter/material.dart';
import './data/class-data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Class extends StatefulWidget {
  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> with SingleTickerProviderStateMixin {
  PageController _pageController;
  TabController controller;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: data.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('发现'),
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
              width: 100,
              child: ListView(
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
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Container(
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
                        )),
                  );
                }).toList(),
//                children: <Widget>[
//                  TabBar(
//                    controller: controller,
//                    isScrollable: false,
//                    labelPadding: EdgeInsets.zero,
//                    indicatorPadding: EdgeInsets.only(left: 8, right: 8),
//                    labelColor: Color(0xffED5B00),
//                    unselectedLabelColor: Color(0xff1E1E1E),
//                    indicatorColor: Color(0xffED5B00),
//                    tabs: data.map<Tab>((item) {
//                      return Tab(
//                        text: '${item['category_name']}',
//                      );
//                    }).toList(),
//                    onTap: (index) {
//                      setState(() {
//                        tabIndex = index;
//                      });
//                      _pageController.jumpToPage(index); // 与PageView的互动
//                    },
//                  )
//                ],
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
                    });
                    controller.animateTo(index); // 与TabBar的互动
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

class _ComState extends State<Com> {
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragStart: (xx) {
        setState(() {
          scro = true;
        });
      },
      onHorizontalDragDown: (DragDownDetails xxx) {
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
