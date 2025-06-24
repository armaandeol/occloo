import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  const AuthForm({super.key, required this.isLogin});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;
  String? _errorMessage;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      if (widget.isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message ?? 'Authentication failed');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define custom colors
    const Color beige = Color(0xFFF5F5DC); // classic beige
    const Color beigeLight = Color(0xFFFFF8E1); // lighter beige
    const Color beigeDark = Color(0xFFE0C097); // darker beige
    const Color redAccent = Color(0xFFD7263D); // strong red accent
    const Color darkBg = Color(0xFF18181A); // very dark background
    const Color darkBgLight = Color(0xFF28282A); // very dark background

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
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Main form container
                Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 16,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.isLogin ? 'Welcome Back!' : 'Create Account',
                            style: const TextStyle(
                              color: beige,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Error Message Box
                          if (_errorMessage != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: redAccent.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error, color: Colors.white),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_errorMessage != null) const SizedBox(height: 16),
                          // Full Name (Registration only)
                          if (!widget.isLogin) ...[
                            TextFormField(
                              controller: _fullNameController,
                              style: const TextStyle(color: beigeLight),
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(color: beigeDark.withOpacity(0.8)),
                                prefixIcon: Icon(Icons.person, color: beigeDark.withOpacity(0.7)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: beigeDark.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: beigeDark.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: beigeLight),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: beigeDark.withOpacity(0.8)),
                              prefixIcon: Icon(Icons.email, color: beigeDark.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: beigeDark.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: beigeDark.withOpacity(0.7)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Phone Number (Registration only)
                          if (!widget.isLogin) ...[
                            TextFormField(
                              controller: _phoneController,
                              style: const TextStyle(color: beigeLight),
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(color: beigeDark.withOpacity(0.8)),
                                prefixIcon: Icon(Icons.phone, color: beigeDark.withOpacity(0.7)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: beigeDark.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: beigeDark.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            style: const TextStyle(color: beigeLight),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: beigeDark.withOpacity(0.8)),
                              prefixIcon: Icon(Icons.lock, color: beigeDark.withOpacity(0.7)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: beigeDark.withOpacity(0.7),
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: beigeDark.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: beigeDark.withOpacity(0.7)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Remember Me (Login only)
                          if (widget.isLogin)
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) => setState(() => _rememberMe = value ?? false),
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (states) => states.contains(MaterialState.selected)
                                        ? redAccent
                                        : Colors.transparent,
                                  ),
                                  side: BorderSide(color: beigeDark.withOpacity(0.7)),
                                ),
                                Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: beige.withOpacity(0.85),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 24),
                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: redAccent.withOpacity(0.85),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      widget.isLogin ? 'Sign In' : 'Create Account',
                                      style: const TextStyle(
                                        color: beige,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
  