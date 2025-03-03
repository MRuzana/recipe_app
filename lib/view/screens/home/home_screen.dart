import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/bottom_nav_provider.dart';
import 'package:receipe_app/core/constants/text_styles.dart';
import 'package:receipe_app/view/screens/add_recipe.dart';
import 'package:receipe_app/view/screens/favourites.dart';
import 'package:receipe_app/view/screens/home/home_screen_content.dart';
import 'package:receipe_app/view/screens/profile.dart';

class HomeScreen extends StatelessWidget {
  
   HomeScreen({super.key});
    final List<Widget> pages = [
    HomeScreenContent(),
    CookIt(),
    Favourites(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      //backgroundColor: Colors.grey,
      body: SafeArea(
        child: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            switch (provider.selectedIndex) {
              case 0:
                return const HomeScreenContent();
              case 1:
                return const CookIt();  
              case 2:
                return const Favourites();
              case 3:
                return Profile();
              default:
                return const HomeScreenContent();
            }
          },
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, provider, child) {
          return NavItems(
            currentIndex: provider.selectedIndex,
            onTap: (index) {
              provider.updateIndex(index);
            },
          );
        },
      ),
    );
  }
}

class NavItems extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const NavItems({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return FlashyTabBar(
      selectedIndex: currentIndex,
      onItemSelected: onTap,
      showElevation: true, // Adds a shadow effect
      //backgroundColor: Colors.white,
      items: [
        FlashyTabBarItem(
          icon: Icon(Icons.home,size: 35,color: Colors.red,),
          title: Text('Home',style: headingMedium),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.menu_book,size: 35,color: Colors.red,),
          title: Text('Cook It',style: headingMedium),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.favorite,size: 35,color: Colors.red,),
          title: Text('My Recipes',style: headingMedium),
        ),
        
        FlashyTabBarItem(
          icon: Icon(Icons.person,size: 35,color: Colors.red,),
          title: Text('Profile',style: headingMedium),
        ),
      ],
    );
  }
}