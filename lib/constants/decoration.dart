// Widget decoration styles for containers;
//===================================================

import 'package:flutter/material.dart';

class DecorationConstants{
  static BoxDecoration whiteBox=BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-6, 6),
              blurRadius: 10)
        ],
      );
      static BoxDecoration whiteBoxLowRadius=BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-6, 6),
              blurRadius: 10)
        ],
      );
}