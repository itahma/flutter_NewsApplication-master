import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/home_stats.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/categories/final_model_categories.dart';
import 'package:shop_app/models/home_model/final_model_home.dart';
import 'package:shop_app/models/home_model/product_home.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/style/colors.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavoritesState) {
          if (!state.favoriteModel.status) {
            showToast(msg: state.favoriteModel.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              homeWidget(cubit.homeModel, cubit.categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget homeWidget(HomeModel homeModel, CategoriesModel model, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: homeModel.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  //aspectRatio: 16/9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 29.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(model.data.categories[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: (model.data.categories.length),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "New item",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                scrollDirection: Axis.vertical,
                childAspectRatio: 1 / 1.69,
                children: List.generate(
                    homeModel.data.products.length,
                    (index) =>
                        gridItem(homeModel.data.products[index], context)),
              ),
            )
          ],
        ),
      );

  Widget gridItem(Products products, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
                  Image(
                    image: NetworkImage(
                      products.image.toString(),
                    ),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  products.discount != 0
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products.name,
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(children: [
                        Text(
                          products.price.round().toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(width: 5),
                        products.discount != 0
                            ? Text(products.oldPrice.round().toString(),
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
                            backgroundColor:
                                HomeCubit.get(context).favorites[products.id]
                                    ? Colors.blueAccent
                                    : Colors.grey,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            HomeCubit.get(context)
                                .changFavorites(id: products.id);
                          },
                          //color: Colors.grey,
                          iconSize: 14,
                        )
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildCategoryItem(Categories model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100,
            height: 100,
            // fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(.7),
            child: Text(
              model.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
