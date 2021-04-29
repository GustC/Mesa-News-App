import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppController extends GetxController{
  static String _keyUser = "user_token";
  RxString _token = "".obs;
  RxBool _isLogged = false.obs;

  String get token => _token.value;

  Future<bool> saveUserToken(String token) async{  
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUser, token);
      return true;
    } catch (err){
      return false;
    }
  }

  Future removeToken() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUser);
  }

  Future checkUser() async{
    final prefs = await SharedPreferences.getInstance();
    _token.value = prefs.getString(_keyUser);
    if(_token.value != null && _token.value.isNotEmpty){
      _isLogged.value = true;
    }
    refresh();
  }
}