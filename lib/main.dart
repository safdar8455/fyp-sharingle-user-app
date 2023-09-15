import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sharingle_user_app/src/repository/authentication_repository/authentication_repository.dart';
import 'firebase_options.dart';
import 'package:sharingle_user_app/src/utils/theme/theme.dart';

/// --------- For Doc & Update Check --------
/// ---------------- README.md --------------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// README(Update[]) -- GetX Local Storage
  /// // Todo: Add Local Stroge
  ///
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode? Color(0xFF303030): Color(0xFFE5E5E5),
      statusBarBrightness: isDarkMode? Brightness.light :Brightness.dark,
      statusBarIconBrightness: isDarkMode? Brightness.light :Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      theme: RsAppTheme.lightTheme,
      darkTheme: RsAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: FirebaseInitializationScreen(),
    );
  }
}

class FirebaseInitializationScreen extends StatelessWidget {
  const FirebaseInitializationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
