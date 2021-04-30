import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mesa_news_app/components/inputs/form_input.dart';
import 'package:mesa_news_app/public/colors.dart';
import 'package:mesa_news_app/screens/singin/controller.dart';

class SinginPage extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SinginController _controller = Get.put(SinginController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.18;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Entrar com e-mail",          
        ),
        leading: Obx(()=>IconButton(
          icon: Icon(Icons.close),
          color: Colors.white, 
          onPressed: _controller.inRequest ? null : ()=>Get.back(),
        )),
      ),
      body: GetBuilder(
        init: _controller,
        initState: (_){
          _controller.resetFields();
        },
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: SvgPicture.asset("assets/images/singin.svg",
                      height: height,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GenericFormInput(
                            title: "E-mail",
                            initialValue: _controller.email,
                            onChange: _controller.changeEmail,
                            validator: (email){
                              if(email.isEmpty){
                                return "Digite seu e-mail!"; 
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          GenericFormInput(
                            title: "Senha",
                            initialValue: _controller.password,
                            onChange: _controller.changePassword,
                            validator: (email){
                              if(email.isEmpty){
                                return "Digite sua senha!"; 
                              }
                              return null;
                            },
                          ),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 25),
                            child: OutlinedButton(
                              onPressed: _controller.inRequest ? null : (){
                                if(_formKey.currentState.validate()){
                                  _controller.submit();
                                }
                              },                          
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 20),   
                                backgroundColor: _controller.inRequest ? Colors.grey[400] : primaryColor,                                
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}