import 'package:flutter/material.dart';

class PasswordVisibilityprovider extends ChangeNotifier{
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  void toggleVisibility(){
    _isObscure = !_isObscure;
    notifyListeners(); 
  }
}