import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/comments/comments_bloc.dart';
import 'package:news_app/src/blocs/comments/comments_provider.dart';
import 'package:news_app/src/widgets/comment.dart';
import '../models/item_model.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  const NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail Page'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    // // One approach
    // final children = <Widget>[];
    // children.add(buildTitle(item));
    // final commentsList = item.kids
    //     .map((kidId) => Comment(itemId: kidId, itemMap: itemMap))
    //     .toList();
    // children.addAll(commentsList);

    // return ListView(
    //   children: children,
    // );

    // different approach
    final commentsList = item.kids
        .map((kidId) => Comment(itemId: kidId, itemMap: itemMap, depth: 0))
        .toList();

    return ListView(
      children: [
        buildTitle(item),
        ...commentsList,
      ],
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final itemFuture = snapshot.data![itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
