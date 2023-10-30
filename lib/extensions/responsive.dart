import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  double width(double widh) {
    return MediaQuery.sizeOf(this).width * (widh / 430);
  }

  double height(double hit) {
    return MediaQuery.sizeOf(this).width * (hit / 932);
  }
}
