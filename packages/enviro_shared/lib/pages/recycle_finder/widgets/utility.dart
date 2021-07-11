import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

const Map<String, String> mapRecyclable = {
  "Not_Recyclable": "غیر قابل بازیافت",
  "Recyclable": " قابل بازیافت",
  "Limited": "بازیافت محدود",
};

bool isRecyclable(String state) => state != "Not_Recyclable";

Color recyclableColor(String state, double opacity) => isRecyclable(state)
    ? Colors.green.withOpacity(opacity)
    : Colors.red.withOpacity(opacity);

const Map<String, Tuple3<String, bool, String>> mapCategory = {
  "glass": Tuple3<String, bool, String>("شیشه", true, "glass"),
  "compost": Tuple3<String, bool, String>("کمپست", true, "compost"),
  "plastic": Tuple3<String, bool, String>("پلاستیک", true, "plastic"),
  "paper": Tuple3<String, bool, String>("کاغذ", true, "paper"),
  "dangerous": Tuple3<String, bool, String>("خطرناک", true, "dangerous"),
  "metal": Tuple3<String, bool, String>("فلزی", true, "metal"),
};
