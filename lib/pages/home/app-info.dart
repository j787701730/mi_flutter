import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart';
import '../data/home-data0.dart';

class AppInfo extends StatefulWidget {
  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
//    _getAppInfo();
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
//    _getAppInfo();
  }

  _getAppInfo() async {
    Response response = await Dio().post("http://api.m.mi.com/v1/home/appInfo", data: {
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
              Image.network('${item['img_url_webp']}'),
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
                  Container(
                    height: width * 540 / 1080,
                    child: Swiper(
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                          "${data['sections'][0]['body']['items'][index]['img_url_webp']}",
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: data['sections'][0]['body']['items'].length,
                      pagination: new SwiperPagination(
                          alignment: Alignment.bottomRight,
                          builder: DotSwiperPaginationBuilder(activeColor: Colors.blue)),
//                      control: new SwiperControl(),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: data['sections'][1]['body']['items'].map<Widget>((item) {
                        return Container(
                          width: width / 5,
                          child: Image.network('${item['img_url_webp']}'),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 24,
                  ),
                  Container(
                    color: Color(0xffF5F4F4),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: width / 2,
                          padding: EdgeInsets.only(right: 2),
                          child: Image.network(
                              '${data['sections'][5]['body']['items'][0]['img_url_webp']}'),
                        ),
                        Container(
                            width: width / 2,
                            padding: EdgeInsets.only(left: 2),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: Image.network(
                                      '${data['sections'][5]['body']['items'][1]['img_url_webp']}'),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 1),
                                  width: width / 2,
                                  child: Image.network(
                                      '${data['sections'][5]['body']['items'][2]['img_url_webp']}'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 24,
                    color: Color(0xffF5F5F5),
                  ),
                  Container(
                    child: Column(
                      children: data['sections'][7]['body']['items'].map<Widget>((item) {
                        return Container(
                          child: Image.network('${item['img_url_webp']}'),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 24,
                    color: Color(0xffF5F5F5),
                  ),
                  Container(
                    height: width * 120 / 1080,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('${data['sections'][9]['body']['img_url_webp']}'))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${data['sections'][9]['body']['title_desc']}',
                          style: TextStyle(
                              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
                      children: data['sections'][9]['body']['items'].map<Widget>((item) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 160,
                                height: 160,
                                child: Image.network('${item['img_url']}'),
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
                                          style: TextStyle(color: Color(0xffED5B00), fontSize: 10),
                                        ),
                                        Text(
                                          '${item['product_price']}',
                                          style: TextStyle(color: Color(0xffED5B00), fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '￥${item['product_org_price']}',
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
                  ),
                  Container(
                    height: 24,
                    color: Color(0xffF5F5F5),
                  ),
                  Container(
                    child: Column(
                      children: data['sections'][11]['body']['items'].map<Widget>((item) {
                        return Container(
                          child: Image.network('${item['img_url_webp']}'),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 24,
                    color: Color(0xffF5F5F5),
                  ),
                  Container(
                    child: Column(
                      children: data['sections'][13]['body']['items'].map<Widget>((item) {
                        return Container(
                          child: Image.network('${item['img_url_webp']}'),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 24,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: _two(data['sections'][15]['body']['items'], width),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: _two(data['sections'][16]['body']['items'], width),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: _two(data['sections'][18]['body']['items'], width),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: _two(data['sections'][20]['body']['items'], width),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: _two(data['sections'][22]['body']['items'], width),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: _two(data['sections'][24]['body']['items'], width),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Color(0xffEDEDED), width: 1)),
                        color: Colors.white),
                    height: 34,
                    child: Center(
                      child: Text('更多手机产品 >'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
