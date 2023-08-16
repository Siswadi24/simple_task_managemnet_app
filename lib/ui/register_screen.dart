import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:managemen_task_app/ui/login_screen.dart';
import 'package:managemen_task_app/ui/widget/buttom_widget.dart';
import 'package:managemen_task_app/ui/widget/input_form_task_widget.dart';

import '../common/theme.dart';
import '../db/db_helper_signup.dart';
import '../service/notification_service.dart';
import '../service/theme_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _selectedGender = 'Laki-laki';
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
    print('Build Method Called Register Screen');
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
                'Register',
                style: HeadingStyle,
              ),
              MyInputFormWidget(
                title: 'Nama Lengkap',
                hint: 'Enter Your Nama Lengkap',
                controller: _nameController,
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
              MyInputFormWidget(
                title: 'Jenis Kelamin',
                hint: "$_selectedGender",
                widget: DropdownButton(
                  padding: EdgeInsets.only(right: 10),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 20,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                  items: <String>['Laki-laki', 'Perempuan']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.toString(),
                        style: subTitleStyle,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      MyButtonWidget(
                        label: "Register",
                        onTap: () {
                          _validateRegister();
                          print('Register ditekan');
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          Get.to(() => LoginScreen());
                        },
                        child: Row(
                          children: [
                            Text(
                              "Sudah punya akun ?",
                              style: subTitleStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Login",
                              style: subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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

  // Fungsi untuk melakukan pendaftaran (Register)
  _registerUser() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String gender = _selectedGender;

    // Lakukan logika pendaftaran di sini, misalnya menyimpan data ke database atau melakukan validasi
    // Anda dapat menghubungkan fungsi ini dengan DBHelperSignUp untuk menyimpan data ke SQLite.
    Map<String, dynamic> signUpData = {
      'name': name,
      'email': email,
      'password': password,
      'jenisKelamin': gender,
    };

    var result = await DBHelperSignup.insertSignUp(signUpData);
    debugPrint(result.toString());

    if (result != 0) {
      // Jika data berhasil disimpan, tampilkan pesan berhasil
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sukses'),
          content: Text('Pendaftaran berhasil.'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Get.to(() => LoginScreen());
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Jika terjadi kesalahan saat menyimpan data, tampilkan pesan kesalahan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat menyimpan data.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Fungsi untuk validasi pendaftaran (Register)
  _validateRegister() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedGender.isEmpty) {
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
        "Info".toUpperCase(),
        "Password must be at least 8 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      _registerUser();
    }
  }
}
