import 'package:flutter/material.dart';
import '../services/coffee_service.dart';
import '../models/coffee.dart';
import 'coffee_detail_screen.dart';
import 'home_screen.dart';

class CoffeeListScreen extends StatelessWidget {
  final String category;

  CoffeeListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    CoffeeService service = CoffeeService();
    Future<List<Coffee>> coffees = category == 'Hot Coffee'
        ? service.fetchHotCoffees()
        : service.fetchIcedCoffees();

    return Scaffold(
  appBar: AppBar(
    title: Text(
      category,
      style: TextStyle(color: Colors.white), // Menyesuaikan warna teks dengan putih
    ),
    backgroundColor: Colors.brown, // Warna latar belakang AppBar
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Tambahkan fungsionalitas pencarian di sini
        },
      ),
    ],
  ),
  // Body atau konten lainny
      body: FutureBuilder<List<Coffee>>(
        future: coffees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Menampilkan 2 kolom
                crossAxisSpacing: 10, // Jarak antar kolom
                mainAxisSpacing: 10, // Jarak antar baris
                childAspectRatio: 0.75, // Menyesuaikan rasio gambar dan teks
              ),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Coffee coffee = snapshot.data![index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoffeeDetailScreen(coffee: coffee),
                    ),
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // Gambar kopi diperbesar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            coffee.image,
                            width: double.infinity,
                            height: 120, // Menyesuaikan tinggi gambar
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          coffee.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          coffee.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
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
        currentIndex: 1,
        selectedItemColor: Colors.brown,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
          // Add logic for other items if needed
        },
      ),
    );
  }
}
