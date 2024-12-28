import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_bording/views/splashscreen.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/volunteercontroller.dart';
import 'core/utils/Bindings.dart';
import 'firebase_options.dart';
import 'local/local.dart';

bool? isLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final Controller = Get.put(AuthController());
  await getApplicationSupportDirectory();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff388175), // Set any color you want here
    statusBarIconBrightness:
        Brightness.light, // Set to Brightness.dark for dark icons
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var user = FirebaseAuth.instance.currentUser;
  await Get.putAsync(() => VolunteerController().init());

  runApp(DevicePreview(
      enabled: true,
      builder: (context) {
        return MyApp();
      }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.ltr,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: DevicePreview.locale(context),
      translations: Mylocale(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor:
            Colors.white, // Set white background color globally
      ),
      initialBinding: MyBinding(),
      home: const SplashScreen(),
    );
  }
}
