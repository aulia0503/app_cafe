import 'package:flutter/material.dart';
import '../models/coffee.dart';
import 'home_screen.dart';

class CoffeeDetailScreen extends StatelessWidget {
  final Coffee coffee;

  CoffeeDetailScreen({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          coffee.title,
          style: TextStyle(color: Colors.white), // Warna teks diubah menjadi putih
        ),
        backgroundColor: Colors.brown, // Warna AppBar diubah menjadi coklat
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0), // Gambar dengan sudut membulat
                child: Image.network(
                  coffee.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                coffee.description,
                style: TextStyle(fontSize: 16, height: 1.5), // Spasi antar baris diperbesar
              ),
              SizedBox(height: 16),
              Text(
                'Ingredients',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                coffee.ingredients.join(', '),
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, height: 1.5), // Spasi antar baris diperbesar
              ),
            ],
          ),
        ),
      ),
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
            icon: Icon(Icons.person),
            label: 'Information',
          ),
        ],
        currentIndex: 1, // Ini adalah integer yang menentukan index item yang terpilih
        selectedItemColor: Colors.brown,
        onTap: (int index) {  // Pastikan parameter index bertipe int
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } 
          // Tambahkan logika untuk item lainnya jika diperlukan
        },
      ),
    );
  }
}
