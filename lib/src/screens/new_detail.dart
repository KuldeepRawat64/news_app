import 'package:flutter/material.dart';
import 'package:news_app/src/blocs/comments/comments_bloc.dart';
import 'package:news_app/src/blocs/comments/comments_provider.dart';

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

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading');
        }
        final itemFuture = snapshot.data![itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const Text('loading');
            }
            return Text(itemSnapshot.data!.title);
          },
        );
      },
    );
  }
}
