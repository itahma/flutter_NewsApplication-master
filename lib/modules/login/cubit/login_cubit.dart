import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit(ShopLoginState initialState) : super(ShopLoginInitialState());
  IconData suffx = Icons.visibility_outlined;
  bool isPassword = true;
  ShopLoginModel loginModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String email, @required password}) {
    emit(ShopLoadingState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      //print(value.data);

      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error));
      print(error.toString());
    });
  }
  void changePasswordIcon(){
    isPassword = ! isPassword;
   if(isPassword){
     suffx = Icons.visibility_outlined;
     emit(ShopLoginChangePasswordIcon());
   }
   else{
      suffx = Icons.visibility_off_outlined;
     emit(ShopLoginChangePasswordIcon());
   }
  }

}
