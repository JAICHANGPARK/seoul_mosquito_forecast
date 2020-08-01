import 'package:flutter/material.dart';

import 'web_view_page.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16,),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 38,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                Text("설정",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
              ],
            ),
            ListTile(
              title: Text("정보제공기관"),
              subtitle: Text("서울특별시"),
            ),
            Divider(color: Colors.grey,),
            ListTile(
              title: Text("제공부서"),
              subtitle: Text("시민건강국 질병관리과"),
            ),
            Divider(color: Colors.grey,),
            ListTile(
              title: Text("개발자"),
              subtitle: Text("박제창(@Dreamwalker)"),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>WebViewExample(
                        "https://github.com/JAICHANGPARK", "개발자페이지"
                    ))
                );
              },
            ),
            Divider(color: Colors.grey,),
            Spacer(),
            Image.asset("assets/img/eastwood-no-comments.png")
            
          ],
        ),
      ),
    );
  }
}
