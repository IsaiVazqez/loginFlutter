import 'package:flutter/material.dart';
import 'package:login/widgets/widgets.dart';

class ProductSreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [ProductImage()],
          ),
        ],
      )),
    );
  }
}
