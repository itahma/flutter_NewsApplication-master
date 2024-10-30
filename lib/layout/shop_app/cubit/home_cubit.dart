import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_stats.dart';
import 'package:shop_app/models/categories/final_model_categories.dart';
import 'package:shop_app/models/favorites/change_favorites.dart';
import 'package:shop_app/models/favorites/final_model.dart';
import 'package:shop_app/models/home_model/final_model_home.dart';
import 'package:shop_app/models/login_model/user_data.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/home/home.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(HomeStates initialState) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screen = [
    ShopHomeScreen(),
    ShopCategoriesScreen(),
    ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];

  void changBottomBar(int index) {
    currentIndex = index;
    emit(ChangBottomBarIconState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(GetDataLoadingHomeState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      //print(homeModel.data.products[2].image);
      emit(GetDataSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorHomeState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    emit(GetDataLoadingCategoriesState());
    DioHelper.getData(url: Categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetDataSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorCategoriesState());
    });
  }

  ChangeFavorites favoriteModel;

  void changFavorites({@required int id}) {
    favorites[id] = !favorites[id];
    emit(ChangeFavoritesState());
    DioHelper.postData(url: Favorites, data: {'product_id': id}, token: token)
        .then((value) => {
              favoriteModel = ChangeFavorites.fromJson(value.data),
              if (!favoriteModel.status)
                {favorites[id] = !favorites[id]}
              else
                {getFavoritesData()},
              emit(SuccessChangeFavoritesState(favoriteModel))
            })
        .catchError((error) {
      print(error.toString());
      favorites[id] = !favorites[id];
      emit(ErrorChangeFavoritesState(error));
    });
  }

  FinalFavoritesModel favoritesModel;

  void getFavoritesData() {
    emit(GetDataLoadingFavoritesState());
    DioHelper.getData(url: Favorites, token: token).then((value) {
      favoritesModel = FinalFavoritesModel.fromJson(value.data);
      //print(favoritesModel.data.data[0].products.image);
      emit(GetDataSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorFavoritesState());
    });
  }

  UserData userData;

  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: Profile, token: token).then((value) {
      userData = UserData.fromJson(value.data['data']);

      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  void upDateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(UpDateUserDataLoadingState());
    DioHelper.upDateData(url: UpDateProfile, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = UserData.fromJson(value.data['data']);

      emit(UpDateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpDateUserDataErrorState());
    });
  }
}
