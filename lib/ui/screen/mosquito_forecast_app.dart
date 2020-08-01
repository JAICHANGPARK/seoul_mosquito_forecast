import 'package:flutter/material.dart';

import 'home_page.dart';
import 'setting_page.dart';


class MosquitoForecastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "서울모기예보",
      initialRoute: "/",
      routes: {
        "/" : (context) => HomePage(),
        "/setting" : (context) => SettingPage(),
      },
    );
  }
}
