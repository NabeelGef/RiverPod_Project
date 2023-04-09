import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:riverpod_project/CartPage/cartpage.dart';
import 'package:riverpod_project/Model/cart.dart';
import 'package:riverpod_project/Model/state.dart';
import 'package:riverpod_project/ProdutcDetailPage/detail.dart';
import 'package:riverpod_project/main.dart';

import '../Model/message.dart';
import '../Model/usermodel.dart';
import '../Network/network.dart';
import 'color.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Coloring.secondary,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          color: Coloring.primary,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "انتظر قليلاً....".tr(),
                          style: TextStyle(
                              color: Colors.amber,
                              fontFamily: "Nabeel",
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static ensureLogout(BuildContext context, logging, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Coloring.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Container(
                height: height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "هل تريد تأكيد تسجيل الخروج ؟؟".tr(),
                      style: TextStyle(
                          color: Coloring.primary,
                          fontSize: 15,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                NetworkCreator networkCreator =
                                    NetworkCreator();
                                Dialogs.showLoadingDialog(context);
                                Message message = await networkCreator
                                    .logout(userIt<Users>().token!);
                                userIt<Users>().user = null;
                                userIt<Users>().token = null;
                                ref.read(tokenstate.notifier).state = null;
                                ref.read(islogin.notifier).state = false;
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "${message.message}", fontSize: 20.sp);
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: height / 15,
                                width: width / 5,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text("نعم".tr(),
                                    style: TextStyle(
                                        color: Coloring.secondary,
                                        fontSize: 15.sp,
                                        fontFamily: "Nabeel",
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height / 15,
                              width: width / 5,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text("لا".tr(),
                                  style: TextStyle(
                                      color: Coloring.secondary,
                                      fontSize: 15.sp,
                                      fontFamily: "Nabeel",
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static ensuredelete(BuildContext context, int id, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              backgroundColor: Coloring.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Container(
                height: height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "هل تريد تأكيدالحذف".tr(),
                      style: TextStyle(
                          color: Coloring.primary,
                          fontSize: 15.sp,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                NetworkCreator networkCreator =
                                    NetworkCreator();
                                Dialogs.showLoadingDialog(context);
                                Object object = await networkCreator.deleteCart(
                                    id, userIt<Users>().token!);
                                Navigator.pop(context);
                                if (object is Message) {
                                  Fluttertoast.showToast(
                                      msg: "${object.message}");
                                } else if (object is CartItem) {
                                  ref.read(cartItem.notifier).state = object;
                                  Fluttertoast.showToast(
                                      msg: "Complete".tr(), fontSize: 20.sp);
                                }
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: height / 15,
                                width: width / 5,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text("نعم".tr(),
                                    style: TextStyle(
                                        color: Coloring.secondary,
                                        fontSize: 15,
                                        fontFamily: "Nabeel",
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: height / 15,
                              width: width / 5,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text("لا".tr(),
                                  style: TextStyle(
                                      color: Coloring.secondary,
                                      fontSize: 15,
                                      fontFamily: "Nabeel",
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static select_quantity(BuildContext context, NetworkCreator networkCreator,
      int id, String token) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    int quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Coloring.secondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                content: Container(
                  height: height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "حدّد الكمية الّتي تريدها".tr(),
                        style: TextStyle(
                            color: Coloring.primary,
                            fontSize: 15.sp,
                            fontFamily: "Nabeel",
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Center(
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: NumberPicker(
                                textStyle: TextStyle(
                                    color: Coloring.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                                minValue: 1,
                                maxValue: 200,
                                value: quantity,
                                selectedTextStyle: TextStyle(
                                    color: Coloring.third,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp),
                                onChanged: (value) {
                                  setState(() {
                                    quantity = value;
                                  });
                                })),
                      ),
                      Center(
                        child: MaterialButton(
                            color: Colors.amber,
                            child: Text("تأكيد".tr(),
                                style: const TextStyle(
                                    fontFamily: "Nabeel",
                                    fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              Dialogs.showLoadingDialog(context);
                              await networkCreator.addCart(token, id, quantity);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "The Item is Added!!".tr(),
                                  fontSize: 20.sp);
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
