import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mesa_news_app/constants/colors.dart';
import 'package:mesa_news_app/routes.dart';
import 'package:mesa_news_app/screens/wellcome/wellcome_page.dart';

class MesaNewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mesa News',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: "Roboto",        
        appBarTheme: AppBarTheme(
          color: primaryColor,
          centerTitle: true,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),  
          elevation: 0,   
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "roboto"
          )     
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WellcomePage(),
      initialRoute: "wellcome/",
      routes: appRoutes,
    );
  }
}
