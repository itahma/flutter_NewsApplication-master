import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit(ShopRegisterState initialState)
      : super(ShopRegisterInitialState());
  IconData suffx = Icons.visibility_outlined;
  bool isPassword = true;
  ShopLoginModel loginModel;

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {@required String email,
      @required password,
      @required name,
      @required phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      //print(value.data);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error));
      print(error.toString());
    });
  }

  void changePasswordIcon() {
    isPassword = !isPassword;
    if (isPassword) {
      suffx = Icons.visibility_outlined;
      emit(ShopRegisterChangePasswordIcon());
    } else {
      suffx = Icons.visibility_off_outlined;
      emit(ShopRegisterChangePasswordIcon());
    }
  }
}
