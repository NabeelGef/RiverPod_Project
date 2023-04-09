import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_project/Constant/color.dart';
import 'package:riverpod_project/main.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String language = ref.watch(lang);
    return Scaffold(
      backgroundColor: Coloring.primary,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Center(
        child: Column(
          children: [
            Center(
                child: Text(
              "اختر لغتك".tr(),
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nabeel"),
            )),
            Spacer(),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: language == "ar" ? Coloring.third : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/syria.png"),
                    Text(
                      "Arabic",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onPressed: () {
                  context.setLocale(Locale("ar", "SY"));
                  ref.read(lang.notifier).state = "ar";
                  //ref.read(lang.notifier).state = "en";
                }),
            Divider(
              thickness: 3,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: language == "en" ? Coloring.third : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/uk.png"),
                    Text(
                      "English",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Nabeel",
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onPressed: () {
                  context.setLocale(Locale("en", "US"));
                  ref.read(lang.notifier).state = "en";

                  // ref.read(lang.notifier).state = "ar";

                  // setState(() {
                  // });
                }),
            Spacer()
          ],
        ),
      ),
    );
  }
}
