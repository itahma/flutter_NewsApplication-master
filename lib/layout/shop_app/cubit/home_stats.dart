import 'package:shop_app/models/favorites/change_favorites.dart';

abstract class HomeStates {}
class HomeInitialState extends HomeStates{}


class ChangBottomBarIconState extends HomeStates{}



class GetDataSuccessHomeState extends HomeStates{}
class GetDataErrorHomeState extends HomeStates{}
class GetDataLoadingHomeState extends HomeStates{}

class GetDataSuccessCategoriesState extends HomeStates{}
class GetDataErrorCategoriesState extends HomeStates{}
class GetDataLoadingCategoriesState extends HomeStates{}



class GetDataSuccessFavoritesState extends HomeStates{}
class GetDataErrorFavoritesState extends HomeStates{}
class GetDataLoadingFavoritesState extends HomeStates{}



class GetUserDataSuccessState extends HomeStates{}
class GetUserDataErrorState extends HomeStates{}
class GetUserDataLoadingState extends HomeStates{}



class UpDateUserDataSuccessState extends HomeStates{}
class UpDateUserDataErrorState extends HomeStates{}
class UpDateUserDataLoadingState extends HomeStates{}



class ErrorChangeFavoritesState extends HomeStates{

 final String status;

  ErrorChangeFavoritesState(this.status);
}
class ChangeFavoritesState extends HomeStates{

}
class SuccessChangeFavoritesState extends HomeStates{
 ChangeFavorites favoriteModel;
 SuccessChangeFavoritesState(this.favoriteModel);
}






