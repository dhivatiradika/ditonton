import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part '../event/watchlist_movie_event.dart';
part '../state/watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>(
        (event, emit) async => _fetchWatchlistMovie(event, emit));

    on<AddWatchListMovie>(
        (event, emit) async => _addWatchListMovie(event, emit));

    on<RemoveFromWatchListMovie>(
        (event, emit) async => _removeWatchListMovie(event, emit));

    on<LoadWatchlistMovieStatus>(
        (event, emit) async => _loadWatchListMovie(event, emit));
  }

  Future<void> _fetchWatchlistMovie(
      FetchWatchlistMovie event, Emitter<WatchlistMovieState> emit) async {
    emit(WatchlistMovieLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) => emit(
        WatchlistMovieError(failure.message),
      ),
      (data) => emit(
        WatchlistMovieHasData(data),
      ),
    );
  }

  Future<void> _addWatchListMovie(
      AddWatchListMovie event, Emitter<WatchlistMovieState> emit) async {
    final result = await _saveWatchlist.execute(event.movie);

    result.fold(
      (failure) => emit(
        IsAddedToWatchListMovie(false, failure.message),
      ),
      (data) => emit(
        IsAddedToWatchListMovie(true, data),
      ),
    );
  }

  Future<void> _removeWatchListMovie(
      RemoveFromWatchListMovie event, Emitter<WatchlistMovieState> emit) async {
    final result = await _removeWatchlist.execute(event.movie);

    result.fold(
      (failure) => emit(
        IsAddedToWatchListMovie(true, failure.message),
      ),
      (data) => emit(
        IsAddedToWatchListMovie(false, data),
      ),
    );
  }

  Future<void> _loadWatchListMovie(
      LoadWatchlistMovieStatus event, Emitter<WatchlistMovieState> emit) async {
    final result = await _getWatchListStatus.execute(event.id);

    emit(IsAddedToWatchListMovie(result, ''));
  }
}
