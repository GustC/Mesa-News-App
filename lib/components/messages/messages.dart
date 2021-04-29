import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa_news_app/constants/requester_api/requester_api.dart';

class Messages{
  static success(String title,String info){
    Get.showSnackbar(GetBar(
      title: title,
      message: info,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
  }
  static error({String title = "Ops!",String info = errorDefaultMessage}){
    Get.showSnackbar(GetBar(
      title: title,
      message: info,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
} 