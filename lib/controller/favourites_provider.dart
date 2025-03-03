import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, bool> _favourites = {};
  Map<String, bool> get favourites => _favourites;

  String? get userId => _auth.currentUser?.uid;

  bool isRecipeFavourite(String recipeId) {
    return _favourites[recipeId] ?? false;
  }

  Future<void> toggleFavourite({
    required String recipeId,
    required String recipeName,
    required String time,
    required String imageUrl,
    required String description,
    required List ingredientsList,
    required List instructionList,
    required String category
  }) async {
    if (userId == null) return;

    final favRef = _firestore.collection('users').doc(userId).collection('favourites');

    if (_favourites.containsKey(recipeId)) {
      _favourites.remove(recipeId); // Remove from local state
      await favRef.doc(recipeId).delete(); // Remove from Firestore
    } else {
      _favourites[recipeId] = true; // Mark as favourite locally
      await favRef.doc(recipeId).set({
        "recipeId": recipeId,
        "name": recipeName,
        "preparationTime": time,
        "image": imageUrl,
        "description": description,
        "ingredients": ingredientsList,
        "instructions": instructionList,
        "category": category,
      });
    }

    notifyListeners(); // Notify UI of changes
  }

  Future<void> fetchFavourites() async {
    if (userId == null) return;

    final favRef = _firestore.collection('users').doc(userId).collection('favourites');
    final snapshot = await favRef.get();

    _favourites = {
      for (var doc in snapshot.docs) doc.id: true,
    };

    notifyListeners();
  }

  Future<void> deleteFavourite(String productId) async {
    if (userId == null) return;

    _favourites.remove(productId);
    await _firestore.collection('users').doc(userId).collection('favourites').doc(productId).delete();

    notifyListeners();
  }
}




// class FavouritesProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<String> _favourites = [];

//   List<String> get favourites => _favourites;

//   FavouritesProvider() {
//     loadFavourites(); // Load favorites when provider is created
//   }

//   Future<void> loadFavourites() async {
//     try {
//       // Fetch user's favorite list from Firebase
//       final snapshot = await _firestore.collection('favorites').get();
      
//       _favourites = snapshot.docs.map((doc) => doc.id).toList();
//       notifyListeners();
//     } catch (e) {
//       print("Error fetching favorites: $e");
//     }
//   }

//   bool isRecipeFavourite(String recipeId) {
//     return _favourites.contains(recipeId);
//   }

//   Future<void> toggleFavourite({
//     required String recipeId,
//     required String name,
//     required String preparationTime,
//     required String image,
//     required String description,
//     required List<dynamic> ingredients,
//     required List<dynamic> instructions,
//     required String category,
//   }) async {
//     final docRef = _firestore.collection('favorites').doc(recipeId);

//     if (_favourites.contains(recipeId)) {
//       // Remove from Firebase
//       await docRef.delete();
//       _favourites.remove(recipeId);
//     } else {
//       // Add to Firebase
//       await docRef.set({
//         'name': name,
//         'preparationTime': preparationTime,
//         'image': image,
//         'description': description,
//         'ingredients': ingredients,
//         'instructions': instructions,
//         'category': category,
//       });
//       _favourites.add(recipeId);
//     }
    
//     notifyListeners();
//   }

//     void deleteFavourite(String productId) {
//     _favourites.remove(productId);
//     notifyListeners();
//   }


// }





















// class FavouritesProvider extends ChangeNotifier {
//   Map<String, bool> _favourites = {};
//   Map<String, bool> get favourites => _favourites;

//   bool isProductFavourite(String productId) {
//     return _favourites[productId] ?? false;
//   }

//   void toggleFavourite(String productId) {
//     if (_favourites.containsKey(productId)) {
//       _favourites.remove(productId); // Remove if exists (unfavourite)
//     } else {
//       _favourites[productId] = true; // Add as favourite
//     }
//     notifyListeners(); // Notify UI of changes
//   }

//   void deleteFavourite(String productId) {
//     _favourites.remove(productId);
//     notifyListeners();
//   }

//   void fetchFavourites() {
//     // Dummy data for testing (optional)
//     _favourites = {
//       "product1": true,
//       "product2": true,
//     };
//     notifyListeners();
//   }
// }
