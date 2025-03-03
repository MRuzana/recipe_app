import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/core/constants/string_constants.dart';
import 'package:receipe_app/core/constants/text_styles.dart';
import 'package:receipe_app/core/utils/validator.dart';
import 'package:receipe_app/view/widgets/button_widget.dart';
import 'package:receipe_app/view/widgets/text_form_widget.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final TextEditingController _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.close))],
          ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fogetPasswordTitle,
              style: headingLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              forgetPasswordSubTitle,
              style: headingSmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  textField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) => Validator.validateEmail(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  button(
                      buttonText: 'SUBMIT',
                      color: Colors.red,
                      buttonPressed: () {
                        resetPassword(context);
                        //Navigator.pushNamed(context, '/resetPassword');
                      })
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void resetPassword(BuildContext context) async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    String email = _emailController.text.trim();

    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent. Check your inbox.'),
            backgroundColor: Colors.red,
          ),
        );
            await Future.delayed(const Duration(seconds: 2));
            Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send password reset email: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}