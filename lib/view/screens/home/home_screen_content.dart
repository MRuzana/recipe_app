import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';
import 'package:receipe_app/core/constants/string_constants.dart';
import 'package:receipe_app/core/constants/text_styles.dart';
import 'package:receipe_app/view/widgets/carousal_widget.dart';
import 'package:receipe_app/view/widgets/recipe_title_card.dart';
import 'package:receipe_app/view/widgets/search_widget.dart';
import 'package:receipe_app/view/widgets/username_widget.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(175), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.red,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homescreenTitle,
                    style: headingMediumWHite,
                  ),
                  const UsernameWidget(),
                  const SizedBox(height: 20), // Adjust the space as needed
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const SearchWidget(),
                  ),
                  const SizedBox(height: 30), // Adjust the space as needed
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          CarousalWidget(),
          kHeight10,
          catogoryWidget(),       
          AllRecipes(),
          NewRecipes(),
        ],
      ),
    );
  }
}
class catogoryWidget extends StatelessWidget {
  catogoryWidget({super.key});

  final List<String>_category=['Appetizers','Main courses','Desserts','Salads'];

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      height: 50, // Adjust height as needed
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Enables horizontal scrolling
          itemCount: _category.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Chip(
                label: Text(
                  _category[index],
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}


class AllRecipes extends StatelessWidget {
  AllRecipes({super.key});
  String cardTitle = 'Popular Recipe';

  @override
  Widget build(BuildContext context) {
    return RecipeTitleCard(
      recipeData: recipeData,
      cardTitle: cardTitle,
    );
  }
}

class NewRecipes extends StatelessWidget {
  NewRecipes({super.key});
  String cardTitle = 'New Recipe';

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    String cardTitle = 'New Recipe';

    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('recipes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final newRecipeData = snapshot.data!.docs;

            return RecipeTitleCard(
              recipeData: newRecipeData,
              cardTitle: cardTitle,
            );
          }
          return const Center(child: Text('No new recipe added'));
        },
      ),
    );
  }
}
