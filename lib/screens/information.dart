import 'package:flutter/material.dart';
import 'home_screen.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information',
          style: TextStyle(color: Colors.white), // Mengubah warna teks judul
        ),
        backgroundColor: Colors.brown,  // Menentukan warna latar belakang AppBar
        elevation: 0,  // Menambahkan efek elevasi (opsional)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Information Section
            Container(
              color: Colors.brown,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.info_outline,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Information about Cafe Haodi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            
            // Main Content Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Here at Cafe Haodi, we strive to provide the best coffee experience for our customers. Our coffee is sourced from the finest beans and roasted to perfection. We offer a variety of hot and iced coffees, as well as delicious pastries and snacks to enjoy.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            
            // Additional Information Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Visit us today and enjoy your favorite drink. We look forward to serving you the best coffee in town!',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      
      // Footer Section (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Information',
          ),
        ],
        currentIndex: 2,  // Index untuk InformationScreen
        selectedItemColor: Colors.brown,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            // Logika untuk kategori jika diperlukan
          } else if (index == 2) {
            // InformationScreen sudah aktif, tidak perlu aksi
          }
        },
      ),
    );
  }
}
