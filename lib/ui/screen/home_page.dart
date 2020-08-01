import 'package:flutter/material.dart';
import 'package:flutter_seoul_mosquito_forcast/repository/mosquito_api.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMosquitoForecast();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
