import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesa_news_app/constants/colors.dart';

class WellcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.15;
    return Scaffold(
      backgroundColor: primaryColor,      
      body: Center(
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/logo.svg",
                  height: height,
                  fit: BoxFit.fill,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: renderTitle(),
                ),
              ],
            ),            
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){

                      },                      
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20),                    
                      ),                      
                      child: Text(
                        "Entrar com e-mail",
                        style: TextStyle(
                          color: wellcomeButtonTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  renderTitle(){
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold
    );
    return Wrap(
      spacing: 25,
      children: [
        Text("N",style: textStyle,),
        Text("E",style: textStyle,),
        Text("W",style: textStyle,),
        Text("S",style: textStyle,),
      ],
    );
  }
}
