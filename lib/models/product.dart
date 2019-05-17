import 'package:flutter/material.dart';

class Product{
  final String id;
  final String title;
  final String description;
  final String location;
  final double price;
  final String image;
  final String createdById;
  final bool isFavorite;

  Product({
    @required this.id,
    @required this.title, 
    @required this.description, 
    @required this.location, 
    @required this.price, 
    @required this.image,
    @required this.createdById,
    this.isFavorite = false
    });
}