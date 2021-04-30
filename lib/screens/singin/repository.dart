import 'package:mesa_news_app/public/requester_api/model.dart';
import 'package:mesa_news_app/public/requester_api/requester_api.dart';

class SinginRepository {
  
  static RequesterAPI _requesterAPI = RequesterAPI();
  
  Future<dynamic> login(String email,String password) async {
    return _requesterAPI.postData(
      "v1/client/auth/signin",
      {
        "email" : email,
        "password" : password
      }
    );
  }
}