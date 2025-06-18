import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CharacterWidget extends StatelessWidget {
  final Color color;
  final double size;
  
  const CharacterWidget({
    super.key,
    required this.color,
    this.size = AppSizes.characterSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.face, size: size * 0.5, color: AppColors.white),
    );
  }
} 