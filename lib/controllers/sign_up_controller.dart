import 'package:get/get.dart';

import '../db/db_helper_signup.dart';
import '../models/signup_model.dart';

class SignUpController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  List<SignUpModel> dataUser = [];

  // Fungsi untuk mengambil email data pengguna dari database
  Future<void> fetchUserData(String userEmail) async {
    List<Map<String, dynamic>> result =
        await DBHelperSignup.queryLogin(userEmail, '');

    if (result.isNotEmpty) {
      var userData = SignUpModel.fromJson(result[0]);
      update(); // Mengupdate state untuk memperbarui UI yang terkait dengan data pengguna
    }
  }

  //Get All Data User
  void getAllDataUser() async {
    List<Map<String, dynamic>> result = await DBHelperSignup.querySignUp();

    dataUser.assignAll(
      result.map((data) => new SignUpModel.fromJson(data)).toList(),
    );
  }

  //get data user by id
  // Future<SignUpModel> getDataUserById(int id) async {
  //   List<Map<String, dynamic>> result =
  //       await DBHelperSignup.querySignUpById(id);

  //   return SignUpModel.fromJson(result[0]);
  // }
}
