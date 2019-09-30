import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_flutter/pages/home/recommend.dart';
import 'package:mi_flutter/pages/home/intelligence.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  int tabIndex = 0;
  List tabs = [
    {
      "tab_name": "推荐",
      "tab_api": "home/appInfo",
      "word_selected_color": "#8472bc",
      "word_unselected_color": "#747474",
      "bg_img": "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/431bf705342c40bcf81b2e396455ffe2.jpg",
      "bg_img_webp":
          "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/431bf705342c40bcf81b2e396455ffe2.jpg?f=webp",
      "params": {"page_id": "0", "tab_index": "0"},
    },
    {
      "tab_name": "手机",
      "tab_api": "home/activity_page",
      "tab_index": 1,
      "word_selected_color": "#ed5b00",
      "word_unselected_color": "#747474",
      "bg_img": "",
      "bg_img_webp": "",
      "params": {"page_id": "8221", "tab_index": "1", "version": "8221"}
    },
    {
      "tab_name": "智能",
      "tab_api": "home/activity_page",
      "tab_index": 2,
      "word_selected_color": "#ed5b00",
      "word_unselected_color": "#747474",
      "bg_img": "",
      "bg_img_webp": "",
      "params": {"page_id": "8671", "tab_index": "2", "version": "8671"}
    },
    {
      "tab_name": "电视",
      "tab_api": "home/activity_page",
      "tab_index": 3,
      "word_selected_color": "#ed5b00",
      "word_unselected_color": "#747474",
      "bg_img": "",
      "bg_img_webp": "",
      "params": {"page_id": "11022", "tab_index": "3", "version": "11022"}
    },
    {
      "tab_name": "笔记本",
      "tab_api": "home/activity_page",
      "tab_index": 4,
      "word_selected_color": "#ed5b00",
      "word_unselected_color": "#747474",
      "bg_img": "",
      "bg_img_webp": "",
      "params": {"page_id": "11825", "tab_index": "4", "version": "11825"}
    },
    {
      "tab_name": "家电",
      "tab_api": "home/activity_page",
      "tab_index": 5,
      "word_selected_color": "#ed5b00",
      "word_unselected_color": "#747474",
      "bg_img": "",
      "bg_img_webp": "",
      "params": {"page_id": "11033", "tab_index": "5", "version": "11033"}
    },
    {
      "tab_name": "生活周边",
      "tab_api": "home/tab_page",
      "tab_index": 6,
      "word_selected_color": "#ed5b00",
      "word_unselected_color": "#747474",
      "bg_img": "",
      "bg_img_webp": "",
      "params": {"page_id": "1697", "tab_index": "6"}
    }
  ];
  PageController _pageController;
  var tabView = [
    Recommend(),
    Container(),
    Intelligence(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(initialIndex: 0, length: tabs.length, vsync: this);
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
    Color selectColor = Color(int.tryParse(
        '0xff${int.tryParse('${tabs[tabIndex]['word_selected_color'].substring(1)}', radix: 16).toRadixString(16).toUpperCase()}'));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tabs[tabIndex]['bg_img'] == '' ? Colors.white : Color(0xffCEE9FD),
        leading: Container(
          width: 56,
          child: Center(
            child: Image.network(
              tabIndex == 0
                  ? 'https://i8.mifile.cn/b2c-mimall-media/171fa9c4374c42c0329b96265991bd64.png'
                  : 'http://i8.mifile.cn/b2c-mimall-media/b213dce6ff38eb83234ee4088bd3066f.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
        title: Text('Home'),
//        titleSpacing: 0,
        actions: <Widget>[
          Container(
            width: 56,
            child: Center(
              child: Icon(
                Icons.message,
                color: tabIndex == 0 ? Colors.white : Color(0xffBBBBBB),
                size: 24,
              ),
            ),
          )
        ],
        elevation: 0,
        bottom: TabBar(
          controller: controller,
          isScrollable: false,
          labelPadding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.only(left: 8, right: 8),
          labelColor: selectColor,
          unselectedLabelColor: Color(int.tryParse(
              '0xff${int.tryParse('${tabs[tabIndex]['word_unselected_color'].substring(1)}', radix: 16).toRadixString(16).toUpperCase()}')),
          indicatorColor: selectColor,
          tabs: tabs.map<Tab>((item) {
            return Tab(
              text: '${item['tab_name']}',
            );
          }).toList(),
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
            _pageController.jumpToPage(index); // 与PageView的互动
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
//        physics: NeverScrollableScrollPhysics(), // 禁止左右滑动
        children: tabs.map<Widget>((item) {
          int idx = tabs.indexOf(item);
          return Container(
            color: tabs[idx]['bg_img'] == '' ? Colors.white : Color(0xffCEE9FD),
            child: tabView[idx],
          );
        }).toList(),
        onPageChanged: (index) {
          setState(() {
            tabIndex = index;
          });
          controller.animateTo(index); // 与TabBar的互动
        },
      ),
    );
  }
}
