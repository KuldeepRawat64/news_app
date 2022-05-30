import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int id;
  const NewsDetail({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail Page'),
      ),
      body: Text('News Detail $id'),
    );
  }
}
