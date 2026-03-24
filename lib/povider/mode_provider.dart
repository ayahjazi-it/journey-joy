// import 'package:flutter/cupertino.dart';
//
// class ModeProvider with ChangeNotifier{
//   bool _LightModeEnable = true;
//
//
//   bool get   LightModeEnable => _LightModeEnable;
//   set   LightModeEnable( bool value){
//     _LightModeEnable= value;
//   }
//   ChangeMode(){
//    if(_LightModeEnable == true){
//       _LightModeEnable = false;
//       notifyListeners();
//     }
//    else if(_LightModeEnable == false){
//       _LightModeEnable = true;
//       notifyListeners();
//     }
// }
// }
import 'package:flutter/foundation.dart';

class ModeProvider with ChangeNotifier {
  bool _lightModeEnable = true;

  bool get lightModeEnable => _lightModeEnable;

  set lightModeEnable(bool value) {
    _lightModeEnable= value;
  }

  void changeMode() {
    if(_lightModeEnable == true){
      _lightModeEnable = false;
      notifyListeners();
    }
    else if(_lightModeEnable == false){
      _lightModeEnable = true;
      notifyListeners();
    }
  }
}


