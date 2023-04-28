import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class PrimaryCardButton extends StatelessWidget {
  const PrimaryCardButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.icon,
    this.elevation = 5.0,
    this.padding = 10.0,
    this.borderRadius = 20.0,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final IconData icon;
  final double elevation;
  final double padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonPrimaryBackgroundColor,
        foregroundColor: buttonPrimaryForegroundColor,
        disabledBackgroundColor: darkButtonDisabled,
        disabledForegroundColor: darkTextDisabled,
        elevation: elevation,
        padding: EdgeInsets.all(padding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
