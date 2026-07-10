import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login_veiw.dart';
import 'onboarding_view.dart';
import 'profile_veiw.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool isLoading = true;
  bool seenOnboarding = false;

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    final prefs = await SharedPreferences.getInstance();

    seenOnboarding = prefs.getBool("seenOnboarding") ?? false;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // أول مرة فقط
    if (!seenOnboarding) {
      return const OnboardingScreen();
    }

    // بعد كده
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const ProfileScreen();
    }

    return const Login();
  }
}