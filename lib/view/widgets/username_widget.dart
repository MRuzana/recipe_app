import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';
import 'package:receipe_app/core/constants/text_styles.dart';

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    super.key,
  });

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

          return Text(
            username,
            style: headingLargeWhite,
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
