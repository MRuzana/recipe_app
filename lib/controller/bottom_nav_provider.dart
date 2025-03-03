import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier{
  int _selectedindex = 0;
  int get selectedIndex => _selectedindex;

  void updateIndex(int newIndex){
    _selectedindex = newIndex;
    notifyListeners();
  }

}