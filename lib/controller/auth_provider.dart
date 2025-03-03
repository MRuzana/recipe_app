import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;
  User? _user;
  String? _userName;
  String? _email;
  String? _phone;
  AuthState _authState = AuthState.loading; // Initial state

  bool get isLoading => _isLoading;
  String? get errorMesssage => _errorMessage;
  User? get user => _user;
  String? get userName => _userName;
  String? get email => _email;
  String? get phone => _phone;
  AuthState get authState => _authState;

  Future<void> checkLoginStatus() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _user = _auth.currentUser;
      final prefs = await SharedPreferences.getInstance();

      if (_user != null) {
        final DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .get(const GetOptions(source: Source.server));
        if (userData.exists) {
          _userName = userData["username"];
          _email = userData["email"];
          _phone = userData["phoneNumber"];

          // Store fetched data in SharedPreferences
          await prefs.setString('username', _userName!);
          await prefs.setString('email', _email!);
          
          _authState = AuthState.authenticated;
        } else {
          _authState = AuthState.unauthenticated;
        }
      } else {
        _authState = AuthState.unauthenticated;
      }
    } catch (e) {
      log('Error in checkLoginStatus: $e');
      _authState = AuthState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> logoutEvent() async {
    try {
      await _auth.signOut();
      _authState = AuthState.unauthenticated;
      notifyListeners();
    } catch (e) {
      log('Error in checkLoginStatus: $e');
      _authState = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> signUp(UserModel user, BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Create user account
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Store user details in Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "username": user.username,
        "email": user.email,
        "phoneNumber": user.phoneNumber,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage ?? "Signup failed!"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = userCredential.user;

      if (_user != null) {
        // Navigate to Home Page

        Navigator.pushReplacementNamed(context, "/home");
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(_errorMessage ?? "Login failed!"),
            backgroundColor: Colors.red),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
