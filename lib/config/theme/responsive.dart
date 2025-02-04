import 'dart:math' as math;
import 'package:flutter/material.dart';

class Responsive {
  final double width;
  final double height;
  final double diagonal;
  final bool isTablet;

  // More readable constructor
  Responsive(BuildContext context)
      : width = _getWidth(context),
        height = _getHeight(context),
        diagonal = _calculateDiagonal(context),
        isTablet = _isTablet(context);

  // Private methods for clear initialization
  static double _getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double _getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;
  // Calculation of the diagonal
  static double _calculateDiagonal(BuildContext context) {
    final width = _getWidth(context);
    final height = _getHeight(context);
    return math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }

  // Static method to get the instance of Responsive
  static Responsive of(BuildContext context) => Responsive(context);

  // Methods to get relative dimensions
  double wp(double percent) => width * percent / 100;
  double hp(double percent) => height * percent / 100;
  double dp(double percent) => diagonal * percent / 100;
}