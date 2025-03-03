import 'package:flutter/material.dart';
import 'package:receipe_app/view/screens/home/home_screen.dart';
import 'package:receipe_app/view/screens/login/forget_password.dart';
import 'package:receipe_app/view/screens/login/login.dart';
import 'package:receipe_app/view/screens/login/signup.dart';
import 'package:receipe_app/view/screens/receipe_detail.dart';

class Routes{

  static final Map<String, WidgetBuilder> routes = {

    '/login': (context) => LoginScreen(),
    '/signup':(context) => SignUpScreen(),
    '/home': (context) => HomeScreen(),
    '/forgetPassword': (context) => ForgetPassword(),
    '/recipeDetail': (context) => RecipeDetail(recipeData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,),
    
    
  };
}