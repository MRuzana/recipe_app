import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/view/widgets/fav_recipe_card.dart';

class FavouritesTitleCard extends StatelessWidget {
  final List<QueryDocumentSnapshot>? recipeData;

  const FavouritesTitleCard({
    super.key,
    required this.recipeData,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display two products per row
        crossAxisSpacing: 15, // Space between columns
        mainAxisSpacing: 15, // Space between rows
        childAspectRatio: 0.77, // Adjust the size ratio of each item
      ),
      itemCount: recipeData!.length,
      itemBuilder: (context, index) {
        final recipe = recipeData![index];
        final recipeName = recipe['name'];
        final preparationTime = recipe['preparationTime'];
        final image = recipe['image'];
        final description = recipe['description'];
        final ingredientsList = recipe['ingredients'];
        final instructionList = recipe['instructions'];
        final category = recipe['category'];
        final recipeId = recipe.id;

        return FavRecipeCard(
          // Using the Grid-based product card
          recipeName: recipeName,
          time: preparationTime,
          description: description,
          recipeId: recipeId,
          ingredientsList: ingredientsList,
          instructionList: instructionList,
          category: category,
          imageUrl: image,
        );
      },
    );
  }
}
