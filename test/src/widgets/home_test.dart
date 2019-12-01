import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_deep_dive_test/src/blocs/blocs.dart';
import 'package:flutter_movie_deep_dive_test/src/models/models.dart';
import 'package:flutter_movie_deep_dive_test/src/providers/providers.dart';
import 'package:flutter_movie_deep_dive_test/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

import '../common.dart';

class UnknowState extends AppState {}

void main() {
  AppServiceMock serviceMock;
  AppBloc appBloc;
  MoviesResponse response;
  setUp(() {
    serviceMock = AppServiceMock();
    response = MoviesResponse.fromJson(exampleJsonResponse2);
    when(serviceMock.loadMovies()).thenAnswer((_) => Future.value(response));
  });

  tearDown(() {
    appBloc?.close();
  });

  group('Display Home', () {
    testWidgets('state: AppLoading', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppProvider(
              child: BlocProvider(
                builder: (context) =>
                    AppBloc(service: serviceMock, initWithState: AppLoading()),
                child: MyHomePage(title: 'Test Widget'),
              ),
            ),
          ),
        ),
      );

      Finder textFinder = find.byType(CircularProgressIndicator);
      expect(textFinder, findsOneWidget);
    });

    testWidgets('state: AppLoaded', (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProvider(
                child: BlocProvider(
                  builder: (context) => AppBloc(
                      service: serviceMock,
                      initWithState: AppLoaded(response: response)),
                  child: MyHomePage(title: 'Test Widget'),
                ),
              ),
            ),
          ),
        );

        Finder textFinder = find.byType(MoviesList);
        expect(textFinder, findsOneWidget);
      });
    });

    testWidgets('state: AppError', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppProvider(
              httpClient: Client(),
              child: BlocProvider(
                builder: (context) =>
                    AppBloc(service: serviceMock, initWithState: AppError()),
                child: MyHomePage(title: 'Test Widget'),
              ),
            ),
          ),
        ),
      );

      Finder textFinder = find.text('Something went wrong!');
      expect(textFinder, findsOneWidget);
    });

    testWidgets('state: unknow', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppProvider(
              httpClient: null,
              child: BlocProvider(
                builder: (context) =>
                    AppBloc(service: serviceMock, initWithState: UnknowState()),
                child: MyHomePage(title: 'Test Widget'),
              ),
            ),
          ),
        ),
      );

      Finder textFinder = find.text('Wait ...');
      expect(textFinder, findsOneWidget);
    });
  });
}