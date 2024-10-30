import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_cubit.dart';
import 'package:shop_app/models/home_model/product_home.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

import 'cubit/search_state.dart';

// ignore: must_be_immutable
class ShopAppSearchScreen extends StatelessWidget {
  ShopAppSearchScreen({Key key}) : super(key: key);
  TextEditingController search = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Shop App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      controller: search,
                      prefix: Icon(Icons.search),
                      valid: (String value) {
                        if (value.isEmpty) return 'Search must not be Empty';
                        return null;
                      },
                      type: TextInputType.text,
                      label: 'Search',
                      onSubmitted: (value) {
                        if (formKey.currentState.validate()) {
                          SearchCubit.get(context)
                              .getSearchData(text: search.text);
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is GetDataLoadingSearchState)
                    LinearProgressIndicator(),
                  ConditionalBuilder(
                    condition: SearchCubit.get(context).searchModel != null,
                    builder: (context)=>Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => searchItem(
                              SearchCubit.get(context).searchModel.data.data[index],
                              context),
                          separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 10),
                                child: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                          itemCount: SearchCubit.get(context).searchModel.data.data.length),
                    ),
                    fallback: (context)=>Container(),

                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchItem(Products model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage(
                    model.image.toString(),
                  ),
                  height: 120,
                  width: 120,
                ),
                model.discount != 0
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
                      model.name,
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
                          model.price.round().toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: defaultColor,
                          ),
                        ),
                        //Spacer(),
                        // IconButton(
                        //   icon: CircleAvatar(
                        //     radius: 15,
                        //     child: Icon(
                        //       Icons.favorite_border,
                        //       color: Colors.white,
                        //     ),
                        //     backgroundColor: HomeCubit.get(context)
                        //             .favorites[model.id] && HomeCubit.get(context).favorites[model.id]!=null
                        //         ? Colors.blueAccent
                        //         : Colors.grey,
                        //   ),
                        //   padding: EdgeInsets.zero,
                        //   onPressed: () {
                        //     HomeCubit.get(context)
                        //         .changFavorites(id: model.id);
                        //   },
                        //   //color: Colors.grey,
                        //   iconSize: 14,
                        // )
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
