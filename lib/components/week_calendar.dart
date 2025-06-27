import 'package:flutter/material.dart';

const Color beige = Color(0xFFF5F5DC);
const Color redAccent = Color(0xFFD7263D);

class WeekCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  const WeekCalendar({super.key, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = [];
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    for (int i = 0; i < 7; i++) {
      weekDates.add(startOfWeek.add(Duration(days: i)));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDates.map((date) {
        bool isSelected = date.day == selectedDate.day && date.month == selectedDate.month && date.year == selectedDate.year;
        bool isToday = date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;
        return GestureDetector(
          onTap: () => onDateSelected(date),
          child: Container(
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected 
                ? redAccent.withOpacity(0.85)
                : isToday 
                  ? beige.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: isToday && !isSelected
                ? Border.all(color: redAccent, width: 1)
                : null,
              boxShadow: isSelected ? [
                BoxShadow(
                  color: redAccent.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
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
                      ? beige 
                      : beige.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isSelected 
                      ? beige 
                      : beige.withOpacity(0.9),
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
} 