import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/fake_helper.dart';

void main() {
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;

  setUp(() {
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();

    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());
    fakeWatchlistTvBloc = FakeWatchlistTvBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeWatchlistMovieBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => fakeWatchlistTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display tab bar when openend',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(<Movie>[testMovie]));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(WatchlistTvHasData(<TV>[testTV]));

    final tabBar = find.byType(TabBar);

    await tester.pumpWidget(_makeTestableWidget(WatchListPage()));

    expect(tabBar, findsOneWidget);
  });

  testWidgets('Page should display list when openend',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(<Movie>[testMovie]));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(WatchlistTvHasData(<TV>[testTV]));

    final list = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchListPage()));
    await tester.pumpWidget(_makeTestableWidget(Scaffold(
      body: WatchlistTVsPage(),
    )));

    expect(list, findsOneWidget);
  });
}
