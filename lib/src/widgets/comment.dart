import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/src/models/item_model.dart';
import 'package:news_app/src/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final Map<int, Future<ItemModel>> itemMap;
  final int itemId;
  final int depth;
  const Comment({
    Key? key,
    required this.itemId,
    required this.itemMap,
    required this.depth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        final item = snapshot.data!;

        final children = <Widget>[
          ListTile(
            contentPadding:
                EdgeInsets.only(left: (depth + 1) * 16.0, right: 16.0),
            title: Html(data: item.text),
            subtitle: item.by == "" ? const Text("[deleted]") : Text(item.by),
          ),
          const Divider()
        ];

        // snapshot.data!.kids.forEach(
        //     (kidId) => children.add(Comment(itemId: kidId, itemMap: itemMap)));

        final kids = item.kids;
        for (var kid in kids) {
          children.add(Comment(
            itemId: kid,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        }

        return Column(
          children: children,
        );
      },
    );
  }

  // buildText(ItemModel item) {
  //   final text = item.text
  //       .replaceAll('&#x27;', "'")
  //       .replaceAll('<p>', '\n\n')
  //       .replaceAll('</p>', '');
  //   return Text(text);
  // }
}
