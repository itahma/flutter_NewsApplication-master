import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/home_stats.dart';
import 'package:shop_app/layout/shop_app/shop_app.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cachehelper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/thems/them.dart';

import 'modules/login/cubit/login_states.dart';
import 'modules/search/cubit/search_cubit.dart';
import 'modules/search/cubit/search_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
   await CacheHelper.init();
   Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null)
      widget = ShopAppScreen();
    else
      widget = ShopLogInScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    onBoarding: onBoarding,
    startWidget: widget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool onBoarding;
  Widget startWidget;

  MyApp({this.onBoarding, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(HomeInitialState())
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => ShopLoginCubit(ShopLoginInitialState()),
        ),
        BlocProvider(
            create: (context) => SearchCubit(SearchInitialState())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThem,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
