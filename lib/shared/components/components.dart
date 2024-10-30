import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/components/constants.dart';
Widget buildArticleItem(business, context ){
  return  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${business['urlToImage']}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text("${business['title']}",style:Theme.of(context).textTheme.bodyText1 ,maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Expanded(
                  child: Text("${business['publishedAt']}",style: TextStyle(
                      color: Colors.grey
                  ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )

              ],
            ),
          ),
        ),
      ],
    ),
  );
}
Widget myDriver()=> Padding(
  padding: const EdgeInsetsDirectional.only(start:20),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
);
void navigatorTo(context,Widget screen){
  Navigator.push(context,MaterialPageRoute(builder: (context)=>screen));
}
void navigatorToNew(context,Widget screen){
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>screen),
          (route) => false);
}
Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required Icon prefix,
  @required Function valid,
  bool correct = true,
  bool focus = true,
  bool isPassword = false,
  bool enable = true,
  Icon suffix,
  Function onChanged,
  Function onSubmitted,
  Function suffixPressed,
  Function onTap,
}) =>
    TextFormField(
      enabled: enable,
      validator: valid,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      autocorrect: true,
      autofocus: true,
      textAlign: TextAlign.start,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
          icon: suffix,
          onPressed: suffixPressed,
        )
            : null,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );


Widget buildOnBoardingScreen(OnBoardingModel model)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage(model.urlImage),
      ),
    ),
    SizedBox(
      height: 40,
    ),
    Text(
      model.tittle,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    ),
    SizedBox(
      height: 20,
    ),
    Text(
      model.details,
      style: TextStyle(fontSize: 14),
    )
  ],
);
Widget defaultTextButton({@required String text,@required Function function,Color color = Colors.white}){
  return TextButton(onPressed: function, child: Text(text.toUpperCase(),style: TextStyle(
    color:color
  ),));
}


void showToast({@required String msg,@required ToastState state})=> Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );