import 'package:flutter/material.dart';
import '../services/coffee_service.dart';
import '../models/coffee.dart';
import 'coffee_detail_screen.dart';
import 'coffee_list_screen.dart';
import 'information.dart';  // Import halaman InformationScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CoffeeService _coffeeService = CoffeeService();
  late Future<List<Coffee>> _hotCoffees;
  late Future<List<Coffee>> _icedCoffees;
  List<Coffee> _allCoffees = [];
  List<Coffee> _filteredCoffees = [];
  String _searchQuery = '';  // Menyimpan query pencarian

  @override
  void initState() {
    super.initState();
    _hotCoffees = _coffeeService.fetchHotCoffees();
    _icedCoffees = _coffeeService.fetchIcedCoffees();
  }

  // Fungsi untuk memfilter kopi berdasarkan query pencarian
  void _filterCoffees(String query) {
    setState(() {
      _searchQuery = query;
      _filteredCoffees = _allCoffees.where((coffee) {
        return coffee.title.toLowerCase().contains(query.toLowerCase()) ||
            coffee.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              color: Colors.brown,  // Warna latar belakang header
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Menjaga gambar dan teks di tengah
                children: [
                  // Menampilkan gambar logo di atas teks
                  Center(
                    child: Image.network(
                      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/coffee-shop-logo-template-design-5a0e3cea955fde66f5e8e4e07c8759a1_screen.jpg?ts=1561483338',
                      width: 70,  
                      height: 70, 
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selamat datang di Cafe Haodi!',
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
            
            // Search Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filterCoffees,  // Menangani perubahan teks
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildCategoryTabs(),
            SizedBox(height: 20),
            _buildImageSlider(),
            SizedBox(height: 20),
            _buildCoffeeMenu('Hot Coffees', _hotCoffees),
            SizedBox(height: 20),
            _buildCoffeeMenu('Iced Coffees', _icedCoffees),
          ],
        ),
      ),
      
      // Menambahkan Footer dengan BottomNavigationBar
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
        currentIndex: 0, // Ganti dengan index yang sesuai
        selectedItemColor: Colors.brown,
        onTap: (int index) {
          // Menangani perubahan tab
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            // Tambahkan logika untuk tab kategori jika diperlukan
          } else if (index == 2) {
            // Navigasi ke halaman Information
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformationScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryTab('Hot Coffee'),
        _buildCategoryTab('Iced Coffee'),
      ],
    );
  }

  Widget _buildCategoryTab(String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoffeeListScreen(category: title),
          ),
        );
      },
      child: Chip(
        label: Text(title),
        backgroundColor: Colors.brown.shade100,
      ),
    );
  }

  Widget _buildImageSlider() {
    return FutureBuilder<List<Coffee>>(
      future: _icedCoffees, // Menggunakan iced coffees untuk slider
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          _allCoffees = snapshot.data!;  // Menyimpan semua kopi untuk pencarian
          return Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Coffee coffee = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoffeeDetailScreen(coffee: coffee),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        coffee.image,
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCoffeeMenu(String title, Future<List<Coffee>> futureCoffees) {
    return FutureBuilder<List<Coffee>>(
      future: futureCoffees,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<Coffee> coffeesToDisplay = _searchQuery.isEmpty
              ? snapshot.data!
              : _filteredCoffees;  // Menampilkan kopi yang telah difilter
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: coffeesToDisplay.length,
                  itemBuilder: (context, index) {
                    Coffee coffee = coffeesToDisplay[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoffeeDetailScreen(coffee: coffee),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                coffee.image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(coffee.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
