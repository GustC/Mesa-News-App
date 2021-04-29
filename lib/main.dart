import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mesa_news_app/app.dart';
import 'package:mesa_news_app/constants/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: primaryColor,      
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MesaNewsApp());
}
