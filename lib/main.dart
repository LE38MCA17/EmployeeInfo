import 'dart:io';
import 'dart:ui';
import 'package:employeeinfoapplication/view/splash_view.dart';
import 'package:employeeinfoapplication/viewmodel/employee_Info_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Db/database_helper.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
  } else {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.openDatabase1();
    // await databaseHelper.deleteDatabaseFile();
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeInfoViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: VendorListView(),
        home: SplashView(),

      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
