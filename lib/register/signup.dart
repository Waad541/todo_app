import 'package:flutter/material.dart';

import '../firebase_functions.dart';
import 'login.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "SignUp";

  SignUpScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  Text('Sign Up',style: Theme.of(context).textTheme.bodyLarge),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "I have an account.... ",
                    style: Theme.of(context).textTheme.bodyMedium),
                TextSpan(
                    text: "  Login",
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your age";
                    }
                    if (int.parse(value) < 20) {
                      return "Sorry at least 20";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  validator: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your emailAddress";
                    }
                    final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);

                    if (!emailValid) {
                      return " pLease enter valid email";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunction.createAccount(
                          emailController.text, passwordController.text,
                          phone: phoneController.text,
                          username: userNameController.text,
                          age: int.parse(ageController.text), onSuccess: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      }, onError: (message) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(message),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () {}, child: Text("No"))
                            ],
                          ),
                        );
                      });
                    }
                  },
                  child: const Text('SignUp'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}