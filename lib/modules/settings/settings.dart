import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/home_stats.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cachehelper.dart';

// ignore: must_be_immutable
class ShopSettingsScreen extends StatelessWidget {
  ShopSettingsScreen({Key key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        name.text = cubit.userData.name;
        email.text = cubit.userData.email;
        phone.text = cubit.userData.phone;
        return ConditionalBuilder(
          condition: cubit.userData != null,
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is UpDateUserDataLoadingState)
                        LinearProgressIndicator(),
                      if (state is UpDateUserDataLoadingState)
                        SizedBox(
                          height: 40,
                        ),
                      defaultTextFormField(
                        label: "User name",
                        type: TextInputType.name,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return "name must be not Empty";
                          }
                          return null;
                        },
                        prefix: Icon(Icons.person),
                        controller: name,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        label: "Email",
                        type: TextInputType.emailAddress,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return "Email must be not Empty";
                          }
                          return null;
                        },
                        prefix: Icon(Icons.email),
                        controller: email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        label: "Phone",
                        type: TextInputType.phone,
                        valid: (String value) {
                          if (value.isEmpty) {
                            return "Phone must be not Empty";
                          }
                          return null;
                        },
                        prefix: Icon(Icons.phone),
                        controller: phone,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.blueAccent,
                          child: defaultTextButton(
                              text: "Logout",
                              function: () {
                                CacheHelper.removeData(key: 'token')
                                    .then((value) {
                                  navigatorToNew(context, ShopLogInScreen());
                                });
                              }) //defaultTextButton
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          height: 40,
                          color: Colors.blueAccent,
                          child: defaultTextButton(
                              text: "update",
                              function: () {
                                if (formKey.currentState.validate()) {
                                  HomeCubit.get(context).upDateUserData(
                                      name: name.text,
                                      email: email.text,
                                      phone: phone.text);
                                }
                              }) //defaultTextButton
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => LinearProgressIndicator(),
        );
      },
    );
  }
}
