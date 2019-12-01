import 'package:flutter/material.dart';
import 'package:flutter_movie_deep_dive_test/src/models/models.dart';
import 'package:flutter_movie_deep_dive_test/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';

import '../common.dart';

void main() {
  MoviesResponse exampleResponse;
  Movie movie;

  setUp(() {
    exampleResponse = MoviesResponse.fromJson(exampleJsonResponse);
    movie = exampleResponse.movies.first;
  });

  testWidgets('Display Movie Card', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(
              //TODO 1- Provide a key to identify your widget
              key: Key("${movie.id}"),
              data: movie,
            ),
          ),
        ),
      );


      // TODO 2- Use Finder API , check every content you want
      final movieFinder = find.byType(MovieCard);
      expect(movieFinder, findsOneWidget);

      Finder textFinder = find.text(movie.title);
      expect(textFinder, findsOneWidget);

      textFinder = find.text(movie.overview);
      expect(textFinder, findsOneWidget);

      textFinder = find.text(movie.releaseDate);
      expect(textFinder, findsOneWidget);
    });
  });
}