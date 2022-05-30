import 'package:news_app/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    //setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client =
        MockClient((request) async => Response(json.encode([1, 2, 3, 4]), 200));

    //expectation
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItem returns a itemModel', () async {
    final newsApi = NewsApiProvider();
    var jsonData = {'id': 123};
    newsApi.client =
        MockClient((request) async => Response(json.encode(jsonData), 200));

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
