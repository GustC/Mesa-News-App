import 'package:get/get.dart';

class SinginController extends GetxController{
  RxString _email = "".obs;
  RxString _password = "".obs;

  String get email => _email.value;

  changeEmail(email)=>_email.value = email;

  String get password => _password.value;

  changePassword(password)=>_password.value = password;

  submit(){

  }

  resetFields(){
    changeEmail("");
    changePassword("");
  }
}