import '../../models/item_model.dart';
import '../../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to streams
  Stream<List<int>> get topIds => _topIds.stream;

  ValueStream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;

  // Getters to sink;
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids!);
  }

  clearCache() {
    return _repository.clearCache();
  }

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformers()).pipe(_itemsOutput);
  }

  _itemsTransformers() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>>? cache, int id, _) {
        cache![id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
