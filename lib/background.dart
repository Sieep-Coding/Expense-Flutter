import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Container(
        color: Colors.black,
        child: const Center(
          child: Icon(
            Icons.hiking,
            size: 200,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
