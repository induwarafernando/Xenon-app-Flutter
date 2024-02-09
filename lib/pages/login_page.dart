// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:xenon_app/components/my_textfield.dart';
import 'package:xenon_app/pages/home_page.dart';
import 'package:xenon_app/main.dart';

//Login Page stateless widget
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
              //fogot password?
              //sign in button
              //or continue with
              //google button and apple button
              //not a member? register now
            ],
          ),
        ),
      ),
    );
  }
}
