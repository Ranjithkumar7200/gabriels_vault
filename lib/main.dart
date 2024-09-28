// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gabriels_vault/screens/constant/ColorsPalette.dart';
import 'package:gabriels_vault/screens/splashscreen/SplashScreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: ColorsPalette.bg,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: MaterialApp(
          color: ColorsPalette.bg,
          title: 'Gabriels Vault',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
