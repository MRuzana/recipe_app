import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Navigate based on authentication state
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (authProvider.authState == AuthState.authenticated) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          } else if (authProvider.authState == AuthState.unauthenticated) {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          } else if (authProvider.authState == AuthState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(authProvider.errorMesssage ?? "Authentication error")),
            );
          }
        });

        return Scaffold(
          body: Center(
            child: Image.asset(
              'assets/Welcome.png',
            ),
          ),
        );
      },
    );
  }
}