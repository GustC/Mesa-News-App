import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mesa_news_app/screens/wellcome/wellcome_page.dart';

class MesaNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WellcomePage(),
    );
  }
}
