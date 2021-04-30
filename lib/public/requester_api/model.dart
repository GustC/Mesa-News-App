class RequesterResponse{
  bool status;
  dynamic data;

  RequesterResponse(this.status,{this.data});

}

class ResponseDataError{
  String code;
  String message;

  ResponseDataError({
    this.code,
    this.message,
  });

  ResponseDataError.fromJson(Map<String,dynamic> json){
    this.code = json["code"];
    this.message = json["message"];
  }
}