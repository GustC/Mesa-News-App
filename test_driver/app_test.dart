import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

main(List<String> args) {
   group('Login', () {

    final buttonSingin = find.byValueKey('buttonSingin');
    final emailTextField = find.byValueKey('emailInput');
    final passwordTextField = find.byValueKey('passwordInput');
    final signinBackButton = find.byValueKey('signinBackButton');
    final signinSubmitButton = find.byValueKey('signinSubmitButton');
    final validEmail = "john@doe.com";
    final validPassword = "123456";  

    FlutterDriver driver;
    
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Email textfield starts empty', () async {
      await driver.tap(buttonSingin);
      await driver.tap(emailTextField);
      await driver.waitFor(find.text(""));
      await driver.tap(signinBackButton);
    });

    test('Write on email textfield',() async{
      await driver.tap(buttonSingin);
      await driver.tap(emailTextField);
      await driver.enterText("test");
      await driver.waitFor(find.text("test"));
      await driver.tap(signinBackButton);
    });

    test('Password textfield starts empty', () async {
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.waitFor(find.text(""));
      await driver.tap(signinBackButton);
    });

    test('Write on password textfield',() async{
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.enterText("test");
      await driver.waitFor(find.text("test"));
      await driver.tap(signinBackButton);
    });

    test('Tap on buttonSignin',() async{
      await driver.tap(buttonSingin);
      await driver.tap(signinSubmitButton);
      await driver.tap(signinBackButton);
    });

    test('Required email',() async{
      await driver.tap(buttonSingin);
      await driver.tap(signinSubmitButton);
      await driver.waitFor(find.text("Digite seu e-mail!"));
      await driver.tap(signinBackButton);
    });

    test('Required password',() async{
      await driver.tap(buttonSingin);
      await driver.tap(signinSubmitButton);
      await driver.waitFor(find.text("Digite sua senha!"));
      await driver.tap(signinBackButton);
    });

    test('Required email and password',() async{
      await driver.tap(buttonSingin);
      await driver.tap(signinSubmitButton);
      await driver.waitFor(find.text("Digite seu e-mail!"));
      await driver.waitFor(find.text("Digite sua senha!"));
      await driver.tap(signinBackButton);
    });

    test('Write email and submit',() async {
      await driver.tap(buttonSingin);
      await driver.tap(emailTextField);
      await driver.enterText("test");
      await driver.waitFor(find.text("test"));

      await driver.tap(signinSubmitButton);

      await driver.waitFor(find.text("Digite sua senha!"));
      await driver.tap(signinBackButton);
    });

    test('Write password and submit',() async {
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.enterText("test");
      await driver.waitFor(find.text("test"));

      await driver.tap(signinSubmitButton);
      
      await driver.waitFor(find.text("Digite seu e-mail!"));
      await driver.tap(signinBackButton);
    });

    test('Invalid email',() async{
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.enterText("test");
      await driver.tap(emailTextField);
      await driver.enterText("test");
      await driver.tap(signinSubmitButton);      
      await driver.waitFor(find.text("Invalid credentials"));
      await Future.delayed(Duration(seconds : 4));
      await driver.tap(signinBackButton);
    },timeout: Timeout(Duration(seconds: 15)));

    test('Invalid password',() async{
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.enterText("test");
      await driver.tap(emailTextField);
      await driver.enterText("test");
      await driver.tap(signinSubmitButton);      
      await driver.waitFor(find.text("Invalid credentials"));
      await Future.delayed(Duration(seconds : 4));
      await driver.tap(signinBackButton);
    },timeout: Timeout(Duration(seconds: 15)));

    test('Invalid email and password',() async{
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.enterText("test");
      await driver.tap(emailTextField);
      await driver.enterText("test");
      await driver.tap(signinSubmitButton);
      await driver.waitFor(find.text("Invalid credentials"));
      await Future.delayed(Duration(seconds : 4));
      await driver.tap(signinBackButton);
    },timeout: Timeout(Duration(seconds: 15)));

    test('Success signin',() async{
      await driver.tap(buttonSingin);
      await driver.tap(passwordTextField);
      await driver.enterText(validPassword);
      await driver.tap(emailTextField);
      await driver.enterText(validEmail);
      await driver.tap(signinSubmitButton);
      await driver.waitFor(find.text("Mesa News"));
    },timeout: Timeout(Duration(seconds: 15)));

  });
}