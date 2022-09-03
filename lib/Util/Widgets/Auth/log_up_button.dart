import 'package:flutter/material.dart';

import '../../Color/custom_color.dart';

class LogUpButton extends StatelessWidget {
  final String text;
  const LogUpButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        color: CustomColor.blueColor,
      ),
      child: Text(
        text,
      ),
    );
  }
}
