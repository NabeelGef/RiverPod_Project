import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_project/Constant/dialogs.dart';
import 'package:riverpod_project/router.dart';

import '../Model/state.dart';
import '../Model/usermodel.dart';
import '../main.dart';
import 'color.dart';

class Item {
  static Widget GetDrawer(BuildContext context,
      GlobalKey<ScaffoldState> _scaffoldKey, bool logging, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width / 2;
    var height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Coloring.primary,
      child: Container(
        margin: EdgeInsets.only(
          top: height / 10,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: logging
                    ? AssetImage("assets/images/profile.png")
                    : AssetImage("assets/images/default.png"),
              ),
              logging
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userIt<Users>().user!.name}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Coloring.secondary,
                              fontFamily: 'Nabeel',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${userIt<Users>().user!.email}",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Coloring.secondary,
                              fontFamily: 'Nabeel',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No Name".tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Coloring.secondary,
                              fontFamily: 'Nabeel',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "example.company@gmail.com",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Coloring.secondary,
                              fontFamily: 'Nabeel',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
            ],
          ),
          Divider(
            color: Coloring.secondary,
            thickness: 2,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              FLuroRouter.router.navigateTo(context, "/home", clearStack: true);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.home,
                      size: 35.sp,
                      color: Coloring.secondary,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("الصفحة الرّئيسيّة".tr(),
                        style: TextStyle(
                            color: Coloring.secondary,
                            fontFamily: 'Nabeel',
                            fontSize: 20.sp)),
                  )
                ]),
          ),
          Divider(
            color: Coloring.secondary,
            thickness: 1,
          ),
          logging
              ? InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.closeDrawer();
                    Dialogs.ensureLogout(context, logging, ref);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.logout,
                            size: 35.sp,
                            color: Coloring.secondary,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("تسجيل الخروج".tr(),
                              style: TextStyle(
                                  color: Coloring.secondary,
                                  fontFamily: 'Nabeel',
                                  fontSize: 20.sp)),
                        )
                      ]),
                )
              : InkWell(
                  onTap: () {
                    FLuroRouter.router.navigateTo(context, "/login",
                        transition: TransitionType.inFromRight,
                        clearStack: true);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.login,
                            size: 35.sp,
                            color: Coloring.secondary,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("تسجيل الدّخول".tr(),
                              style: TextStyle(
                                  color: Coloring.secondary,
                                  fontFamily: 'Nabeel',
                                  fontSize: 20.sp)),
                        )
                      ]),
                ),
          Divider(
            color: Coloring.secondary,
            thickness: 1,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              child: Icon(
                Icons.info,
                size: 35.sp,
                color: Coloring.secondary,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text("حول النّظام".tr(),
                  style: TextStyle(
                      color: Coloring.secondary,
                      fontFamily: 'Nabeel',
                      fontSize: 20.sp)),
            )
          ]),
          Divider(
            color: Coloring.secondary,
            thickness: 1,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              child: Icon(
                Icons.privacy_tip,
                size: 35.sp,
                color: Coloring.secondary,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text("سياسة الاستخدام".tr(),
                  style: TextStyle(
                      color: Coloring.secondary,
                      fontFamily: 'Nabeel',
                      fontSize: 20.sp)),
            )
          ]),
          Divider(
            color: Coloring.secondary,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              FLuroRouter.router.navigateTo(context, "/settings",
                  transition: TransitionType.fadeIn);
              //settings
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.settings,
                      size: 35,
                      color: Coloring.secondary,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("الإعدادات".tr(),
                        style: TextStyle(
                            color: Coloring.secondary,
                            fontFamily: 'Nabeel',
                            fontSize: 20.sp)),
                  )
                ]),
          ),
          Divider(
            color: Coloring.secondary,
            thickness: 1,
          ),
          Container(
              margin: EdgeInsets.only(top: 20.sp),
              width: width,
              height: height / 3,
              child: Image.asset("assets/images/logo.png"))
        ]),
      ),
    );
  }

  static PreferredSizeWidget GetAppBar(
      String title,
      bool isaction,
      GlobalKey<ScaffoldState> _scaffoldKey,
      bool logging,
      //WidgetRef ref,
      BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          // ref.watch(lang) == 'ar'
          //     ? _scaffoldKey.currentState!.openEndDrawer()
          //:
          _scaffoldKey.currentState!.openDrawer();
        },
        child: Icon(
          Icons.menu,
          color: Coloring.secondary,
        ),
      ),
      actions: [
        if (isaction) ...[
          Icon(Icons.search, color: Coloring.secondary),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                if (!logging) {
                  Fluttertoast.showToast(
                    msg: "You're not login yet!!".tr(),
                    fontSize: 20,
                  );
                } else {
                  FLuroRouter.router.navigateTo(context, "/cart");
                }
              },
              child: Icon(Icons.shopping_cart, color: Coloring.secondary)),
          SizedBox(
            width: 10.sp,
          ),
        ]
      ],
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: Coloring.third,
      title: Text(
        "$title",
        style: TextStyle(fontSize: 25.sp, color: Colors.white),
      ),
      centerTitle: true,
    );
  }
}
