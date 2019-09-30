import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/home-data0.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
//    _getRecommend();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
//    _getRecommend();
  }

  _getRecommend() async {
    Response response = await Dio().post("http://api.m.mi.com/v1/home/Recommend", data: {
      'page_id': 0,
      'phone_type': 'SM-G9350',
      'tab_index': 0,
      'page_index': 1,
      'phone_name':
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
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
                        case 'gallery_540':
                          com = Container(
                            height: width * 540 / 1080,
                            child: Swiper(
                              autoplay: true,
                              itemBuilder: (BuildContext context, int index) {
                                return new Image.network(
                                  "${item['body']['items'][index]['img_url_webp']}",
                                  fit: BoxFit.fill,
                                );
                              },
                              itemCount: data['sections'][0]['body']['items'].length,
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
                        case 'list_new_red_packet':
                        case 'list_eco_pub_1':
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
                          break;
                        case 'list_seckill':
                          com = Column(
                            children: <Widget>[
                              Container(
                                height: width * 120 / 1080,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${data['sections'][9]['body']['img_url_webp']}'))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '${data['sections'][9]['body']['title_desc']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      color: Color(0xff505050),
                                      child: Text(
                                        '01',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Text(':'),
                                    Container(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      color: Color(0xff505050),
                                      child: Text(
                                        '01',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Text(':'),
                                    Container(
                                      padding: EdgeInsets.only(left: 2, right: 2),
                                      color: Color(0xff505050),
                                      child: Text(
                                        '01',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 200,
                                color: Colors.white,
                                child: ListView(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  children: item['body']['items'].map<Widget>((li) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 160,
                                            height: 160,
                                            child: Image.network('${li['img_url']}'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '￥',
                                                      style: TextStyle(
                                                          color: Color(0xffED5B00), fontSize: 10),
                                                    ),
                                                    Text(
                                                      '${li['product_price']}',
                                                      style: TextStyle(
                                                          color: Color(0xffED5B00), fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '￥${li['product_org_price']}',
                                                  style: TextStyle(
                                                      decorationStyle: TextDecorationStyle.solid,
                                                      decoration: TextDecoration.lineThrough,
                                                      decorationColor: Color(0xffAAAAAA),
                                                      color: Color(0xffAAAAAA),
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          );
                          break;
                        case 'list_two_type13':
                        case 'list_two_type1':
                          com = Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: _two(item['body']['items'], width),
                          );
                          break;
                        case 'list_action_title':
                          com = Column(
                            children: item['body']['items'].map<Widget>((li) {
                              return Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text('${li['action_title']} > '),
                                ),
                              );
                            }).toList(),
                          );
                          break;
                        case 'list_one_video3':
                          com = Column(
                            children: item['body']['items'].map<Widget>((li) {
                              return CachedNetworkImage(
                                imageUrl:
                                    '${li['img_url_webp'] == null ? li['img_url'] : li['img_url_webp']}',
                                placeholder: (context, url) => Icon(Icons.image),
                                errorWidget: (context, url, error) => Icon(Icons.error),
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
