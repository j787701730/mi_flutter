import 'package:flutter/material.dart';
import 'package:mi_flutter/pages/data/find-data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
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
        child: ListView(
          children: <Widget>[
            Column(
              children: data.map<Widget>((item) {
                Widget com = Container();
                switch (item['view_type']) {
                  case 'gallery_custom':
                    com = Column(
                      children: item['body']['items'].map<Widget>((li) {
                        return CachedNetworkImage(
                          imageUrl: '${li['img_url_webp']}',
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        );
                      }).toList(),
                    );
                    break;
                  case 'cells_auto_fill':
                  case 'horizontal_list_item_radius':
                    com = Row(
                      children: item['body']['items'].map<Widget>((li) {
                        return Container(
                          width: width / item['body']['items'].length,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                            placeholder: (context, url) => Icon(Icons.image),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        );
                      }).toList(),
                    );
                    break;
                  case 'divider_line':
                    com = Container(
                      height: double.tryParse(
                          '${item['body']['line_height'] == '' ? 1 : item['body']['line_height']}'),
                      color: Color(int.tryParse(
                          '0xff${int.tryParse('${item['body']['line_color'].substring(1)}', radix: 16).toRadixString(16).toUpperCase()}')),
                    );
                    break;
                  case 'list_one_type4':
                    if (item['stat'] == 'mihome') {
                      com = Column(
                        children: item['body']['items'].map<Widget>((li) {
                          return Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: CachedNetworkImage(
                                  height: 70,
                                  width: 112,
                                  imageUrl:
                                      '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                  placeholder: (context, url) => Icon(Icons.error),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${li['title']}',style: TextStyle(
                                    color: Colors.black
                                  ),),
                                  Text('${li['subtitle']}',
                                      style: TextStyle(
                                          color: Color(0xff6F6F6F), fontSize: 12)),
                                ],
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 3),
                                        child: Text('${li['action_desc']}',
                                            style: TextStyle(
                                                color: Color(0xff6F6F6F), fontSize: 12)),
                                      ),
                                      Icon(Icons.keyboard_arrow_right,color: Color(0xff6F6F6F),),
                                      Container(
                                        width: 15,
                                      )
                                    ],
                                  ))
                            ],
                          );
                        }).toList(),
                      );
                    }
                    break;
                  case 'list_one_type7':
                    if (item['stat'] == 'news') {
                      com = Column(
                        children: item['body']['items'].map<Widget>((li) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl:
                                    '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                placeholder: (context, url) => Icon(Icons.error),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 4),
                                child: Text(
                                  '${li['title']}',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  '${li['desc']}',
                                  style: TextStyle(color: Color(0xff6F6F6F)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${li['date_desc']}',
                                      style: TextStyle(color: Color(0xff6F6F6F), fontSize: 12),
                                    ),
                                    Text(
                                      '${li['favor_desc']}',
                                      style: TextStyle(color: Color(0xff6F6F6F), fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }
                    break;
                  case 'list_one_type9':
                    com = Column(
                      children: item['body']['items'].map<Widget>((li) {
                        return Column(
                          children: <Widget>[
                            Container(
                              width: width / item['body']['items'].length,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                placeholder: (context, url) => Icon(Icons.image),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15, right: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text('${li['product_name']}'),
                                          ),
                                          Container(
                                            child: Text('${li['product_brief']}',
                                                style: TextStyle(
                                                    color: Color(0xff6F6F6F), fontSize: 12)),
                                          ),
                                        ],
                                      ),
                                    )),
                                Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '￥',
                                        style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                                      ),
                                      Text(
                                        '${li['product_price']}',
                                        style: TextStyle(color: Color(0xffEA625B), fontSize: 16),
                                      ),
                                      li["show_price_qi"] == true
                                          ? Text(
                                              '起',
                                              style:
                                                  TextStyle(color: Color(0xffEA625B), fontSize: 10),
                                            )
                                          : Container()
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 15,
                            )
                          ],
                        );
                      }).toList(),
                    );
                    break;
                  case 'list_two_type1':
                  case 'list_two_type2':
                  case 'list_two_type3':
                  case 'list_two_type5':
                  case 'list_one_type10':
                  case 'list_two_type11':
                  case 'list_two_type12':
                    com = Row(
                      children: item['body']['items'].map<Widget>((li) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width * double.tryParse('${li['img_percent']}'),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                placeholder: (context, url) => Icon(Icons.image),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text('${li['product_name']}'),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, bottom: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '￥',
                                    style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                                  ),
                                  Text(
                                    '${li['product_price']}',
                                    style: TextStyle(color: Color(0xffEA625B), fontSize: 16),
                                  ),
                                  li["show_price_qi"] == true
                                      ? Text(
                                          '起',
                                          style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                    break;
                }
                return com;
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
