import 'package:flutter/material.dart';



class ProviderController with ChangeNotifier{
  bool checkValue = false;



  onChangedCheckBox(bool? newValue){
    checkValue = newValue!;
    print('Check Box : $checkValue');
    notifyListeners();
  }


}