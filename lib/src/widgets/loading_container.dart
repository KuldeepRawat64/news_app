import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(60.0),
          subtitle: buildContainer(20.0),
        ),
        const Divider(
          height: 4.0,
          color: Colors.black26,
        ),
      ],
    );
  }

  Widget buildContainer(double itemWidth) {
    return Container(
      height: 14.0,
      width: itemWidth,
      color: Colors.grey[200],
    );
  }
}
