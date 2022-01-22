import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_helper.dart';

void main() {
  late FakePopularMoviesBloc fakePopularMoviesBloc;

  setUp(() {
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakeMovieDetailState());

    fakePopularMoviesBloc = FakePopularMoviesBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakePopularMoviesBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
