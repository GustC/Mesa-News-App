import 'package:dio/dio.dart';
import 'package:mesa_news_app/constants/requester_api/model.dart';

const internalServerErrorCode = 500;


const String errorDefaultMessage = "Ocorreu um problema, entre em contato conosco";
// typedef ResponseFunction = Future<Response> Function();

class RequesterAPI{
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://mesa-news-api.herokuapp.com/",
      contentType: "application/json",
      validateStatus: (code) => code < internalServerErrorCode,
      responseType: ResponseType.json,
    )
  );
  
  Future<dynamic> getData(String url,{Map<String,dynamic>urlParams}) async{
    return await _request(dio.get(url,queryParameters: urlParams));

  }

  Future<dynamic> postData(String url,Map<String,dynamic>body,{Map<String,dynamic> urlParams}) async {
    return await _request(dio.post(url,data: body));
  }

  Future _request(Future<Response> function) async{
    RequesterResponse response = RequesterResponse(false);
    try{
      Response resp = await function;
      if(resp.statusCode == 200){
        response.data = resp.data;
        response.status = true;
      } else {
        response.data = ResponseDataError.fromJson(resp.data);
      }
      return response;      
    } on DioError catch (err,stack){      
      try{
        response.data = err.message;
      } catch (err,stack) {
        response.data = errorDefaultMessage;
        // send stack error to api
      }
      return err;
    } 
  }
}