
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



const Color mainColor  = Color.fromRGBO(0, 136, 255, 1);



ThemeData ghjappTheme = ThemeData(
    
    appBarTheme: AppBarTheme(
      
      elevation: 0,
      
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.w800
      )
    ),
  scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
  
);