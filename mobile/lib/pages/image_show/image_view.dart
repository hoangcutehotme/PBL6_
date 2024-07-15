import 'package:app_detection_littering/core/size_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả nhận dạng'),
      ),
      body: Column(
        children: [
          // Text(imageUrl),
          Center(
            child: Image.network(imageUrl),
          ),
        ],
      ),
    );
  }
}
