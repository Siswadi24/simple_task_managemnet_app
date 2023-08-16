import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managemen_task_app/controllers/sign_up_controller.dart';
import 'package:managemen_task_app/db/db_helper_signup.dart';
import 'package:managemen_task_app/ui/home_screen.dart';
import 'package:managemen_task_app/ui/widget/buttom_widget.dart';
import 'package:managemen_task_app/ui/widget/input_form_task_widget.dart';

import '../common/theme.dart';
import '../service/notification_service.dart';
import '../service/theme_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var notificationHelper;

  void initState() {
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestNotificationPermission();
    setState(() {
      print('Saya Disini');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build Method Called Login Screen');
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: HeadingStyle,
              ),
              MyInputFormWidget(
                title: 'Email',
                hint: 'Enter Your Email',
                controller: _emailController,
              ),
              MyInputFormWidget(
                title: 'Password',
                hint: 'Enter Your Password',
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              MyButtonWidget(
                label: "Login",
                onTap: () {
                  _validateLogin();
                  print('Login ditekan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notificationHelper.displayNotification(
              title: "You change your theme",
              body: Get.isDarkMode
                  ? "Active light Theme !"
                  : "Actived Dark Theme !");
          // notificationHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  _validateLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Get.snackbar(
        "Info".toUpperCase(),
        "Tolong isi semua field !!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (!_emailController.text.isEmail) {
      Get.snackbar(
        "Info".toUpperCase(),
        "Tolong isi email dengan benar !!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (_passwordController.text.length < 8) {
      Get.snackbar(
        "Error".toUpperCase(),
        "Password minimal 8 karakter",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      _loginUser();
    }
  }

  _loginUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    List<Map<String, dynamic>> isLogin =
        await DBHelperSignup.queryLogin(email, password);
    var _signUpController = Get.put(SignUpController());
    await _signUpController.fetchUserData(email);

    if (isLogin.isNotEmpty) {
      Get.snackbar(
        "Info".toUpperCase(),
        "Login Berhasil",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(
        () => HomeScreen(),
        transition: Transition.zoom,
        duration: Duration(milliseconds: 500),
      );
    } else {
      Get.snackbar(
        "Error".toUpperCase(),
        "Login Gagal",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
