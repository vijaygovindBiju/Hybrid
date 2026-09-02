
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _PlayerButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;

  const _PlayerButton({
    required this.icon,
    required this.onPressed,
    this.size = 58,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.black12,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Center(child: Icon(icon, size: iconSize)),
        ),
      ),
    );
  }
}
