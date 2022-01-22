import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/fake_helper.dart';

void main() {
  late FakeTvDetailBloc fakeTvDetailBloc;
  late FakeTvRecommendationsBloc fakeTvRecommendationsBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;
  late FakeTvEpisodeBloc fakeTvEpisodeBloc;

  setUp(() {
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    fakeTvDetailBloc = FakeTvDetailBloc();

    registerFallbackValue(FakeTvRecommendationsEvent());
    registerFallbackValue(FakeTvRecommendationsState());
    fakeTvRecommendationsBloc = FakeTvRecommendationsBloc();

    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());
    fakeWatchlistTvBloc = FakeWatchlistTvBloc();

    registerFallbackValue(FakeTvEpisodeEvent());
    registerFallbackValue(FakeTvEpisodeState());
    fakeTvEpisodeBloc = FakeTvEpisodeBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeTvDetailBloc.close();
    fakeTvRecommendationsBloc.close();
    fakeWatchlistTvBloc.close();
    fakeTvEpisodeBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => fakeTvDetailBloc,
        ),
        BlocProvider<TvRecommendationsBloc>(
          create: (context) => fakeTvRecommendationsBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => fakeWatchlistTvBloc,
        ),
        BlocProvider<TvEpisodeBloc>(
          create: (context) => fakeTvEpisodeBloc,
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
    when(() => fakeTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTVDetail));
    when(() => fakeTvRecommendationsBloc.state)
        .thenReturn(TvRecommendationsHasData(<TV>[]));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(IsAddedToWatchListTv(false, ''));

    when(() => fakeTvEpisodeBloc.state)
        .thenReturn(TvEpisodeHasData(testEpisodeDetail));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTVDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTVDetail));
    when(() => fakeTvRecommendationsBloc.state)
        .thenReturn(TvRecommendationsHasData(<TV>[]));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(IsAddedToWatchListTv(true, ''));

    when(() => fakeTvEpisodeBloc.state)
        .thenReturn(TvEpisodeHasData(testEpisodeDetail));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTVDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTVDetail));
    when(() => fakeTvRecommendationsBloc.state)
        .thenReturn(TvRecommendationsHasData(testTVList));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(IsAddedToWatchListTv(false, 'Added to Watchlist'));

    when(() => fakeTvEpisodeBloc.state)
        .thenReturn(TvEpisodeHasData(testEpisodeDetail));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading data',
      (WidgetTester tester) async {
    when(() => fakeTvDetailBloc.state).thenReturn(TvDetailLoading());
    when(() => fakeTvRecommendationsBloc.state)
        .thenReturn(TvRecommendationsHasData(<TV>[]));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(IsAddedToWatchListTv(false, ''));

    when(() => fakeTvEpisodeBloc.state)
        .thenReturn(TvEpisodeHasData(testEpisodeDetail));

    final watchlistButtonIcon = find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_makeTestableWidget(TVDetailPage(id: testTVDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
