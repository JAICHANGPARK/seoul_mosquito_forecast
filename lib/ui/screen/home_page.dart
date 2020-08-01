import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_seoul_mosquito_forcast/model/mosquito.dart' as msq;
import 'package:flutter_seoul_mosquito_forcast/repository/mosquito_api.dart';
import 'package:intl/intl.dart' as intl;
import 'package:share/share.dart';

import 'web_view_page.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

List<String> images = [
  "assets/img/eastwood-36.png",
  "assets/img/eastwood-236.png",
  "assets/img/eastwood-knitting.png",
];

List<String> title = [
  "수변부",
  "공원",
  "주거지",
];

List<String> value = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = images.length - 1.0;

  PageController controller = PageController(initialPage: images.length - 1);
  String fetchDate;
  String _waterText;
  String _parkText;
  String _houseText;

  Future getMosquitoDate(DateTime datetime) async {
    String date = intl.DateFormat("yyyy-MM-dd").format(datetime);
    msq.Mosquito mosquito = await fetchMosquitoForecast(date);
    print(mosquito.mosquitoStatus == null);
    if (mosquito.mosquitoStatus == null) {
      date = intl.DateFormat("yyyy-MM-dd").format(datetime.add(Duration(days: -1)));
      mosquito = await fetchMosquitoForecast(date);
    }
    fetchDate = mosquito.mosquitoStatus.row[0].mOSQUITODATE;
    if (value.length > 0) value.clear();
    value.add(mosquito.mosquitoStatus.row[0].mOSQUITOVALUEWATER);
    value.add(mosquito.mosquitoStatus.row[0].mOSQUITOVALUEPARK);
    value.add(mosquito.mosquitoStatus.row[0].mOSQUITOVALUEHOUSE);

    _waterText = mosquito.mosquitoStatus.row[0].mOSQUITOVALUEWATER;
    _parkText = mosquito.mosquitoStatus.row[0].mOSQUITOVALUEPARK;
    _houseText = mosquito.mosquitoStatus.row[0].mOSQUITOVALUEHOUSE;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMosquitoDate(DateTime.now());
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16,right: 16, left: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "모기 예보",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/setting');
                      },
                      icon: Icon(Icons.settings),
                    )
                  ],
                ),
                Text("서울지역 모기발생 상황을 지수화하여 모기발생 단계별 시민행동요령을 알려주는 일일 모기발생 예보서비스입니다."),
                SizedBox(
                  height: 8,
                ),
                Align(alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(child: Text("기준일: $fetchDate",),
                    onTap: (){
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: Text("안내"),
                        content: Text("기준은을 정보 제공자로 부터 가장 최근의 정보를 가져오게됩니다. 기준일은 당일과 다소 차이가 발생할 수 있습니다."),
                        actions: [
                          ButtonBar(
                            children: [
                              FlatButton(
                                onPressed: ()=>Navigator.of(context).pop(),
                                child: Text("확인"),
                              )
                            ],
                          )
                        ],
                      ));
                    },),
                    IconButton(
                      onPressed: (){
                        Share.share("[주거지]:$_houseText, [공원]: $_parkText, [수변부]: $_waterText,"
                            "\n --모기예보 확인은 서울모기예보앱에서");
                      },
                      icon: Icon(Icons.share),
                      iconSize: 18,
                    )
                  ],
                )),

                value.length > 0
                    ? Stack(
                        children: <Widget>[
                          _CardScrollWidget(currentPage),
                          Positioned.fill(
                            child: PageView.builder(
                              itemCount: images.length,
                              controller: controller,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Container();
                              },
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        height: 160,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "정보",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ), SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "모기예보제란",
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text("자세히보기"),
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_right),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>WebViewExample(
                                      "https://news.seoul.go.kr/welfare/archives/511985",
                                      "모기예보제란"
                                    ))
                                  );
                                },
                              )
                            ],
                          ),
                          Divider(color: Colors.grey,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "모기감시자료",
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text("자세히보기"),
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_right),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>WebViewExample(
                                          "https://news.seoul.go.kr/welfare/mos_dmsnblt",
                                          "모기감시자료"
                                      ))
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 8.0;
  var verticalInset = 16.0;

  _CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;
          String _statusText = "";

          var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);
          if (double.parse(value[i]) < 30) {
            _statusText = "1단계(쾌적)";
          } else if (double.parse(value[i]) >= 30 && double.parse(value[i]) < 60) {
            _statusText = "2단계(관심)";
          } else if (double.parse(value[i]) >= 60 && double.parse(value[i]) < 90) {
            _statusText = "3단계(주의)";
          } else if (double.parse(value[i]) >= 90) {
            _statusText = "4단계(불쾌)";
          }

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                margin: EdgeInsets.only(right: 8, bottom: 8),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(3.0, 6.0),
                    blurRadius: 2.0,
                  ),
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        right: 16,
                        top: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              value[i],
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _statusText,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        child: Image.asset(
                          images[i],
                          fit: BoxFit.fitHeight,
                          height: height - 120,
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Text(title[i],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 12.0, bottom: 12.0),
//                              child: Container(
//                                padding: EdgeInsets.symmetric(
//                                    horizontal: 22.0, vertical: 6.0),
//                                decoration: BoxDecoration(
//                                    color: Colors.blueAccent,
//                                    borderRadius: BorderRadius.circular(20.0)),
//                                child: Text("Read Later",
//                                    style: TextStyle(color: Colors.white)),
//                              ),
//                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
