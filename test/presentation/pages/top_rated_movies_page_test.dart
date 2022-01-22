import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_helper.dart';

void main() {
  late FakeTopRatedMoviesBloc fakeTopRatedMoviesBloc;

  setUp(() {
    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedMoviesBloc = FakeTopRatedMoviesBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeTopRatedMoviesBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
