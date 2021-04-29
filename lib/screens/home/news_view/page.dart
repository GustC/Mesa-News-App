import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mesa_news_app/screens/home/models/model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsViewPage extends StatefulWidget {
  News news;
  NewsViewPage(this.news);
  @override
  _NewsViewPageState createState() => _NewsViewPageState(this.news);
}

class _NewsViewPageState extends State<NewsViewPage> {
  News news;
  _NewsViewPageState(this.news);
  @override
  void initState() {    
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              news.title,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            Text(
              "mesanews.com.br",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),    
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.white, 
          onPressed: ()=>Navigator.of(context).pop(),
        ),  
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_horiz),
          ),
        ],  
      ),
      body: WebView(
        initialUrl: news.url,
        onPageFinished: (_)=>setState((){}),
        onPageStarted: (_)=>setState((){}),
      ),
    );
  }
}