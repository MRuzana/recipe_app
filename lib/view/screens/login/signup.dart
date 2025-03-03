import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';
import 'package:receipe_app/controller/checkbox_provider.dart';
import 'package:receipe_app/controller/password_visibility_provider.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';
import 'package:receipe_app/core/constants/string_constants.dart';
import 'package:receipe_app/core/constants/text_styles.dart';
import 'package:receipe_app/core/utils/validator.dart';
import 'package:receipe_app/model/user_model.dart';
import 'package:receipe_app/view/widgets/button_widget.dart';
import 'package:receipe_app/view/widgets/text_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordVisibilityprovider>(context);
    final termsProvider = Provider.of<CheckboxProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(signupTitle,
                style: headingLarge),
            kHeight10,
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    textField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      validator: (value) => Validator.validateUsername(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10.0),
                    textField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      validator: (value) => Validator.validateEmail(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10.0),
                    textField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      labelText: 'Phone number',
                      prefixIcon: const Icon(Icons.phone),
                      validator: (value) =>
                          Validator.validatePhoneNumber(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    kHeight10,
                    textField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      labelText: 'Password',
                      isObscured: passwordProvider.isObscure,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          passwordProvider.toggleVisibility();
                        },
                        icon: Icon(passwordProvider.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: (value) => Validator.validatePassword(value),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: termsProvider.isChecked,
                                onChanged: (value) {
                                  termsProvider.toggleCheckbox();
                                }),
                            Text('I Agree to privacy policy and terms of use',
                                style: headingSmall)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    button(
                        buttonText: 'CREATE ACCOUNT',
                        color: Colors.red,
                        buttonPressed: ()async {
                          bool isSuccess = await signUp(context);
    if (isSuccess) {
      // Show verification message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created successfully."),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to Home Screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/home",
        (route) => false,
      );
    }
  },
),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )),
          ],
        ),
      ))),
    );
  }

 Future<bool> signUp(BuildContext context) async {
  final checkboxState = Provider.of<CheckboxProvider>(context, listen: false);
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  // Validate checkbox
  final String? checkBoxValidationMessage =
      Validator.validateCheckbox(checkboxState.isChecked);
  if (checkBoxValidationMessage != null) {
    showErrorSnackbar(context, checkBoxValidationMessage);
    return false;
  }

  // Validate form
  if (!_formkey.currentState!.validate()) return false;

  // Create user model
  UserModel user = UserModel(
    username: _nameController.text.trim(),
    email: _emailController.text.trim(),
    password: _passwordController.text.trim(),
    phoneNumber: _phoneController.text.trim(),
  );

  // Call signup method
  bool success = await authProvider.signUp(user, context);
  return success;
}

// Helper function for error messages
void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(10),
      content: Text(message),
    ),
  );
}

}
