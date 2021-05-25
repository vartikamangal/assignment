import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../widget/sign-up-screenA.dart';
import '../widget/sign-up-screenB.dart';
import '../widget/sign-up-screenC.dart';

class Sign_Up_Controller extends GetxController{
   var pagecount=0.obs;
   int maxpage=2;
   Rx<Widget> currentSelectedPage = Rx<Widget>();
   changeScreen(bool isFinalPage) {
     pagecount.value == maxpage
         ? pagecount.value
         : pagecount.value++;
     switch (pagecount.value) {
       case 0:
         currentSelectedPage.value = SignUpScreenA();
         break;
       case 1:
         currentSelectedPage.value = SignUpScreenB();
         break;
       case 2:
         currentSelectedPage.value = SignUpScreenC();
         break;
     }
   }
   @override
   void onInit() {
     currentSelectedPage.value = SignUpScreenA();
     super.onInit();
   }
}