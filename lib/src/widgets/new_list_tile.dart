import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/stories/stories_provider.dart';
import 'package:news_app/src/widgets/loading_container.dart';

import '../models/item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  const NewsListTile({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data![itemId],
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const LoadingContainer();
            }
            return buildListTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildListTile(BuildContext context, ItemModel? item) {
    return Column(
      children: [
        ListTile(
          onTap: (() => Navigator.pushNamed(context, '/${item!.id}')),
          title: Text(item!.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: [
              const Icon(Icons.comment_outlined),
              Text('${item.descendants}')
            ],
          ),
        ),
        const Divider(
          height: 4.0,
          color: Colors.black26,
        ),
      ],
    );
  }
}
