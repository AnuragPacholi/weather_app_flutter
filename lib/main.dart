import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpline_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelplinePage(),
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Colors.white,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
