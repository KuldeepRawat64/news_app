import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/stories/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  const Refresh({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
