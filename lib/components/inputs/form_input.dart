import 'package:flutter/material.dart';
import 'package:mesa_news_app/public/colors.dart';

class GenericFormInput extends StatelessWidget {
  String initialValue;
  String title;
  Function(String) validator;
  bool obscureText;
  Function(String) onChange;

  GenericFormInput({
    this.initialValue = "",
    this.title = "title",
    this.validator, 
    this.obscureText=false,   
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              this.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          TextFormField(
            initialValue: this.initialValue,
            validator: this.validator,
            onChanged: this.onChange,
            obscureText: this.obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: inputFillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.red,width: 3),                  
              ),
              errorStyle: TextStyle(
                fontSize: 16,
              )
            ),
          ),
        ],
      ),
    );
  }
}