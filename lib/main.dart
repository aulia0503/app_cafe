import 'package:flutter/material.dart';
import 'awal.dart'; // Menggunakan AwalPage sebagai halaman pertama

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: AwalPage(), // Halaman pertama yang ditampilkan saat aplikasi dibuka
    );
  }
}
