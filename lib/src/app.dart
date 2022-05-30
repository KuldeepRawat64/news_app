import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/stories/stories_provider.dart';
import 'package:news_app/src/screens/new_detail.dart';

import 'screens/news_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        home: const NewsList(),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const NewsList());
    } else {
      return MaterialPageRoute(builder: ((context) {
        final itemId = int.parse(settings.name!.replaceFirst('/', ''));
        return NewsDetail(id: itemId);
      }));
    }
  }
}
