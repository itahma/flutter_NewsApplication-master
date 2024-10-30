

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_app.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cachehelper.dart';
import 'package:shop_app/shared/style/colors.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(ShopRegisterInitialState()),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModelResponse.status) {
              //showToast(msg:state.loginModelResponse.message , state:ToastState.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModelResponse.data.token)
                  .then((value) {
                token = state.loginModelResponse.data.token;
                showToast(
                    msg: state.loginModelResponse.message,
                    state: ToastState.SUCCESS);
                navigatorToNew(context, ShopAppScreen());
              });
            } else {
              showToast(
                  msg: state.loginModelResponse.message,
                  state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          ShopRegisterCubit cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'register now to brose our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          controller: name,
                          prefix: Icon(Icons.person),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          type: TextInputType.name,
                          correct: true,
                          focus: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: email,
                          prefix: Icon(Icons.email),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          correct: true,
                          focus: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                            controller: password,
                            prefix: Icon(Icons.lock),
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              }
                              return null;
                            },
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            correct: true,
                            focus: true,
                            suffix: Icon(cubit.suffx),
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.changePasswordIcon();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: phone,
                          prefix: Icon(Icons.phone),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          type: TextInputType.phone,
                          correct: true,
                          focus: true,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      cubit.userRegister(
                                          name: name.text,
                                          email: email.text,
                                          password: password.text,
                                          phone: phone.text);
                                    }
                                  },
                                  child: Text(
                                    'Register'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ))),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
