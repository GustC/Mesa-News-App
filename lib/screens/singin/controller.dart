import 'package:get/get.dart';
import 'package:mesa_news_app/app_controller.dart';
import 'package:mesa_news_app/components/messages/messages.dart';
import 'package:mesa_news_app/constants/requester_api/model.dart';
import 'package:mesa_news_app/screens/singin/models/singin_response.dart';
import 'package:mesa_news_app/screens/singin/repository.dart';

class SinginController extends GetxController{
  AppController _appController = Get.put(AppController());
  SinginRepository _repository = SinginRepository();
  RxString _email = "".obs;
  RxString _password = "".obs;
  RxBool _inRequest = false.obs;

  String get email => _email.value;

  changeEmail(email)=>_email.value = email;

  String get password => _password.value;

  changePassword(password)=>_password.value = password;

  bool get inRequest => _inRequest.value;

  submit() async {
    _inRequest.value = true;
    refresh();
    try{
      RequesterResponse response = await _repository.login(email, password);
      if(response.status){
        SinginResponse singinResponse = SinginResponse.fromJson(response.data);
        bool saved = await _appController.saveUserToken(singinResponse.token);
        if(saved){
          _appController.checkUser();
        } else {
          Messages.error();
        }
      } else {
        ResponseDataError error = response.data;
        Messages.error(info: error.message);
      }
    } catch(err,stack){
      print(err);
      Messages.error();
    }
    _inRequest.value = false;
    refresh();
  }

  resetFields(){
    changeEmail("");
    changePassword("");
  }
}