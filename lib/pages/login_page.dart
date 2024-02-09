// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:xenon_app/components/my_button.dart';
import 'package:xenon_app/components/my_textfield.dart';
import 'package:xenon_app/pages/home_page.dart';
import 'package:xenon_app/main.dart';

//Login Page stateless widget
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signInUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              //logo
              Icon(
                Icons.lock,
                size: 100,
              ),
              //welcome back, you've been missed
              Text(
                'Welcome back, you\'ve been missed',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),
              //username input
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              //password input
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              //fogot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //sign in button
              MyButton(
                onTap: signInUser,
              ),

              const SizedBox(height: 50),
              //or continue with
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                 children:[
                  Expanded(
                   child: Divider(
                   color: Colors.grey[400],
                   thickness: 0.5,
                 ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'or continue with',
                    style: TextStyle(color: Colors.grey[700]),
                    ),
                ),
                Expanded(
                   child: Divider(
                   color: Colors.grey[400],
                   thickness: 0.5,
                  ),
                 ),
                ],
              ),
            ),
              //google button and apple button
              Row(children: [Widget
              ],)
              //not a member? register now

        ),
      ),
    );
  }
}
