import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cachehelper.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key key}) : super(key: key);
  PageController onBoardingController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(onPressed:(){
           submit(context);
          },
              child: Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (onBoardingObject.length - 1 == index) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                controller: onBoardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOnBoardingScreen(onBoardingObject[index]),
                itemCount: onBoardingObject.length,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: onBoardingObject.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    spacing: 8.0,
                    //radius:  4.0,
                    //expansionFactor: 2,
                    dotWidth: 20.0,
                    dotHeight: 16.0,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    if (isLast) {
                      submit(context);

                    } else {
                      onBoardingController.nextPage(
                          duration: Duration(seconds: 2),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void submit(context){
    CacheHelper.saveData(key: "onBoarding", value: true).then((value){
      if(value){
        navigatorToNew(context, ShopLogInScreen());
      }
    });
  }
}


