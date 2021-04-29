class SinginResponse{
  String token;

  SinginResponse({this.token});

  SinginResponse.fromJson(Map<String,dynamic>json){
    this.token = json["token"];
  }
}
