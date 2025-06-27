import 'package:flutter/material.dart';

const Color beige = Color(0xFFF5F5DC);
const Color beigeDark = Color(0xFFE0C097);
const Color darkBgLight = Color(0xFF28282A);

class HomeHeader extends StatelessWidget {
  final String userName;
  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: TextStyle(
                  color: beige.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  color: beige,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: darkBgLight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: beigeDark.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: beige,
            ),
          ),
        ],
      ),
    );
  }
} 