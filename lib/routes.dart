import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mesa_news_app/screens/home/news_view/page.dart';
import 'package:mesa_news_app/screens/home/page.dart';
import 'package:mesa_news_app/screens/singin/page.dart';
import 'package:mesa_news_app/screens/wellcome/wellcome_page.dart';

Map<String,WidgetBuilder> appRoutes = {
  "wellcome/" :  (_)=>WellcomePage(),
  "singin/" :  (_)=>SinginPage(),
  "home/" :  (_)=>HomePage(),
  "home/news/" :  (_)=>NewsViewPage(),
};