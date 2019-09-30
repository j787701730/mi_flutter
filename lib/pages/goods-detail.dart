import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'data/goods-detail.dart';

class GoodsDetail extends StatefulWidget {
  @override
  _GoodsDetailState createState() => _GoodsDetailState();
}

class _GoodsDetailState extends State<GoodsDetail> {
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
                )
              ],
            ),
          ),
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
