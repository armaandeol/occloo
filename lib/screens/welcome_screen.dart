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
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFFD7263D), // red accent
              Color(0xFF18181A), // dark background
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Characters section
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        child: CharacterWidget(color: Colors.blue[200]!),
                      ),
                      Positioned(
                        top: 60,
                        right: 30,
                        child: CharacterWidget(color: Colors.pink[200]!),
                      ),
                      Positioned(
                        top: 120,
                        left: 80,
                        child: SpeechBubbleWidget(text: 'Hello~'),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Main content box - moved higher up
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Oculoo',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF5F5DC), // beige
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your friendly medication companion',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFF8E1), // light beige
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      
                      // Sign In button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD7263D).withOpacity(0.85),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.beige,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Create Account button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                              color: AppColors.beige,
                              width: 2,
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              color: AppColors.beige,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
              ],
            ),
          ),
        ),
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
      appBar: null,
      body: const AuthForm(isLogin: true),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: const AuthForm(isLogin: false),
    );
  }
}