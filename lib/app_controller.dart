import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppController extends GetxController{
  static String _keyUser = "user_token";
  RxString _token = "".obs;
  RxBool _isLogged = false.obs;
  RxBool _inLoading = true.obs;
  RxBool _isConnected = true.obs;
  StreamSubscription<ConnectivityResult> subscription;
  

  AppController(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected.value = ConnectivityResult.values[result.index] != ConnectivityResult.none;
    });
    Connectivity().checkConnectivity().then((result) => _isConnected.value = ConnectivityResult.values[result.index] != ConnectivityResult.none);
    interval(_isConnected,(value)=>refresh(),time: Duration(seconds: 1));
  }

  String get token => _token.value;
  bool get isLogged => _isLogged.value;
  bool get inLoading => _inLoading.value;
  bool get isConnected => _isConnected.value;

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
    _inLoading.value = true;
    refresh();
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    _token.value = prefs.getString(_keyUser);
    if(_token.value != null && _token.value.isNotEmpty){
      _isLogged.value = true;
      Get.offAllNamed("home/");
    }
    _inLoading.value = false;
    refresh();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}