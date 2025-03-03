import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.authState == AuthState.loading) {
          return const CircularProgressIndicator();
        }

        if (authProvider.authState == AuthState.authenticated) {
          // Display user's name if available
          final String username = authProvider.userName ?? 'Unknown User';
          final String email = authProvider.email ?? 'No email';
          final String phone = authProvider.phone ?? 'No phone number';


           return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15),
                ),
                Text(
                  phone,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15),
                ),
              ],
            );
        }

        if (authProvider.authState == AuthState.error) {
          return Text('Error: ${authProvider.errorMesssage}');
        }

        return const Text('User not logged in');
      },
    );
  }
}
