import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mesa_news_app/constants/colors.dart';
import 'package:mesa_news_app/screens/home/controller.dart';
import 'package:mesa_news_app/screens/home/models/model.dart';
import 'package:mesa_news_app/screens/home/news_view/page.dart';

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

  static DateTime dateNow = DateTime.now();

  Widget renderTileNews(News news){
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(news.publishedAt);
    var dateDif = dateNow.difference(date);
    String publishedText = " - ";
    if(dateDif.inDays > 0 && dateDif.inHours>23){
      publishedText = "${dateDif.inDays} dia${dateDif.inDays>1?'s':''}";
    } else if(dateDif.inHours > 0 && dateDif.inMinutes>59){
      publishedText = "${dateDif.inHours} hora${dateDif.inHours>1?'s':''}";
    } else if(dateDif.inMinutes > 0 && dateDif.inSeconds>59){
      publishedText = "${dateDif.inMinutes} minuto${dateDif.inMinutes>1?'s':''}";
    } else {
      publishedText = "${dateDif.inSeconds} segundo${dateDif.inSeconds>1?'s':''}";
    }
    publishedText += " atrás"; 
    return GestureDetector(
      onTap: (){
        Get.to(NewsViewPage(news));
      },
      child: Container(
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
                    publishedText,
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
      ),
    );
  }
}