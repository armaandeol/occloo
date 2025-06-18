import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Oculoo Home',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE4F2FF), Color(0xFFF9F0FF)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back! 👋',
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4A4A4A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user?.email ?? 'User',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          color: const Color(0xFF6C6C6C),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Quick Actions
                Text(
                  'Quick Actions',
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildActionCard(
                        context,
                        'Add Medication',
                        Icons.medication,
                        const Color(0xFF6C63FF),
                        () {
                          // TODO: Navigate to add medication screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Add Medication feature coming soon!')),
                          );
                        },
                      ),
                      _buildActionCard(
                        context,
                        'View Schedule',
                        Icons.calendar_today,
                        const Color(0xFF4CAF50),
                        () {
                          // TODO: Navigate to schedule screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Schedule feature coming soon!')),
                          );
                        },
                      ),
                      _buildActionCard(
                        context,
                        'Reminders',
                        Icons.notifications,
                        const Color(0xFFFF9800),
                        () {
                          // TODO: Navigate to reminders screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reminders feature coming soon!')),
                          );
                        },
                      ),
                      _buildActionCard(
                        context,
                        'Profile',
                        Icons.person,
                        const Color(0xFF9C27B0),
                        () {
                          // TODO: Navigate to profile screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile feature coming soon!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A4A4A),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 