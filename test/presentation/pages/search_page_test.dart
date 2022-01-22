import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/fake_helper.dart';

void main() {
  late FakeMovieSearchBloc fakeMovieSearchBloc;
  late FakeTvSearchBloc fakeTvSearchBloc;

  setUp(() {
    registerFallbackValue(FakeMovieSearchEvent());
    registerFallbackValue(FakeMovieSearchState());
    fakeMovieSearchBloc = FakeMovieSearchBloc();

    registerFallbackValue(FakeTvSearchEvent());
    registerFallbackValue(FakeTvSearchState());
    fakeTvSearchBloc = FakeTvSearchBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeTvSearchBloc.close();
    fakeMovieSearchBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieSearchBloc>(
          create: (context) => fakeMovieSearchBloc,
        ),
        BlocProvider<TvSearchBloc>(
          create: (context) => fakeTvSearchBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display movie list when function search called',
      (WidgetTester tester) async {
    when(() => fakeMovieSearchBloc.state)
        .thenReturn(MovieSearchHasData(<Movie>[testMovie]));

    final list = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      tabIndex: 0,
    )));

    expect(list, findsOneWidget);
  });

  testWidgets('Page should display tv list when function search called',
      (WidgetTester tester) async {
    when(() => fakeTvSearchBloc.state)
        .thenReturn(TvSearchHasData(<TV>[testTV]));

    final list = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(SearchPage(
      tabIndex: 1,
    )));

    expect(list, findsOneWidget);
  });
}
