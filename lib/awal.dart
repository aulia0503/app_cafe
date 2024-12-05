import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Pastikan path importnya benar
import 'dart:async';

class AwalPage extends StatefulWidget {
  @override
  _AwalPageState createState() => _AwalPageState();
}

class _AwalPageState extends State<AwalPage> {
  final List<String> _coffeeImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQazexSgX_A6y8ja7BTyIz1oHpf0CEOJ7ObuA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbnvpiz3MIscb-RJqe2DiprfkH260H0XZmdQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5daBIQr_VFLQcbLYizLc1yc_V7gugTMQawg&s',
  ];

  int _currentImageIndex = 0;

  void _changeImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _coffeeImages.length;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      _changeImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_coffeeImages[_currentImageIndex]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Exceptional brews,\nevery time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()), // Arahkan ke HomeScreen
                    );
                  },
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Warna teks diubah menjadi putih
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
