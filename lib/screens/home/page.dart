import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mesa_news_app/constants/colors.dart';
import 'package:mesa_news_app/screens/home/controller.dart';
import 'package:mesa_news_app/screens/home/models/model.dart';

class HomePage extends StatelessWidget {
  Size deviceSize;
  HomePageController _controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mesa News",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: GetBuilder(
        init: _controller,
        initState: (_){
          _controller.getNews();
        },
        builder: (_) {
          if(_controller.loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return renderListNews();
        }
      ),
    );
  }

  Widget renderListNews(){
    List<Widget> news = _controller.news.map<Widget>(renderTileNews).toList();
    return RefreshIndicator(      
      onRefresh: () {  
        return Future.value(false);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification info) {
          if (info.metrics.pixels == info.metrics.maxScrollExtent) {
            if(!_controller.reachMaxData() && !_controller.gettingMore){
              _controller.getMoreData();
            }
          }
          return;
        },
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              child: Text(
                "Últimas notícias",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...news,
            Visibility(
              visible: !_controller.reachMaxData(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderTileNews(News news){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.maxFinite,
            height: deviceSize.height * 0.26,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,       
                loadingBuilder: (_,w,loading){
                  if(loading != null){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return w;
                },    
                errorBuilder: (_,__,___)=>Image.asset(
                  "assets/images/no_image.png",
                  fit: BoxFit.cover,
                ),     
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: ()=>_controller.changeHighlight(news),
                  child: SvgPicture.asset(
                    "assets/icons/bookmark.svg",
                    height: 28,
                    color: news.highlight ? primaryColor : null 
                  ),
                ),
                Spacer(),
                Text(
                  "published at",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  news.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,              
                  ),                
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                news.description,
                style: TextStyle(
                  fontSize: 16,              
                ),                
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Divider(
              color: dividerColor,
            ),
          )
        ],
      ),
    );
  }
}