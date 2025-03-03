import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';
import 'package:receipe_app/controller/bottom_nav_provider.dart';
import 'package:receipe_app/controller/checkbox_provider.dart';
import 'package:receipe_app/controller/favourites_provider.dart';
import 'package:receipe_app/controller/password_visibility_provider.dart';
import 'package:receipe_app/firebase_options.dart';
import 'package:receipe_app/routes/routes.dart';
import 'package:receipe_app/view/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PasswordVisibilityprovider()),
        ChangeNotifierProvider(create: (context) => CheckboxProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()..checkLoginStatus()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => FavouritesProvider()),
      ],
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
           
            initialRoute: '/',
            routes: Routes.routes,
      
      
        home: SplashWrapper(),
      ),
    );
  }
}



