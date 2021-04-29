import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mesa_news_app/app_controller.dart';
import 'package:mesa_news_app/constants/colors.dart';
import 'package:mesa_news_app/routes.dart';
import 'package:mesa_news_app/screens/wellcome/wellcome_page.dart';

class MesaNewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppController _appController = Get.put(AppController());
    return GetMaterialApp(
      title: 'Mesa News',
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
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto"
          ),     
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WellcomePage(),
      initialRoute: "wellcome/",
      routes: appRoutes,
      builder: (ctx,w){        
        return GetBuilder(
          init: _appController,
          initState: (_){            
            _appController.checkUser();            
          },
          builder: (controller){
            return Stack(
              children: [
                w,
                Visibility(
                  visible: !_appController.isConnected,
                  child: renderModalNotConnection(),
                ),
              ],
            ); 
          },
        );
      },
    );
  }

  Widget renderModalNotConnection(){
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Aguardando conexão...",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
