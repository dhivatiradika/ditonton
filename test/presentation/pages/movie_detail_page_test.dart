import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/fake_helper.dart';

void main() {
  late FakeMovieDetailBloc fakeMovieDetailBloc;
  late FakeMovieRecommendationsBloc fakeMovieRecommendationsBloc;
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;

  setUp(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    fakeMovieDetailBloc = FakeMovieDetailBloc();

    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    fakeMovieRecommendationsBloc = FakeMovieRecommendationsBloc();

    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeWatchlistMovieBloc.close();
    fakeMovieRecommendationsBloc.close();
    fakeWatchlistMovieBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => fakeMovieDetailBloc,
        ),
        BlocProvider<MovieRecommendationsBloc>(
          create: (context) => fakeMovieRecommendationsBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => fakeWatchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(<Movie>[]));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(IsAddedToWatchListMovie(false, ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(<Movie>[]));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(IsAddedToWatchListMovie(true, ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(<Movie>[]));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(IsAddedToWatchListMovie(false, 'Added to Watchlist'));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Page should dispay progress dialog when loading data',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(<Movie>[]));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(IsAddedToWatchListMovie(true, ''));

    final watchlistButtonIcon = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
