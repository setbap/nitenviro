import 'package:flutter/material.dart';

const Map<String, String> mapCategory = {
  "glass": "شیشه",
  "compost": "کمپست",
  "plastic": "پلاستیک",
  "paper": "کاغذ",
  "dangerous": "خطرناک",
  "metal": "فلزی",
};

const Map<String, String> mapRecyclable = {
  "Not_Recyclable": "غیر قابل بازیافت",
  "Recyclable": " قابل بازیافت",
  "Limited": "بازیافت محدود",
};

bool isRecyclable(String state) => state != "Not_Recyclable";

Color recyclableColor(String state, double opacity) => isRecyclable(state)
    ? Colors.green.withOpacity(opacity)
    : Colors.red.withOpacity(opacity);
