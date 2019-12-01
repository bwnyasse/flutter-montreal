import 'dart:convert';

import 'package:flutter_movie_deep_dive_test/src/models/models.dart';
import 'package:flutter_movie_deep_dive_test/src/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import '../common.dart';

main() {
  group('loadMovies', () {
    test('status == 200', () async {
      // TODO: 1- Provides Mock Client
      /*
          final mockClient = MockClient((request) async {
            return Response(json.encode(exampleJsonResponse), 200);
          });
       */
      final service = AppService(Client());
      final expectedResponse = MoviesResponse.fromJson(exampleJsonResponse);
      final actualResponse = await service.loadMovies();
      expect(actualResponse.movies.length, 1);
      expect(actualResponse, equals(expectedResponse));
    });

    // TODO: 2- Show Code coverage and bring it to 100%
    /* 
   test('status != 200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(exampleJsonResponse), 500);
      });
      final service = AppService(mockClient);
      expect(
        () async => await service.loadMovies(),
        throwsA(predicate((e) =>
            e is LoadMoviesException &&
            e.message == 'LoadMovies - Request Error: 500')),
      );
    }); 
    */
  });
}
