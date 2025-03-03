import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/favourites_provider.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String recipeName;
  final String time;
  final String description;
  final List<dynamic> instructionList;
  final List<dynamic> ingredientsList;
  final String category;
  final int index;
  final String? recipeId;

  const RecipeCard(
      {super.key,
      required this.imageUrl,
      required this.recipeName,
      required this.time,
      required this.index,
      required this.description,
      required this.instructionList,
      required this.ingredientsList,
      required this.category,
      this.recipeId});

  @override
  Widget build(BuildContext context) {
    bool isBase64 = imageUrl.startsWith('/9j/'); // JPEG Base64 identifier
    Uint8List? imageBytes;

    if (isBase64) {
      try {
        imageBytes = base64Decode(imageUrl);
      } catch (e) {
        print("Base64 decoding error: $e");
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/recipeDetail', arguments: {
            'name': recipeName,
            'image': imageUrl,
            'preparationTime': time,
            'description': description,
            'ingredients': ingredientsList,
            'instructions': instructionList,
            'category': category,
            'recipeId': recipeId,
            'index': index
          });
        },
        child: Stack(
          children: [
            // Image Background
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: isBase64 && imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      height: 250,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.asset(
                      imageUrl, // Fallback for assets
                      height: 250,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image,
                            size: 100, color: Colors.grey);
                      },
                    ),
            ),

            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Favorite Icon
            Positioned(
              top: -5,
              right: -3,
              child: Consumer<FavouritesProvider>(
                builder: (context, favouritesProvider, child) {
                  final isFavourite =
                      favouritesProvider.isRecipeFavourite(recipeId!);

                  return IconButton(
                    onPressed: () {
                      // Handle favorite action here
                      favouritesProvider.toggleFavourite(
                          recipeId: recipeId!,
                          recipeName: recipeName,
                          time: time,
                          imageUrl: imageUrl,
                          description: description,
                          ingredientsList: ingredientsList,
                          instructionList: instructionList,
                          category: category);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor:
                              isFavourite ? Colors.red : Colors.green,
                          margin: const EdgeInsets.all(10),
                          content: Text(
                            isFavourite
                                ? '$recipeName removed from favorites'
                                : '$recipeName added to favorites',
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? Colors.red : Colors.black,
                    ),
                  );
                },
              ),
            ),

            // Name and Time
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
