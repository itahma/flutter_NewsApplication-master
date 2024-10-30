import 'package:flutter/material.dart';
import 'package:shop_app/models/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/network/local/cachehelper.dart';

 List <OnBoardingModel> onBoardingObject =[
  OnBoardingModel(tittle: 'Easy Exchange!',details: 'Some Details About Our  Shop App',urlImage: 'assets/images/slider_1.png'),
  OnBoardingModel(tittle: 'Easy To Use!',details: 'Some Details About Our  Shop App',urlImage: 'assets/images/slider_2.png'),
  OnBoardingModel(tittle: 'Connect With Others',details: 'Some Details About Our  Shop App',urlImage: 'assets/images/slider_3.png'),
];

 enum ToastState{SUCCESS,ERROR,WARING}


 Color toastColor(ToastState state){
  Color color;
  switch(state){
   case ToastState.SUCCESS:
   color =  Colors.green;
    break;

   case ToastState.WARING:
    color = Colors.yellow;
    break;

   case ToastState.ERROR:
    color =  Colors.red;
    break;
  }
  return color;
 }

String token = CacheHelper.getData(key: 'token');