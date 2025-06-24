import 'package:flutter/material.dart';
import 'dart:ui';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Sarah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Calendar Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
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
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.chevron_left, color: Colors.white.withOpacity(0.7)),
                                  SizedBox(width: 10),
                                  Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.7)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          _buildWeekCalendar(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Medications Section
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Today\'s Medications',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00D4FF),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF00D4FF).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemCount: medications.length,
                                itemBuilder: (context, index) {
                                  return _buildMedicationCard(medications[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildWeekCalendar() {
    List<DateTime> weekDates = [];
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    
    for (int i = 0; i < 7; i++) {
      weekDates.add(startOfWeek.add(Duration(days: i)));
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDates.map((date) {
        bool isSelected = date.day == selectedDate.day;
        bool isToday = date.day == DateTime.now().day;
        
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Container(
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected 
                ? Color(0xFF00D4FF) 
                : isToday 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: isToday && !isSelected
                ? Border.all(color: Color(0xFF00D4FF), width: 1)
                : null,
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Color(0xFF00D4FF).withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ] : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday - 1],
                  style: TextStyle(
                    color: isSelected 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isSelected 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildMedicationCard(Map<String, dynamic> medication) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: medication['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: medication['color'].withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    medication['type'] == 'pill' 
                      ? Icons.medication 
                      : Icons.healing,
                    color: medication['color'],
                    size: 24,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${medication['dosage']} • ${medication['time']}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: medication['taken'] 
                      ? Colors.green.withOpacity(0.8)
                      : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: medication['taken']
                        ? Colors.green
                        : Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: medication['taken']
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}