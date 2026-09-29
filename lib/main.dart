import 'package:app_noticias/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Portal Notícia",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: const Color(
          0xFFF8FAFC,
        ), //0xFF esse é o prefixo que deve ser colocado sempre que vamos colocar uma cor em hexadecimal
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 4.0,
        ),
      ),
      home: const HomePage(),
    ),
  );
}
