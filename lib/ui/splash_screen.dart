import 'package:flutter/material.dart';
import 'package:managemen_task_app/common/theme.dart';
import 'package:managemen_task_app/ui/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyClr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Task App',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              'by: TemanIboyy',
              style:
                  Theme.of(context).textTheme.subtitle1?.copyWith(color: white),
            ),
          ),
        ],
      ),
    );
  }
}
