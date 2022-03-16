import 'dart:math';

import 'package:flutter/material.dart';

degToRad(num deg) => deg * (pi / 180.0);

normalize(value, min, max) => ((value - min) / (max - min));

const Color kScaffoldBackgroundColor = Color(0xFFF3FBFA);
const double kDiameter = 300;
const double kMinDegree = 16;
const double kMaxDegree = 28;
