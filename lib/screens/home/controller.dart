import 'package:get/get.dart';
import 'package:mesa_news_app/constants/models/pagination.dart';
import 'package:mesa_news_app/constants/requester_api/model.dart';
import 'package:mesa_news_app/constants/requester_api/requester_api.dart';
import 'package:mesa_news_app/screens/home/models/model.dart';
import 'package:mesa_news_app/screens/home/models/response_home_list.dart';
import 'package:mesa_news_app/screens/home/repository.dart';

class HomePageController extends GetxController{
  HomePageRepository _repository = HomePageRepository();
  Rx<Pagination> _pagination = Pagination(
    currentPage: 1,
    perPage: 10,    
  ).obs;
  RxList<News> _news = RxList<News>();
  RxBool _loading = true.obs;
  RxBool _gettingMore = false.obs;

  bool get loading => _loading.value;
  bool get gettingMore => _gettingMore.value;
  List<News> get news => _news;

  getNews() async {
    _loading.value = true;
    refresh();
    try{
      RequesterResponse response = await _repository.getListNews(
        currentPage: _pagination.value.currentPage, 
        perPage: _pagination.value.perPage,
      );
      if(response.status){
        ResponseHomeList dataResponse = ResponseHomeList.fromJson(response.data);
        _news = RxList(dataResponse.news);
        _pagination.value = dataResponse.pagination;
        refresh();
      } else {
        ResponseDataError error = response.data;
        print(error.message);
      }
    } catch (err,stack){
      print(err);
      print(errorDefaultMessage);
    }
    _loading.value = false;
    refresh();
  }

  getMoreData() async {
    _gettingMore.value = true;
    refresh();
    try{
      RequesterResponse response = await _repository.getListNews(
        currentPage: _pagination.value.currentPage+1, 
        perPage: _pagination.value.perPage,
      );
      if(response.status){
        ResponseHomeList dataResponse = ResponseHomeList.fromJson(response.data);
        _news.addAll(dataResponse.news);
        _pagination.value = dataResponse.pagination;
        refresh();
      } else {
        ResponseDataError error = response.data;
        print(error.message);
      }
    } catch (err,stack){
      print(err);
      print(errorDefaultMessage);
    }
    _gettingMore.value = false;
    refresh();

    // reach on bottom of list
  }

  bool reachMaxData(){
    return news.length == _pagination.value.totalItems;
  }

  changeHighlight(News news){
    news.highlight = !news.highlight;
    refresh();
  }
}