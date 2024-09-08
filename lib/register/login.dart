import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/register/signup.dart';

import '../HomeScreen.dart';
import '../Providers/my_provider.dart';
import '../firebase_functions.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";

  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Login ',style: Theme.of(context).textTheme.bodyLarge,),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SignUpScreen.routeName);
          },
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "Can't have an account ??",
                    style: Theme.of(context).textTheme.bodyMedium),
                TextSpan(
                    text: "  SignUp",
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              ])),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseFunction.login(
                    emailController.text, passwordController.text, () async {
                  provider.initUser().then(
                        (value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomeScreen.routeName, (route) => false);
                    },
                  );
                }, (error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(error),
                      actions: [
                        ElevatedButton(onPressed: () {}, child: Text("Yes")),
                        ElevatedButton(onPressed: () {}, child: Text("No"))
                      ],
                    ),
                  );
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}