import 'package:mesa_news_app/constants/requester_api/model.dart';
import 'package:mesa_news_app/constants/requester_api/requester_api.dart';

class HomePageRepository{
  static RequesterAPI _requesterAPI = RequesterAPI();

  Future<RequesterResponse> getListNews({int currentPage,int perPage,String publishedAt}) async {
    return _requesterAPI.getData(
      "v1/client/news",
      urlParams : {
        "current_page" : currentPage,
        "per_page" : perPage,
        "published_at" : publishedAt,
      },
    );
  }
}