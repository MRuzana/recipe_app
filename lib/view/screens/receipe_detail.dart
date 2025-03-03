import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';
import 'package:receipe_app/core/constants/text_styles.dart';

class RecipeDetail extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const RecipeDetail({
    super.key,
    required this.recipeData,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = recipeData['image'];

    bool isBase64 = imageUrl.startsWith('/9j/'); // JPEG Base64 identifier
    Uint8List? imageBytes;

    if (isBase64) {
      try {
        imageBytes = base64Decode(imageUrl);
      } catch (e) {
        print("Base64 decoding error: $e");
      }
    }

    return DefaultTabController(
      length: 2, // 2 tabs (Ingredients & Instructions)
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: kpadding15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kHeight10,

                        isBase64 && imageBytes != null
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

                        // Image.asset(
                        //   recipeData['image'],
                        //   fit: BoxFit.cover,
                        //   height: 250,
                        //   width: double.infinity,
                        // ),
                        kHeight20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              recipeData['name'],
                              style: kTitle,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.alarm_outlined,
                                  color: Colors.green,
                                  size: 18,
                                ),
                                Text(
                                  recipeData['preparationTime'],
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.green),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDescriptionBottomSheet(
                                    context,
                                    recipeData['description'],
                                    recipeData['category'],
                                    recipeData['name']
                                    );
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.red,
                              ),

                              // child: Text(
                              //  'See more',
                              //   style: const TextStyle(fontSize: 15, color: Colors.red),
                              // ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // **TabBar for Ingredients & Instructions**
                        const TabBar(
                          labelColor: Colors.red,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.red,
                          tabs: [
                            Tab(text: "Ingredients"),
                            Tab(text: "Instructions"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // **TabBarView for Ingredients & Instructions**
              Expanded(
                child: TabBarView(
                  children: [
                    // Ingredients Tab
                    Padding(
                      padding: kpadding8,
                      child: ListView(
                        children: recipeData['ingredients']
                            .map<Widget>((ingredient) => ListTile(
                                  leading: const Icon(Icons.check),
                                  title: Text(ingredient),
                                ))
                            .toList(),
                      ),
                    ),

                    // Instructions Tab
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: recipeData['instructions']
                            .map<Widget>((step) => ListTile(
                                  leading: const Icon(Icons.play_arrow),
                                  title: Text(step),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDescriptionBottomSheet(
    BuildContext context, String description, String category, String recipeName) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recipeName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),
            Text('Category : $category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}



// class RecipeDetail extends StatelessWidget {
//   final int index;

//   const RecipeDetail({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(
//         backgroundColor: Colors.red,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Recipe Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Image.asset(recipeData[index]['image'], fit: BoxFit.cover, width: double.infinity, height: 250),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Cooking Time & Servings
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("⏳ ${recipeData[index]['preparationTime']}", style: Theme.of(context).textTheme.bodyLarge),
//                      // Text("🍽️ Serves ${recipe['servings']}", style: Theme.of(context).textTheme.bodyLarge),
//                     ],
//                   ),
//                   const SizedBox(height: 10),

//                   // Ingredients
//                   const Text("🥦 Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const Text("🥦 Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 5),
//                   ...recipeData[index]['ingredients'].map<Widget>((ingredient) => ListTile(
//                         leading: const Icon(Icons.circle, size: 8),
//                         title: Text(ingredient),
//                       )),


//                   // Instructions
//                   const SizedBox(height: 10),
//                   const Text("📜 Instructions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 5),
                 

//                   // Ratings & Reviews
//                   const SizedBox(height: 10),
//                   const Text("⭐ Ratings & Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }