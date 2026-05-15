import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

Future<String?> imageURL() async {
  // First attempt is to check wether there is an image with current date 2025-11-27 in folder
  final now = DateTime.now();
  final dateString =
      "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  final testUrl =
      "https://cdn.amsl.app/amsl-content/p/special-images/$dateString.png";
  if (await testURL(testUrl)) {
    return testUrl;
  } else {
    // Check if there is an image at default image path
    final testUrl =
        "https://cdn.amsl.app/amsl-content/p/special-images/default.png";
    if (await testURL(testUrl)) {
      return testUrl;
    }
  }
  return null;
}

Future<bool> testURL(String url) async {
  // Check if there is an image at given URL
  final response = await http.head(Uri.parse(url));
  return response.statusCode == 200;
}

// Singleton to check for available special image just once
final Future<String?> _imagePath = imageURL();

Widget loadSpecialImage() {
  // Check if there is an special im
  return FutureBuilder<String?>(
    future: _imagePath,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox.shrink(); // Still loading
      } else if (snapshot.hasError || snapshot.data == null) {
        return SizedBox.shrink(); // No image available
      } else {
        // Load and cache the Image
        return LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                Image.network(snapshot.data!, width: constraints.maxWidth),
              ],
            );
          },
        );
      }
    },
  );
}

Widget backgroundImage() {
  return FutureBuilder<String?>(
    future: _imagePath,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
      } else if (snapshot.hasError || snapshot.data == null) {
      } else {
        // Load and cache the Image
        return SizedBox.shrink();
      }
      return Positioned(
        left: -20,
        top: 10,
        child: SvgPicture.asset(
          "assets/images/highlights/floater.svg",
          width: 250,
        ),
      );
    },
  );
}
