import 'package:news_app/src/models/item_model.dart';
import 'package:news_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repository = Repository();

// Streams
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

// Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

// Constuctor
  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  // Transformer
  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      cache[id]?.then((ItemModel item) {
        final kids = item.kids;
        for (var kid in kids) {
          fetchItemWithComments(kid);
        }
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
