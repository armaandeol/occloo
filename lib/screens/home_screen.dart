import 'package:flutter/material.dart';
import 'dart:ui';
import '../components/home_header.dart';
import '../components/week_calendar.dart';
import '../components/today_medications.dart';

// Define custom colors to match auth_form.dart and welcome_screen.dart
const Color beige = Color(0xFFF5F5DC); // classic beige
const Color beigeLight = Color(0xFFFFF8E1); // lighter beige
const Color beigeDark = Color(0xFFE0C097); // darker beige
const Color redAccent = Color(0xFFD7263D); // strong red accent
const Color darkBg = Color(0xFF18181A); // very dark background
const Color darkBgLight = Color(0xFF28282A); // very dark background

class PillReminderHomeScreen extends StatefulWidget {
  @override
  _PillReminderHomeScreenState createState() => _PillReminderHomeScreenState();
}

class _PillReminderHomeScreenState extends State<PillReminderHomeScreen> {
  DateTime selectedDate = DateTime.now();
  
  final List<Map<String, dynamic>> medications = [
    {
      'name': 'Naproxen',
      'dosage': '220mg',
      'time': '8:00 AM',
      'type': 'pill',
      'color': Colors.blue,
      'taken': false,
    },
    {
      'name': 'Insulin',
      'dosage': '10 units',
      'time': '12:30 PM',
      'type': 'injection',
      'color': Colors.green,
      'taken': true,
    },
    {
      'name': 'Vitamin D3',
      'dosage': '1000 IU',
      'time': '6:00 PM',
      'type': 'pill',
      'color': Colors.orange,
      'taken': false,
    },
    {
      'name': 'Metformin',
      'dosage': '500mg',
      'time': '9:00 PM',
      'type': 'pill',
      'color': Colors.purple,
      'taken': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              redAccent, // red accent
              darkBg,    // dark background
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const HomeHeader(userName: 'Sarah'),
              // Calendar Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: darkBgLight.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: beigeDark.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'June 2025',
                                style: TextStyle(
                                  color: beige,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.chevron_left, color: beige.withOpacity(0.7)),
                                  const SizedBox(width: 10),
                                  Icon(Icons.chevron_right, color: beige.withOpacity(0.7)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          WeekCalendar(
                            selectedDate: selectedDate,
                            onDateSelected: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Medications Section
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: darkBgLight.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: beigeDark.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: TodayMedications(medications: medications),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}