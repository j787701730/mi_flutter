import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'data/goods-detail.dart';

class GoodsDetail extends StatefulWidget {
  @override
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
  Map instalment = {};
  List buyOption = [];
  int instalmentIndex = 0;

  @override
  void initState() {
    super.initState();
    instalment = data['goods_info'][0]['instalment'];
    buyOption = data['buy_option'];
  }

  instalmentWidget(width, context) {
    return instalment.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text('分期'),
                Container(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context1, state) {
                                /// 这里的state就是setState
                                return Container(
                                  height: 400,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 10,
                                                child: Container(
                                                  color: Colors.white,
                                                  width: width,
                                                  height: 90,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 110, top: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              '￥',
                                                              style: TextStyle(
                                                                  color: Color(0xffFE5C43),
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              '3799',
                                                              style: TextStyle(
                                                                  color: Color(0xffFE5C43),
                                                                  fontSize: 22),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          child: Text('小米9 Pro 5G 8GB+256GB 钛银黑'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Positioned(
                                                left: 10,
                                                top: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(0xffD5D5D5), width: 1),
                                                      borderRadius:
                                                          BorderRadius.all(Radius.circular(3))),
                                                  child: CachedNetworkImage(
                                                    width: 90,
                                                    height: 90,
                                                    fit: BoxFit.fitWidth,
                                                    imageUrl:
                                                        'https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1569242567.71764421.jpg?w=720&h=721&thumb=1',
                                                    placeholder: (context, url) =>
                                                        Icon(Icons.image),
                                                    errorWidget: (context, url, error) =>
                                                        Icon(Icons.error),
                                                  ),
                                                )),
                                            Positioned(
                                              right: 10,
                                              top: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: Color(0xffA5A5A5),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        width: width,
                                        height: 40,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: instalment['list'].map<Widget>((item) {
                                              int index = instalment['list'].indexOf(item);
                                              return GestureDetector(
                                                onTap: () {
                                                  state(() {
                                                    ///为了区分把setState改个名字
                                                    instalmentIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  width: width / 2 - 20,
                                                  decoration: BoxDecoration(
                                                      color: instalmentIndex == index
                                                          ? Color(0xffF2F2F2)
                                                          : Colors.white,
                                                      border: Border.all(
                                                          color: Color(0xffD5D5D5), width: 1)),
                                                  child: Center(
                                                    child: Text(
                                                      '${item['title']}',
                                                      style: TextStyle(
                                                        color: instalmentIndex == index
                                                            ? Color(0xffFE5C43)
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 220,
                                        color: Colors.white,
                                        child: ListView(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: instalment['list'].map<Widget>((item) {
                                                int index = instalment['list'].indexOf(item);
                                                return Offstage(
                                                  offstage: instalmentIndex != index,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 15, right: 15),
                                                    width: width,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:
                                                          item['detail'].map<Widget>((detail) {
                                                        return InkWell(
                                                          onTap: () {
                                                            Map temp = instalment;
                                                            for (int idx = 0;
                                                                idx <
                                                                    temp['list'][index]['detail']
                                                                        .length;
                                                                idx++) {
                                                              if (idx ==
                                                                  item['detail'].indexOf(detail)) {
                                                                temp['list'][index]['detail'][idx]
                                                                    ['checked'] = true;
                                                              } else {
                                                                temp['list'][index]['detail'][idx]
                                                                    ['checked'] = false;
                                                              }
                                                            }
                                                            state(() {
                                                              instalment = temp;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: width,
                                                            height: 70,
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: item['detail']
                                                                                    .indexOf(
                                                                                        detail) ==
                                                                                item['detail']
                                                                                        .length -
                                                                                    1
                                                                            ? Colors.white
                                                                            : Color(0xffEBEBEB)))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      '${detail['stage_cost']}元X${detail['stage']}期',
                                                                      style: TextStyle(
                                                                          color: detail[
                                                                                      'checked'] ==
                                                                                  true
                                                                              ? Color(0xffFF6F33)
                                                                              : Colors.black),
                                                                    ),
                                                                    Text(
                                                                      '手续费 ${detail['stage_interest']}元/期',
                                                                      style: TextStyle(
                                                                          color: detail[
                                                                                      'checked'] ==
                                                                                  true
                                                                              ? Color(0xffFF6F33)
                                                                              : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                                Container(
                                                                  width: 18,
                                                                  height: 18,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Color(0xffEDEDED),
                                                                          width: 1),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(18))),
                                                                  child: Center(
                                                                    child: Container(
                                                                      width: 12,
                                                                      height: 12,
                                                                      decoration: BoxDecoration(
                                                                          color: detail[
                                                                                      'checked'] ==
                                                                                  true
                                                                              ? Color(0xffFF6F33)
                                                                              : Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                                  Radius.circular(
                                                                                      18))),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xffFF6F33),
                                        height: 40,
                                        width: width,
                                        child: Center(
                                          child: Text(
                                            '到货通知',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children:
                                data['goods_info'][0]['instalment']['list'].map<Widget>((item) {
                              return Container(
                                child: Text(
                                    '${item['title']}${data['goods_info'][0]['instalment']['list'].indexOf(item) < data['goods_info'][0]['instalment']['list'].length - 1 ? '/' : ''}'),
                              );
                            }).toList(),
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ))
              ],
            ),
          );
  }

  optionWidget(width, context) {
    return buyOption.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text('已选'),
                Container(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context1, state) {
                                /// 这里的state就是setState
                                return Container(
                                  height: 400,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 10,
                                                child: Container(
                                                  color: Colors.white,
                                                  width: width,
                                                  height: 90,
                                                  child: Container(
                                                    padding: EdgeInsets.only(left: 110, top: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              '￥',
                                                              style: TextStyle(
                                                                  color: Color(0xffFE5C43),
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              '3799',
                                                              style: TextStyle(
                                                                  color: Color(0xffFE5C43),
                                                                  fontSize: 22),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          child: Text('小米9 Pro 5G 8GB+256GB 钛银黑'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            Positioned(
                                                left: 10,
                                                top: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(0xffD5D5D5), width: 1),
                                                      borderRadius:
                                                          BorderRadius.all(Radius.circular(3))),
                                                  child: CachedNetworkImage(
                                                    width: 90,
                                                    height: 90,
                                                    fit: BoxFit.fitWidth,
                                                    imageUrl:
                                                        'https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1569242567.71764421.jpg?w=720&h=721&thumb=1',
                                                    placeholder: (context, url) =>
                                                        Icon(Icons.image),
                                                    errorWidget: (context, url, error) =>
                                                        Icon(Icons.error),
                                                  ),
                                                )),
                                            Positioned(
                                              right: 10,
                                              top: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: Color(0xffA5A5A5),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 260,
                                        color: Colors.white,
                                        width: width,
                                        padding: EdgeInsets.only(
                                          left: 15,right: 15
                                        ),
                                        child: ListView(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: buyOption.map<Widget>((item) {
                                                int index = 0;
                                                return  Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text('${item['name']}',style: TextStyle(
                                                          color: Colors.black,fontSize: 20
                                                        ),),
                                                      ),
                                                      Column(
                                                        children: item['list'].map<Widget>((list) {
                                                            return Container(
                                                              height: 56,
                                                              padding: EdgeInsets.only(
                                                                left: 15,
                                                                right: 15
                                                              ),
                                                              margin: EdgeInsets.only(
                                                                bottom: 10
                                                              ),
                                                              decoration: BoxDecoration(
                                                                border: Border.all(
                                                                  style: BorderStyle.solid
                                                                ),
                                                                  boxShadow: [BoxShadow(color: Color(0x99FFFF00), offset: Offset(5.0, 5.0),    blurRadius: 10.0, spreadRadius: 2.0), BoxShadow(color: Color(0x9900FF00), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0xFF0000FF))],

                                                              ),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text('${list['name']}'),
                                                              ),
                                                            );
                                                        }).toList(),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xffFF6F33),
                                        height: 40,
                                        width: width,
                                        child: Center(
                                          child: Text(
                                            '暂时缺货',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[Text('小米9 Pro 5G 8GB+256GB 钛银黑X1')],
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ))
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        elevation: 0,
//      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 44,
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  height: width,
                  child: Swiper(
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CachedNetworkImage(
                        width: width,
                        fit: BoxFit.fitWidth,
                        imageUrl: '${data['view_content']['galleryView']['galleryViewV2'][index]}',
                        placeholder: (context, url) => Icon(Icons.image),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      );
                    },
                    itemCount: data['view_content']['galleryView']['galleryViewV2'].length,
                    pagination: new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(activeColor: Colors.blue)),
                  ),
                ),
                Container(
                  height: 44,
                  color: Color(0xffFE5C43),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 15,
                            height: 1,
                          ),
                          Text(
                            '￥',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            '3799',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                      Container(
                        height: 44,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Color(0xffFFE655),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '距预约结束',
                              style: TextStyle(fontSize: 10, color: Color(0xffFF5E00)),
                            ),
                            Container(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '1天 ',
                                  style: TextStyle(fontSize: 10, color: Color(0xff5B3310)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 2, right: 2, top: 3, bottom: 3),
                                  decoration: BoxDecoration(
                                      color: Color(0xff6C4517),
                                      borderRadius: BorderRadius.all(Radius.circular(3))),
                                  child: Text(
                                    '18',
                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(fontSize: 10, color: Color(0xff5B3310)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 2, right: 2, top: 3, bottom: 3),
                                  decoration: BoxDecoration(
                                      color: Color(0xff6C4517),
                                      borderRadius: BorderRadius.all(Radius.circular(3))),
                                  child: Text(
                                    '18',
                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  ':',
                                  style: TextStyle(fontSize: 10, color: Color(0xff5B3310)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 2, right: 2, top: 3, bottom: 3),
                                  decoration: BoxDecoration(
                                      color: Color(0xff6C4517),
                                      borderRadius: BorderRadius.all(Radius.circular(3))),
                                  child: Text(
                                    '18',
                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 4),
                  child: Text(
                    '小米9 Pro 5G',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 4),
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: '「10月2日上午10点再次开售，分期享6期免息」',
                        style: TextStyle(color: Color(0xffff4a00))),
                    TextSpan(
                        text:
                            '5G双卡全网通超高速网络 / 骁龙855Plus旗舰处理器 / 40W有线闪充+30W无线闪充+10W无线反充，4000mAh长续航 / 4800万全焦段三摄 / 超振感横向线性马达 / VC液冷散热 / 高色准三星AMOLED屏幕 / 多功能NFC / 赠送小米云服务1TB云存储',
                        style: TextStyle(color: Color(0xff7B7B7B)))
                  ])),
                ),
                Container(
                  height: 1,
                  color: Color(0xffEEEEEE),
                  margin: EdgeInsets.only(left: 15, right: 15),
                ),
                // 分期
                instalmentWidget(width, context),
                Container(
                  height: 10,
                  color: Color(0xffEEEEEE),
                ),
                // 配置
                optionWidget(width, context),
                Container(
                  height: 10,
                  color: Color(0xffEEEEEE),
                ),
              ],
            ),
          ),
          // 底部菜单栏
          Positioned(
              left: 0,
              bottom: 0,
              height: 44,
              width: width,
              child: Container(
                height: 44,
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Color(0xffEBEBEB), width: 1),
                        right: BorderSide(color: Color(0xffEBEBEB), width: 1),
                      )),
                      width: 70,
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Color(0xff636363),
                          ),
                          Text(
                            '喜欢',
                            style: TextStyle(fontSize: 12, color: Color(0xff1E1E1E)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Color(0xffEBEBEB), width: 1),
                      )),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.add_shopping_cart,
                            size: 20,
                            color: Color(0xff636363),
                          ),
                          Text(
                            '购物车',
                            style: TextStyle(fontSize: 12, color: Color(0xff1E1E1E)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Color(0xffFF6F33),
                          child: Center(
                            child: Text(
                              '立即预约',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
