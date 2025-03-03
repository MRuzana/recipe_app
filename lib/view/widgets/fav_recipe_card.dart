import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/favourites_provider.dart';

class FavRecipeCard extends StatelessWidget {
 final String imageUrl;
  final String recipeName;
  final String time;
  final String description;
  final List<dynamic> instructionList;
  final List<dynamic> ingredientsList;
  final String category;
  final String? recipeId;

    const FavRecipeCard(
      {super.key,
      required this.imageUrl,
      required this.recipeName,
      required this.time,
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
              child: IconButton(
                 icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Provider.of<FavouritesProvider>(context,listen: false).deleteFavourite(recipeId!);
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