import 'package:flutter/material.dart';
import 'package:riverpod_project/Constant/dialogs.dart';
import 'package:riverpod_project/Network/network.dart';

import '../Model/usermodel.dart';

class RegisterController {
  bool checkregister(GlobalKey<FormState> formState) {
    if (!formState.currentState!.validate()) {
      return false;
    }
    return true;
  }

  String? ValidateText(String text) {
    if (text.isEmpty) {
      return "الحقل مطلوب*";
    } else if (text.length < 2) {
      return "الاسم قصير جدّاً";
    } else if (text.length > 20) {
      return "الاسم طويلٌ جدّاً";
    }
    return null;
  }

  String? ValidatePassword(String password) {
    if (password.isEmpty) {
      return "الحقل مطلوب*";
    } else if (password.length < 8) {
      return "يجب أن تكون كلمة السر مكوّنة من 8 رموز على الاقل";
    }
    return null;
  }

  String? ValidateConfirmPassword(String password, String confirmpassword) {
    if (confirmpassword.isEmpty) {
      return "الحقل مطلوب*";
    } else if (confirmpassword.length < 8) {
      return "يجب أن تكون كلمة السر مكوّنة من 8 رموز على الاقل";
    } else if (confirmpassword != password) {
      return "لا يوجد تطابق";
    }
    return null;
  }

  Future<Object?> register(User user, BuildContext context) async {
    NetworkCreator networkCreator = NetworkCreator();
    Dialogs.showLoadingDialog(context);
    return await networkCreator.registeration(user);
  }
}
