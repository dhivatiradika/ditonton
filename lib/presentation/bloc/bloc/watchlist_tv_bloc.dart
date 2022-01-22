import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:ditonton/domain/usecases/tv/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';

part '../event/watchlist_tv_event.dart';
part '../state/watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTVs _getWatchlistTVs;
  final GetTVWatchListStatus _getTVWatchListStatus;
  final SaveTVWatchlist _saveTVWatchlist;
  final RemoveTVWatchlist _removeTVWatchlist;

  WatchlistTvBloc(this._getWatchlistTVs, this._getTVWatchListStatus,
      this._saveTVWatchlist, this._removeTVWatchlist)
      : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async => _fetchWatchlistTv(event, emit));

    on<AddWatchListTv>((event, emit) async => _addWatchListTv(event, emit));

    on<RemoveFromWatchListTv>(
        (event, emit) async => _removeWatchListTv(event, emit));

    on<LoadWatchlistTvStatus>(
        (event, emit) async => _loadWatchListTv(event, emit));
  }

  Future<void> _fetchWatchlistTv(
      FetchWatchlistTv event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoading());

    final result = await _getWatchlistTVs.execute();

    result.fold(
      (failure) => emit(
        WatchlistTvError(failure.message),
      ),
      (data) => emit(
        WatchlistTvHasData(data),
      ),
    );
  }

  Future<void> _addWatchListTv(
      AddWatchListTv event, Emitter<WatchlistTvState> emit) async {
    final result = await _saveTVWatchlist.execute(event.tv);

    result.fold(
      (failure) => emit(
        IsAddedToWatchListTv(false, failure.message),
      ),
      (data) => emit(
        IsAddedToWatchListTv(true, data),
      ),
    );
  }

  Future<void> _removeWatchListTv(
      RemoveFromWatchListTv event, Emitter<WatchlistTvState> emit) async {
    final result = await _removeTVWatchlist.execute(event.tv);

    result.fold(
      (failure) => emit(
        IsAddedToWatchListTv(true, failure.message),
      ),
      (data) => emit(
        IsAddedToWatchListTv(false, data),
      ),
    );
  }

  Future<void> _loadWatchListTv(
      LoadWatchlistTvStatus event, Emitter<WatchlistTvState> emit) async {
    final result = await _getTVWatchListStatus.execute(event.id);

    emit(IsAddedToWatchListTv(result, ''));
  }
}
