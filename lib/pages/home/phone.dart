import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/home-data-phone.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
//    _getPhone();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
//    _getPhone();
  }

  _getPhone() async {
    Response response = await Dio().post("http://api.m.mi.com/v1/home/Phone", data: {
      'page_id': 0,
      'Phone_type': 'SM-G9350',
      'tab_index': 0,
      'page_index': 1,
      'Phone_name':
          '1Od7ut7j9rYCOsgZFe9C6MBTzn%2FtRKo8gk94m4Afn9917kiB6RvdY0i9s%2B9eIWHxNy%2FKvmFGaj%2FQOTB0eOsUxGgAB5QJF%2BnK5PbGSnee5wg%3D'
    });
    if (mounted) {
      setState(() {
        data = response.data['data'];
      });
    }
  }

  _two(data, width) {
    return Wrap(
      spacing: 10,
      children: data.map<Widget>((item) {
        return Container(
          width: (width - 30) / 2,
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    '${item['img_url_webp'] == null ? item['img_url'] : item['img_url_webp']}',
                placeholder: (context, url) => Icon(Icons.image),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                height: 10,
              ),
              Text(
                '${item['product_name']}',
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${item['product_brief']}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Container(
//                                padding: EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '￥',
                          style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                        ),
                        Text(
                          '${item['product_price']}',
                          style: TextStyle(color: Color(0xffEA625B), fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      '起',
                      style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 4,
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Center(
                        child: Text(
                          '立即购买',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                color: Color(0xffEA625B),
                padding: EdgeInsets.all(0),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  _moreRow(data, width) {
    return Wrap(
      spacing: 4,
      children: data.map<Widget>((item) {
        return Container(
          padding: EdgeInsets.only(bottom: 15),
          width: (width - 4 * data.length) / data.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    '${item['img_url_webp'] == null ? item['img_url'] : item['img_url_webp']}',
                placeholder: (context, url) => Icon(Icons.image),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  '${item['product_name']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '￥',
                          style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                        ),
                        Text(
                          '${item['product_price']}',
                          style: TextStyle(color: Color(0xffEA625B), fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      '起',
                      style: TextStyle(color: Color(0xffEA625B), fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: data.isEmpty
            ? Container(
                child: Center(
                  child: Text('......'),
                ),
              )
            : ListView(
                children: <Widget>[
                  Column(
                    children: data['sections'].map<Widget>((item) {
                      Widget com = Container();
                      switch (item['view_type']) {
                        case 'gallery_custom':
                          com = Container(
                            height: width *
                                double.tryParse('${item['body']['h']}') /
                                double.tryParse('${item['body']['w']}'),
                            child: Swiper(
                              autoplay: true,
                              itemBuilder: (BuildContext context, int index) {
                                Map li = item['body']['items'][index];
                                return CachedNetworkImage(
                                  imageUrl:
                                      '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                  placeholder: (context, url) => Icon(Icons.image),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                );
                              },
                              itemCount: item['body']['items'].length,
                              pagination: new SwiperPagination(
                                  alignment: Alignment.bottomRight,
                                  builder: DotSwiperPaginationBuilder(activeColor: Colors.blue)),
                              //  control: new SwiperControl(),
                            ),
                          );
                          break;
                        case 'cells_auto_fill':
                          if (item['body']['items'].length == 5) {
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
                          } else if (item['body']['items'].length == 3) {
                            com = Container(
                              color: Color(0xffF5F4F4),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width / 2,
                                    padding: EdgeInsets.only(right: 2),
                                    child: Image.network(
                                        '${item['body']['items'][0]['img_url_webp']}'),
                                  ),
                                  Container(
                                      width: width / 2,
                                      padding: EdgeInsets.only(left: 2),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(bottom: 2),
                                            child: Image.network(
                                                '${item['body']['items'][1]['img_url_webp']}'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 1),
                                            width: width / 2,
                                            child: Image.network(
                                                '${item['body']['items'][2]['img_url_webp']}'),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            );
                          } else if (item['body']['items'].length == 2) {
                            com = Row(
                              children: item['body']['items'].map<Widget>((li) {
                                int index = item['body']['items'].indexOf(li);
                                return Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 0 : 4,
                                    right: index == 0 ? 4 : 0,
                                  ),
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
                          } else {
                            com = Column(
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
                          }

                          break;
                        case 'divider_line':
                          com = Container(
                            height: double.tryParse(
                                '${item['body']['line_height'] == '' ? 1 : item['body']['line_height']}'),
                            color: Color(int.tryParse(
                                '0xff${int.tryParse('${item['body']['line_color'].substring(1)}', radix: 16).toRadixString(16).toUpperCase()}')),
                          );
                          break;
                        case 'list_three_type2':
                        case 'list_three_type4':
                          com = _moreRow(item['body']['items'], width);
                          break;
                        case 'list_one_type14':
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
                                  Container(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                '${li['product_name']}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                '${li['product_brief']}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left: 10, top: 4, right: 15),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '￥',
                                                      style: TextStyle(
                                                          color: Color(0xffEA625B), fontSize: 10),
                                                    ),
                                                    Text(
                                                      '${li['product_price']}',
                                                      style: TextStyle(
                                                          color: Color(0xffEA625B), fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 15),
                                            width: 100,
                                            child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.only(top: 6, bottom: 6),
                                                  child: Center(
                                                    child: Text(
                                                      '立即购买',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                )),
                                            color: Color(0xffEA625B),
                                            padding: EdgeInsets.all(0),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                ],
                              );
                            }).toList(),
                          );
                          break;
                        case 'horizontal_recycler_list_goods2':
                          com = Container(
                            color: Colors.white,
                            height: 230,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: item['body']['items'].map<Widget>((li) {
                                return Container(
                                  width: 140,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        height: 126,
                                        imageUrl:
                                            '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                        placeholder: (context, url) => Icon(Icons.image),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '${li['product_name']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${li['product_brief']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '￥',
                                                  style: TextStyle(
                                                      color: Color(0xffEA625B), fontSize: 10),
                                                ),
                                                Text(
                                                  '${li['product_price']}',
                                                  style: TextStyle(
                                                      color: Color(0xffEA625B), fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '起',
                                              style:
                                                  TextStyle(color: Color(0xffEA625B), fontSize: 10),
                                            ),
                                            li['product_org_price'] != li['product_price']
                                                ? Text(
                                                    ' ￥${li['product_org_price']}',
                                                    style: TextStyle(
                                                      color: Color(0xff999999),
                                                      fontSize: 10,
                                                      decorationStyle: TextDecorationStyle.solid,
                                                      decoration: TextDecoration.lineThrough,
                                                      decorationColor: Color(0xffAAAAAA),
                                                    ),
                                                  )
                                                : Text(''),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.only(top: 3, bottom: 3),
                                              child: Center(
                                                child: Text(
                                                  '立即购买',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            )),
                                        color: Color(0xffEA625B),
                                        margin: EdgeInsets.only(top: 4),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                          break;
                        case 'list_two_type13':
                          com = _two(item['body']['items'], width);
                          break;
                        case 'horizontal_tab_recycler_list_item2':
                          com = Wrap(
                            children: item['body']['items'].map<Widget>((lis) {
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 12, bottom: 15),
                                      child: Text(
                                        '${lis['title']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    _two(lis['product_list'], width)
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
      ),
    );
  }
}
