import 'package:flutter/material.dart';

import '../Constant/dialogs.dart';
import '../Model/usermodel.dart';
import '../Network/network.dart';

class LoginController {
  bool checklogin(GlobalKey<FormState> formState) {
    if (!formState.currentState!.validate()) {
      return false;
    }
    return true;
  }

  String? ValidateText(String text) {
    if (text.isEmpty) {
      return "الحقل مطلوب*";
    }
    return null;
  }

  Future<Object?> login(User user, BuildContext context) async {
    NetworkCreator networkCreator = NetworkCreator();
    Dialogs.showLoadingDialog(context);
    return await networkCreator.logging(user);
  }
}
