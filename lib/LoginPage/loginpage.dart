import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_project/Constant/color.dart';
import 'package:riverpod_project/Constant/items.dart';
import 'package:riverpod_project/LoginPage/logincontroller.dart';
import 'package:riverpod_project/router.dart';
import 'dart:ui';
import '../HomePage/home.dart';
import '../Model/error.dart';
import '../Model/usermodel.dart';
import '../main.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerpassword = TextEditingController();
  LoginController loginController = LoginController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final logging = ref.watch(islogin);
    return Scaffold(
      backgroundColor: Coloring.primary,
      key: _scaffoldKey,
      appBar: Item.GetAppBar(
          "تسجيل الدّخول".tr(), false, _scaffoldKey, logging, context),
      drawer: Item.GetDrawer(context, _scaffoldKey, logging, ref),
      body: Body(),
    );
  }

  Body() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Form(
        key: formstate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: double.infinity,
                height: height / 2,
                padding: EdgeInsets.all(75.sp),
                child: Image.asset("assets/images/logo.png")),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("إذا لم يكن لديك حساب".tr(),
                      style: TextStyle(
                          color: Coloring.secondary,
                          fontSize: 15.sp,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      FLuroRouter.router.navigateTo(context, "/register",
                          transition: TransitionType.inFromTop,
                          clearStack: true);
                    },
                    child: Text("أنشئ حساب".tr(),
                        style: TextStyle(
                            color: Coloring.third,
                            fontSize: 15.sp,
                            fontFamily: "Nabeel",
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Container(
                height: height / 10,
                child: TextFormField(
                    controller: _controlleremail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Coloring.primary,
                    validator: (value) {
                      return loginController.ValidateText(value!);
                    },
                    style: TextStyle(
                        fontFamily: "Nabeel",
                        color: Coloring.primary,
                        fontWeight: FontWeight.bold),
                    decoration:
                        makeInputDirection("أدخل الإيميل", Icons.email, null))),
            Container(
                height: height / 10,
                child: TextFormField(
                    obscureText: true,
                    controller: _controllerpassword,
                    cursorColor: Coloring.primary,
                    validator: (value) {
                      return loginController.ValidateText(value!);
                    },
                    style: TextStyle(
                        fontFamily: "Nabeel",
                        color: Coloring.primary,
                        fontWeight: FontWeight.bold),
                    decoration: makeInputDirection(
                        "أدخل كلمة المرور", Icons.key, Icons.remove_red_eye))),
            Container(
              margin: EdgeInsets.only(right: 20.sp, bottom: 20.sp),
              alignment: Alignment.centerRight,
              child: Text("هل نسيت كلمة المرور?".tr(),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Coloring.secondary,
                      fontSize: 15.sp,
                      fontFamily: "Nabeel",
                      fontWeight: FontWeight.bold)),
            ),
            MaterialButton(
                minWidth: width / 2,
                height: height / 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Coloring.third,
                onPressed: () async {
                  if (loginController.checklogin(formstate)) {
                    User user = User(
                        id: 0,
                        name: "",
                        email: _controlleremail.text,
                        password: _controllerpassword.text,
                        confirmpassword: "");
                    Object? data = await loginController.login(user, context);
                    Navigator.pop(context);
                    if (data is Users) {
                      //-------------------------------successlogin--------------------
                      userIt<Users>().user = data.user;
                      userIt<Users>().token = data.token;
                      ref.read(islogin.notifier).state = true;
                      Fluttertoast.showToast(
                          msg: "Success Login".tr(), fontSize: 20.sp);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ));
                    } else if (data is ErrorData) {
                      Fluttertoast.showToast(msg: data.message!);
                    }
                  }
                },
                child: Text("تسجيل الدّخول".tr(),
                    style: TextStyle(
                        color: Coloring.secondary,
                        fontSize: 15.sp,
                        fontFamily: "Nabeel",
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }

  makeInputDirection(String hint, IconData suffix, IconData? prefix) {
    return InputDecoration(
        contentPadding: EdgeInsets.zero,
        errorStyle: TextStyle(
            fontSize: 15.sp, fontFamily: "Nabeel", fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Coloring.primary)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Coloring.primary)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Coloring.primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red)),
        suffixIcon: Icon(
          suffix,
          color: Colors.amber,
        ),
        prefixIcon: Icon(
          prefix,
          color: Colors.amber,
        ),
        hintText: "$hint".tr(),
        hintStyle: TextStyle(
            fontFamily: "Nabeel",
            color: Coloring.primary,
            fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Coloring.secondary);
  }
}
