import 'package:get/get.dart';

enum UserRole { driver, customer }

class AuthController extends GetxController {
  var selectedRole = UserRole.driver.obs;

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }
}