import 'package:mesa_news_app/public/models/pagination.dart';
import 'package:mesa_news_app/screens/home/models/model.dart';

class ResponseHomeList{
  Pagination pagination;
  List<News> news;

  ResponseHomeList({
    this.pagination,
    this.news,
  });

  ResponseHomeList.fromJson(Map<String,dynamic>json){
    if(json["pagination"] != null)
    this.pagination = Pagination.fromJson(json["pagination"]);
    if(json["data"] != null)
    this.news = json["data"].map<News>((n)=>News.fromJson(n)).toList();
  }
}