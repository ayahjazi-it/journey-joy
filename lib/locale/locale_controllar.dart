import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Mylocalecontrollar extends GetxController{
  void changelang (String codelang){
    Locale locale = Locale(codelang);
    Get.updateLocale( locale);
  }
}