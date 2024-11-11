import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ana Sayfa İçeriği',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
