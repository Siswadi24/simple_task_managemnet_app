import 'package:flutter/material.dart';
import 'package:managemen_task_app/common/theme.dart';

class MyButtonWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButtonWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
