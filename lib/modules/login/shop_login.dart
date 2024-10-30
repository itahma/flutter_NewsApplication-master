import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_app.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cachehelper.dart';
import 'package:shop_app/shared/style/colors.dart';

// ignore: must_be_immutable
class ShopLogInScreen extends StatelessWidget {
  ShopLogInScreen({Key key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginState>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
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
                msg: state.loginModelResponse.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
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
                        'Login',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'login now to brose our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(
                        controller: email,
                        prefix: Icon(Icons.email),
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
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
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoadingState,
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
                                    cubit.userLogin(
                                        email: email.text,
                                        password: password.text);
                                  }
                                },
                                child: Text(
                                  'Login'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ))),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ? '),
                          defaultTextButton(
                              color: Colors.blueAccent,
                              text: 'Register',
                              function: () {
                                navigatorTo(context, ShopRegisterScreen());
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
