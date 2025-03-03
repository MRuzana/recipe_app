import 'package:flutter/material.dart';
import 'package:receipe_app/view/widgets/receipe_title.dart';
import 'package:receipe_app/view/widgets/recipe_card.dart';

class RecipeTitleCard extends StatelessWidget {
  final String cardTitle;
  final List recipeData;
  const RecipeTitleCard({
    super.key,
    required this.recipeData,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          ReceipeTitle(title: cardTitle),
          const SizedBox(height: 10,),
          LimitedBox(
            maxHeight: 200,
            child: ListView.builder(
              itemCount: recipeData.length,
              itemBuilder: (context, index) {
                final recipe = recipeData[index];
                final recipeName = recipe['name'];          
                final preparationTime = recipe['preparationTime'];
                final image = recipe['image']; 
                final description = recipe['description'];
                final ingredientsList = recipe['ingredients'];
                final instructionList = recipe['instructions'];
                final category = recipe['category'];
                final recipeId = (recipe is Map<String, dynamic>) ? recipe['id'] : recipe.id;

                return RecipeCard(imageUrl: image,
                recipeName: recipeName,
                time: preparationTime,
                index: index,
                description: description,
                ingredientsList: ingredientsList,
                instructionList: instructionList,
                category: category,
                recipeId:recipeId,
              );
              },
              scrollDirection: Axis.horizontal,
              
            ),
          ),
        ],
      ),
    );
  }
}