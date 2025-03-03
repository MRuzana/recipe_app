import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';
import 'package:receipe_app/controller/password_visibility_provider.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';
import 'package:receipe_app/core/constants/text_styles.dart';
import 'package:receipe_app/core/utils/validator.dart';
import 'package:receipe_app/view/widgets/button_widget.dart';
import 'package:receipe_app/view/widgets/outlined_button_widget.dart';
import 'package:receipe_app/view/widgets/text_form_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final passwordProvider = Provider.of<PasswordVisibilityprovider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: kpadding15,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/vegan.png', fit: BoxFit.cover),
                textField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  validator: (value) => Validator.validateEmail(value),
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
                kHeight10,

                const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                             
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/forgetPassword');
                                },
                                child: Text(
                                  'Forget password?',
                                  style: headingSmall,
                                ),
                              )
                            ],
                          ),
                          kHeight20,
                button(
                  buttonText: 'SIGN IN',
                  color: Colors.red,
                  buttonPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authProvider.login(_emailController.text.trim(),_passwordController.text.trim() , context);
                    }
                  },
                ),
                kHeight10,
                outlinedButton(
                  buttonText: 'CREATE ACCOUNT',
                  buttonPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
