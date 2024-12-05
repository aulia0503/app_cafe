import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coffee.dart';

class CoffeeService {
  final String hotCoffeeUrl = 'https://api.sampleapis.com/coffee/hot';
  final String icedCoffeeUrl = 'https://api.sampleapis.com/coffee/iced';

  Future<List<Coffee>> fetchHotCoffees() async {
    final response = await http.get(Uri.parse(hotCoffeeUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Coffee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hot coffees');
    }
  }

  Future<List<Coffee>> fetchIcedCoffees() async {
    final response = await http.get(Uri.parse(icedCoffeeUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Coffee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load iced coffees');
    }
  }
}
