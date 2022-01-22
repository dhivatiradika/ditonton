part of '../bloc/watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {}

class AddWatchListMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddWatchListMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchListMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  RemoveFromWatchListMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatus extends WatchlistMovieEvent {
  final int id;

  LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
