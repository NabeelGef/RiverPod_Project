import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_project/Constant/color.dart';
import 'package:riverpod_project/Constant/dialogs.dart';
import 'package:riverpod_project/Constant/items.dart';
import 'package:riverpod_project/Model/usermodel.dart';
import 'package:riverpod_project/Network/network.dart';
import 'package:riverpod_project/main.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/productmodel.dart';

class Detail extends ConsumerStatefulWidget {
  int id;
  Detail({required this.id, super.key});

  @override
  ConsumerState<Detail> createState() => _DetailState();
}

final quantites = StateProvider((ref) => 1);

class _DetailState extends ConsumerState<Detail> {
  NetworkCreator networkCreator = NetworkCreator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloring.primary,
      body: Body(),
    );
  }

  Body() {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: networkCreator.getDetailProduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Coloring.secondary,
              ));
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      snapshot.data!.data!.image!.conversions!.large!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Center(
                    child: Text(
                      snapshot.data!.data!.title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Coloring.secondary,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(snapshot.data!.data!.description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Coloring.secondary,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  MaterialButton(
                    height: 50.sp,
                    color: Coloring.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: () {
                      if (userIt<Users>().token == null) {
                        Fluttertoast.showToast(
                            msg: "You're not login yet!!".tr(),
                            fontSize: 20.sp);
                      } else {
                        Dialogs.select_quantity(
                          context,
                          networkCreator,
                          snapshot.data!.data!.id!,
                          userIt<Users>().token!,
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_shopping_cart,
                          color: Coloring.primary,
                        ),
                        Text(" إضافة لسلّة الشّراء بسعر".tr(),
                            style: TextStyle(
                                color: Coloring.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        Text(
                            snapshot.data!.data!.price!.value! +
                                snapshot.data!.data!.price!.currency!,
                            style: TextStyle(
                                color: Coloring.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                ],
              );
            } else {
              return Center(child: Text("No Data...".tr()));
            }
          }),
    );
  }
}
