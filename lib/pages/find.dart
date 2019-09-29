import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
//        titleSpacing: 0,
        actions: <Widget>[
          Container(
            width: 56,
            child: Center(
              child: Icon(
                Icons.message,
                size: 24,
              ),
            ),
          )
        ],
        elevation: 0,
//        bottom: TabBar(
//          controller: controller,
//          isScrollable: false,
//          labelPadding: EdgeInsets.zero,
//          indicatorPadding: EdgeInsets.only(left: 8, right: 8),
//          labelColor: selectColor,
//          unselectedLabelColor: Color(int.tryParse(
//              '0xff${int.tryParse('${tabs[tabIndex]['word_unselected_color'].substring(1)}', radix: 16).toRadixString(16).toUpperCase()}')),
//          indicatorColor: selectColor,
//          tabs: tabs.map<Tab>((item) {
//            return Tab(
//              text: '${item['tab_name']}',
//            );
//          }).toList(),
//          onTap: (index) {
//            setState(() {
//              tabIndex = index;
//            });
//            _pageController.jumpToPage(index); // 与PageView的互动
//          },
//        ),
      ),
    );
  }
}
