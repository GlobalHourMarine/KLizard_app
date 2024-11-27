import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klizards/splash/splash_screen.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klizards/firebase_options.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: const Color.fromARGB(255, 255, 254, 254).withOpacity(0.0),
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'klizards',
        theme: ThemeData(
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
              color: AppColors.themeColor,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
