

import 'package:eschool/constants/colors.dart';
import 'package:flutter/material.dart';

class SnackShow{

  static showSuccess(BuildContext context,String message){

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white),),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        )
    );

  }

  static showFailure(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white),),
          duration: const Duration(seconds: 2),
          backgroundColor: bgColor,
        )
    );
  }

}