// import 'package:cloud_firestore/cloud_firestore.dart';

// class RecipeModel {
//   final String name;
//   final String imageUrl;
//   final String time;
//   final String description;
//   final List<String>ingredientsList;
//   final List<String>instructionList;
//   final bool isNetworkImage;

//   RecipeModel(this.time, this.description, this.ingredientsList, this.instructionList, {
//     required this.name,
//     required this.imageUrl,
//     this.isNetworkImage = false, // Default to asset image
//   });

//   // Convert Firestore document to RecipeModel
//   factory RecipeModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return RecipeModel(
//       name: data['name'] ?? 'Unknown Recipe',
      
//       imageUrl: data['imageBase64'] ?? '', // Use imageBase64 or Firebase Storage URL
//       isNetworkImage: true, // Firestore images are network-based
//     );
//   }
// }