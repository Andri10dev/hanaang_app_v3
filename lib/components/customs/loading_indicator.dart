import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget CustomLoadingIndicator({Color? color}) {
  return LoadingIndicator(
    indicatorType: Indicator.ballPulse,
    colors: [color ?? Colors.white],
    strokeWidth: 2,
    pathBackgroundColor: Colors.black,
  );
}
