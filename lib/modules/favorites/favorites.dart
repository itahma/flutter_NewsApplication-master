import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/home_stats.dart';
import 'package:shop_app/models/favorites/final_model.dart';
import 'package:shop_app/shared/style/colors.dart';

class ShopFavoritesScreen extends StatelessWidget {
  const ShopFavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetDataLoadingFavoritesState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    favoritesItem(cubit.favoritesModel, index, context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                itemCount: cubit.favoritesModel.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget favoritesItem(FinalFavoritesModel model, int index, context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage(
                    model.data.data[index].products.image.toString(),
                  ),
                  height: 120,
                  width: 120,
                ),
                model.data.data[index].products.discount != 0
                    ? Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Discount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : Text(''),
              ]),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.data.data[index].products.name,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.data.data[index].products.price
                              .round()
                              .toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(width: 5),
                        model.data.data[index].products.discount != 0
                            ? Text(
                                model.data.data[index].products.oldPrice
                                    .round()
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough))
                            : Text(''),
                        Spacer(),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            backgroundColor: HomeCubit.get(context).favorites[
                                    model.data.data[index].products.id]
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            HomeCubit.get(context).changFavorites(
                                id: model.data.data[index].products.id);
                          },
                          //color: Colors.grey,
                          iconSize: 14,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
