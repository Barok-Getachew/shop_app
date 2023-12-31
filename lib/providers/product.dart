import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus(String? token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shop-app-af364-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$token';
    try {
      await http.put(
          Uri.parse(
            url,
          ),
          body: json.encode({'isFavorite': isFavorite}));
    } catch (error) {
      isFavorite = oldStatus;
    }
  }
}
