import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
