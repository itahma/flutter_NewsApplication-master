import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/models/search/search_model.dart';

import 'package:shop_app/modules/search/cubit/search_state.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(SearchStates initialState) : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  FinalSearchModel searchModel;

  void getSearchData({@required String text}) {
    emit(GetDataLoadingSearchState());
    DioHelper.postData(url: Search, token: token, data: {'text': text})
        .then((value) {
          print(value.data);
      searchModel = FinalSearchModel.fromJson(value.data);
      //print(favoritesModel.data.data[0].products.image);
      emit(GetDataSuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorSearchState());
    });
  }
}
