import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/home_stats.dart';
import 'package:shop_app/models/categories/categories_model.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,index){},
      builder: (context,index){
        HomeCubit cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemBuilder: (context,index)=>buildCategoryItemList(cubit.categoriesModel.data.categories[index]),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            itemCount: cubit.categoriesModel.data.categories.length,
          ),
        );
      },

    );
  }

  buildCategoryItemList(Categories categories) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              image: NetworkImage(categories.image),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(categories.name,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios,color: Colors.grey,),
        ],
      ),
    );
  }
}
