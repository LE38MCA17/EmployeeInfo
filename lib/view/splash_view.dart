
import 'dart:async';
import 'package:flutter/material.dart';
import 'employee_list_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 2810), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const EmployeeInfoView()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Image.network(
        "https://picsum.photos/500",
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );

  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}

