import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/fake_helper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMoviesBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMoviesBloc;

  late FakeNowPlayingTvsBloc fakeNowPlayingTvsBloc;
  late FakePopularTvsBloc fakePopularTvsBloc;
  late FakeTopRatedTvsBloc fakeTopRatedTvsBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();

    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    fakePopularMoviesBloc = FakePopularMoviesBloc();

    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedMoviesBloc = FakeTopRatedMoviesBloc();

    registerFallbackValue(FakeNowPlayingTvsEvent());
    registerFallbackValue(FakeNowPlayingTvsState());
    fakeNowPlayingTvsBloc = FakeNowPlayingTvsBloc();

    registerFallbackValue(FakePopularTvsEvent());
    registerFallbackValue(FakePopularTvsState());
    fakePopularTvsBloc = FakePopularTvsBloc();

    registerFallbackValue(FakeTopRatedTvsEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedTvsBloc = FakeTopRatedTvsBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingMoviesBloc.close();
    fakePopularMoviesBloc.close();
    fakeTopRatedMoviesBloc.close();

    fakeNowPlayingTvsBloc.close();
    fakePopularTvsBloc.close();
    fakeTopRatedTvsBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMoviesBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMoviesBloc,
        ),
        BlocProvider<NowPlayingTvsBloc>(
          create: (context) => fakeNowPlayingTvsBloc,
        ),
        BlocProvider<PopularTvsBloc>(
          create: (context) => fakePopularTvsBloc,
        ),
        BlocProvider<TopRatedTvsBloc>(
          create: (context) => fakeTopRatedTvsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display tab bar when opened',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => fakePopularMoviesBloc.state).thenReturn(PopularMoviesLoading());
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesLoading());

    when(() => fakeNowPlayingTvsBloc.state).thenReturn(NowPlayingTvsLoading());
    when(() => fakePopularTvsBloc.state).thenReturn(PopularTvsLoading());
    when(() => fakeTopRatedTvsBloc.state).thenReturn(TopRatedTvsLoading());

    final tabBar = find.byType(TabBar);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(tabBar, findsOneWidget);
  });

  testWidgets('Page should display movie list when opened',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    when(() => fakeNowPlayingTvsBloc.state).thenReturn(NowPlayingTvsLoading());
    when(() => fakePopularTvsBloc.state).thenReturn(PopularTvsLoading());
    when(() => fakeTopRatedTvsBloc.state).thenReturn(TopRatedTvsLoading());

    final list = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(list, findsNWidgets(3));
  });

  testWidgets('Page should display tv list when opened',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(<Movie>[]));
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(<Movie>[]));
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMoviesHasData(<Movie>[]));

    when(() => fakeNowPlayingTvsBloc.state)
        .thenReturn(NowPlayingTvsHasData(testTVList));
    when(() => fakePopularTvsBloc.state).thenReturn(PopularTvsHasData(<TV>[]));
    when(() => fakeTopRatedTvsBloc.state)
        .thenReturn(TopRatedTvsHasData(testTVList));

    final list = find.byType(ListView);
    await tester.pumpWidget(_makeTestableWidget(Scaffold(body: TVSection())));

    expect(list, findsNWidgets(3));
  });
}
