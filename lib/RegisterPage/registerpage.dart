import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_project/Constant/items.dart';
import 'package:riverpod_project/HomePage/home.dart';
import 'package:riverpod_project/Model/error.dart';
import 'package:riverpod_project/Model/state.dart';
import 'package:riverpod_project/RegisterPage/registercontroller.dart';
import 'package:riverpod_project/main.dart';

import '../Constant/color.dart';
import '../Model/usermodel.dart';
import '../router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> formstate = GlobalKey();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerpassword = TextEditingController();
  TextEditingController _controllerconfirmpassword = TextEditingController();
  TextEditingController _controllername = TextEditingController();
  RegisterController registerController = RegisterController();
  @override
  Widget build(BuildContext context) {
    final logging = ref.watch(islogin);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Coloring.primary,
      appBar: Item.GetAppBar(
          "إنشاء حساب".tr(), false, _scaffoldKey, logging, context),
      drawer: Item.GetDrawer(context, _scaffoldKey, logging, ref),
      body: Body(),
    );
  }

  Body() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: width,
              height: height / 3,
              padding: EdgeInsets.all(25.sp),
              child: Image.asset("assets/images/logo.png")),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("هل لديك حساب من قبل?".tr(),
                    style: TextStyle(
                        color: Coloring.secondary,
                        fontSize: 15.sp,
                        fontFamily: "Nabeel",
                        fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () {
                    FLuroRouter.router
                        .navigateTo(context, "/login", clearStack: true);
                  },
                  child: Text("أنقر هنا لتسجيل الدّخول".tr(),
                      style: TextStyle(
                          color: Coloring.third,
                          fontSize: 15.sp,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Form(
            key: formstate,
            child: Column(
              children: [
                Container(
                    height: height / 10,
                    child: TextFormField(
                        controller: _controlleremail,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Coloring.primary,
                        validator: (value) {
                          return registerController.ValidateText(value!);
                        },
                        style: TextStyle(
                            fontFamily: "Nabeel",
                            color: Coloring.primary,
                            fontWeight: FontWeight.bold),
                        decoration: makeInputDirection(
                            "أدخل اسمك", Icons.email, null))),
                Container(
                    height: height / 10,
                    child: TextFormField(
                        controller: _controlleremail,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Coloring.primary,
                        validator: (value) {
                          return registerController.ValidateText(value!);
                        },
                        style: TextStyle(
                            fontFamily: "Nabeel",
                            color: Coloring.primary,
                            fontWeight: FontWeight.bold),
                        decoration: makeInputDirection(
                            "أدخل الإيميل", Icons.email, null))),
                Container(
                    height: height / 10,
                    child: TextFormField(
                      obscureText: true,
                      controller: _controllerpassword,
                      cursorColor: Coloring.primary,
                      validator: (value) {
                        return registerController.ValidatePassword(value!);
                      },
                      style: TextStyle(
                          fontFamily: "Nabeel",
                          color: Coloring.primary,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          errorStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "Nabeel",
                              fontWeight: FontWeight.bold),
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
                            Icons.key,
                            color: Colors.amber,
                          ),
                          prefixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.amber,
                          ),
                          hintText: "أدخل كلمة المرور".tr(),
                          hintStyle: TextStyle(
                              fontFamily: "Nabeel",
                              color: Coloring.primary,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Coloring.secondary),
                    )),
                Container(
                    height: height,
                    child: TextFormField(
                      obscureText: true,
                      controller: _controllerconfirmpassword,
                      cursorColor: Coloring.primary,
                      validator: (value) {
                        return registerController.ValidateConfirmPassword(
                            _controllerpassword.text, value!);
                      },
                      style: TextStyle(
                          fontFamily: "Nabeel",
                          color: Coloring.primary,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          errorStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "Nabeel",
                              fontWeight: FontWeight.bold),
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
                          suffixIcon: const Icon(
                            Icons.key,
                            color: Colors.amber,
                          ),
                          prefixIcon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.amber,
                          ),
                          hintText: "تأكيد كلمة المرور".tr(),
                          hintStyle: TextStyle(
                              fontFamily: "Nabeel",
                              color: Coloring.primary,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Coloring.secondary),
                    )),
                MaterialButton(
                  minWidth: width / 2,
                  height: height / 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Coloring.third,
                  onPressed: () async {
                    if (registerController.checkregister(formstate)) {
                      User user = User(
                          id: 0,
                          name: _controllername.text,
                          email: _controlleremail.text,
                          password: _controllerpassword.text,
                          confirmpassword: _controllerconfirmpassword.text);

                      Object? data =
                          await registerController.register(user, context);
                      Navigator.pop(context);
                      if (data is Users) {
                        //------------------------sucessRegister----------------------
                        userIt<Users>().user = data.user;
                        userIt<Users>().token = data.token;
                        ref.read(islogin.notifier).state = true;
                        Fluttertoast.showToast(
                            msg: "Success Register".tr(), fontSize: 20.sp);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      } else if (data is ErrorData) {
                        Fluttertoast.showToast(
                            msg: data.message!, fontSize: 20.sp);
                      }
                    }
                  },
                  child: Text("إنشاء حساب".tr(),
                      style: TextStyle(
                          color: Coloring.secondary,
                          fontSize: 15,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
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
