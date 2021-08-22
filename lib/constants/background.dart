import 'dart:ui';
import 'package:flutter/material.dart';

class AppBackground {
  static LinearGradient gradientBackground(MaterialColor color) {
    return LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        color[300]!,
        color[500]!,
        color[600]!,
        color[800]!,
      ],
    );
  }

  static DecorationImage assetImageBackground(String asset) {
    return DecorationImage(
      image: new AssetImage(asset),
      fit: BoxFit.cover,
    );
  }

  static BackdropFilter backgroundFilter(bool isDarkMode) {
    double sigma = isDarkMode ? 8 : 2;
    double opacity = isDarkMode ? 0.5 : 0.0;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: Colors.black.withOpacity(opacity),
      ),
    );
  }
}
