import 'dart:async';
import '../resources/news_api_provider.dart';
import '../resources//news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = [
    NewsApiProvider(),
    newsDbProvider,
  ];

  List<Cache> caches = [
    newsDbProvider,
  ];

  // Iterate over sources when dbprovider gets fetchTopIds implemented
  Future<List<int>>? fetchTopIds() {
    return sources[0].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel? item;
    // ignore: prefer_typing_uninitialized_variables
    var source;

    // Checking if item exist in the database if it doesn't exist will call the api
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    // Storing the new item in database for later use
    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    // Returning the item
    return item!;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>>? fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel? item);
  Future<int> clear();
}
