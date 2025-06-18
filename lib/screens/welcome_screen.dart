import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/auth_form.dart';
import '../widgets/character_widget.dart';
import '../widgets/speech_bubble_widget.dart';
import '../utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with characters
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.backgroundGradientStart, AppColors.backgroundGradientEnd],
              )),
          ),
          
          // Cartoon characters area
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: 30,
                    child: CharacterWidget(color: Colors.blue[200]!),
                  ),
                  Positioned(
                    top: 100,
                    right: 40,
                    child: CharacterWidget(color: Colors.pink[200]!),
                  ),
                  Positioned(
                    top: 180,
                    left: 100,
                    child: SpeechBubbleWidget(text: 'Hello~'),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Oculoo',
                  style: GoogleFonts.quicksand(
                    fontSize: AppSizes.titleFontSize,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.medium),
                Text(
                  'Your friendly medication companion',
                  style: GoogleFonts.quicksand(
                    fontSize: AppSizes.subtitleFontSize,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.extraLarge),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const LoginScreen())),
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: AppSpacing.small),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.buttonPadding),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                    ),
                  ),
                  onPressed: () => Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const SignUpScreen())),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: AppSpacing.bottomPadding),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Authentication Screens
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: const AuthForm(isLogin: true),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: const AuthForm(isLogin: false),
    );
  }
} 