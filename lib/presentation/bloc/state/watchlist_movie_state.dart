part of '../bloc/watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class IsAddedToWatchListMovie extends WatchlistMovieState {
  final bool isAdded;
  final String message;

  IsAddedToWatchListMovie(this.isAdded, this.message);

  @override
  List<Object> get props => [isAdded, message];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> movies;

  WatchlistMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
