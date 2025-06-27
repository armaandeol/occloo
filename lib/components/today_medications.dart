import 'package:flutter/material.dart';
import 'dart:ui';

const Color beige = Color(0xFFF5F5DC);
const Color beigeDark = Color(0xFFE0C097);
const Color darkBgLight = Color(0xFF28282A);

class TodayMedications extends StatelessWidget {
  final List<Map<String, dynamic>> medications;
  const TodayMedications({super.key, required this.medications});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Medications",
              style: TextStyle(
                color: beige,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFD7263D),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD7263D).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: beige,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: medications.length,
            itemBuilder: (context, index) {
              return _buildMedicationCard(medications[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: darkBgLight.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: beigeDark.withOpacity(0.2),
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
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication['name'],
                        style: const TextStyle(
                          color: beige,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${medication['dosage']} • ${medication['time']}',
                        style: TextStyle(
                          color: beige.withOpacity(0.7),
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
                      : beige.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: medication['taken']
                        ? Colors.green
                        : beigeDark.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: medication['taken']
                    ? const Icon(
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