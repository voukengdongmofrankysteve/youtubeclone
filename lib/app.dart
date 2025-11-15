import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    // Get platform brightness for system theme mode


    return MaterialApp(
      title: 'VideoPlayer',
      debugShowCheckedModeBanner: false,
    //  theme: _themeService.getThemeData(platformBrightness),
      home: const MainScreen(),
    );
  }
}
