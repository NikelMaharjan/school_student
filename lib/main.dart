
import 'package:device_preview/device_preview.dart';
import 'package:eschool/authentication/login_pages/status_page.dart';
import 'package:eschool/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';






Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();


}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "High_importance_channel",
  "High_importance_channel",
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const InitializationSettings initializationSettings =
InitializationSettings(
  android: AndroidInitializationSettings("@mipmap/ic_launcher"),
);






final box = Provider<String?>((ref) => null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 50));


  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,

  );

  await Hive.initFlutter();

  final userBox = await Hive.openBox<String>('user');

  runApp(ProviderScope(overrides: [
    box.overrideWithValue(userBox.get('userData')),
  ], child: Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement build
    return ScreenUtilInit(
        designSize:  Size(width, height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white
                )
              ),
              useMaterial3: true
            ),
            debugShowCheckedModeBanner: false,
            home: child,
            builder: (BuildContext context, Widget? child) {
              DevicePreview.appBuilder;
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaler: TextScaler.linear(0.9)),
                child: child!,
              );
            },
          );
        },
        child: StatusPage());
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
  );
}
