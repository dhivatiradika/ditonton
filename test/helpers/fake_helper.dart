import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_tv_bloc.dart';
import 'package:mockito/mockito.dart';

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieRecommendationsEvent extends Fake
    implements MovieRecommendationsEvent {}

class FakeMovieRecommendationsState extends Fake
    implements MovieRecommendationsState {}

class FakeMovieRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class FakeMovieSearchEvent extends Fake implements MovieSearchEvent {}

class FakeMovieSearchState extends Fake implements MovieSearchState {}

class FakeMovieSearchBloc extends MockBloc<MovieSearchEvent, MovieSearchState>
    implements MovieSearchBloc {}

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMoviesEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

class FakeNowPlayingTvsEvent extends Fake implements NowPlayingTvsEvent {}

class FakeNowPlayingTvsState extends Fake implements NowPlayingTvsState {}

class FakeNowPlayingTvsBloc
    extends MockBloc<NowPlayingTvsEvent, NowPlayingTvsState>
    implements NowPlayingTvsBloc {}

class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class FakePopularTvsEvent extends Fake implements PopularTvsEvent {}

class FakePopularTvsState extends Fake implements PopularTvsState {}

class FakePopularTvsBloc extends MockBloc<PopularTvsEvent, PopularTvsState>
    implements PopularTvsBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class FakeTopRatedTvsEvent extends Fake implements TopRatedTvsEvent {}

class FakeTopRatedTvsState extends Fake implements TopRatedTvsState {}

class FakeTopRatedTvsBloc extends MockBloc<TopRatedTvsEvent, TopRatedTvsState>
    implements TopRatedTvsBloc {}

class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvDetailState extends Fake implements TvDetailState {}

class FakeTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class FakeTvEpisodeEvent extends Fake implements TvEpisodeEvent {}

class FakeTvEpisodeState extends Fake implements TvEpisodeState {}

class FakeTvEpisodeBloc extends MockBloc<TvEpisodeEvent, TvEpisodeState>
    implements TvEpisodeBloc {}

class FakeTvRecommendationsEvent extends Fake
    implements TvRecommendationsEvent {}

class FakeTvRecommendationsState extends Fake
    implements TvRecommendationsState {}

class FakeTvRecommendationsBloc
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class FakeTvSearchEvent extends Fake implements TvSearchEvent {}

class FakeTvSearchState extends Fake implements TvSearchState {}

class FakeTvSearchBloc extends MockBloc<TvSearchEvent, TvSearchState>
    implements TvSearchBloc {}

class FakeWatchlistMovieEvent extends Fake implements WatchlistMovieEvent {}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class FakeWatchlistTvEvent extends Fake implements WatchlistTvEvent {}

class FakeWatchlistTvState extends Fake implements WatchlistTvState {}

class FakeWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}
