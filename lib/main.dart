import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_project/HomePage/home.dart';
import 'package:riverpod_project/Model/state.dart';
import 'package:riverpod_project/Model/usermodel.dart';
import 'package:riverpod_project/router.dart';
import 'package:riverpod_project/user.dart';

final islogin = StateProvider((ref) => false);
final userIt = GetIt.instance;
final lang = StateProvider((ref) => "en");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setuplocator();
  FLuroRouter.setupRouter();
  runApp(ProviderScope(
      child: EasyLocalization(
          path: "assets/translations/",
          supportedLocales: [
            Locale('ar', 'SY'),
            Locale('en', 'US'),
          ],
          startLocale: Locale("en", "US"),
          child: QITAPP())));
}

void setuplocator() {
  userIt.registerLazySingleton(() => Users());
}

final providercolor = StateProvider((ref) => Colors.blue);
final provideruser = StateProvider((ref) => User2());

class QITAPP extends ConsumerStatefulWidget {
  const QITAPP({super.key});

  @override
  ConsumerState<QITAPP> createState() => _QITAPPState();
}

class _QITAPPState extends ConsumerState<QITAPP> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'QIT Flutter',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: 'home',
            home: HomePage(),
          );
        });
  }
}

class Hello extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Color data = ref.watch(providercolor);
    User2 user = ref.watch(provideruser);
    print(user.age);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            User2 d = ref.read(provideruser.notifier).state;
            d.setAge();
          }),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
                color: Colors.red,
                child: Text("RED"),
                onPressed: () {
                  final red = ref.read(providercolor.notifier);
                  red.state = Colors.red;
                }),
            Text("${user.age}", style: TextStyle(fontSize: 25)),
            MaterialButton(
                color: Colors.blue,
                child: Text("Blue"),
                onPressed: () {
                  final blue = ref.read(providercolor.notifier);
                  blue.state = Colors.blue;
                })
          ],
        ),
      ),
    );
  }
}
