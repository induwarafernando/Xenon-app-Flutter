import 'package:flutter/material.dart';
import 'package:xenon_app/pages/login_page.dart';
import 'package:xenon_app/pages/register_page.dart';
import 'package:xenon_app/components/welcome_button.dart';
import 'package:xenon_app/components/custom_scaffold.dart';
import 'package:xenon_app/components/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 450.0),
              child: Text(
                'Hi! Welcome Back!',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 1.0),
              child: Text(
                'Your Closet\'s Best Friend  XENON, Your Ultimate Delivery Partner.',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[100],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: LoginPage(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: RegisterPage(),
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
