import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'screens/splash.dart'; 

void main() {
  runApp(const CurioStoreApp());
}

class CurioStoreApp extends StatelessWidget {
  const CurioStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CurioStore',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

