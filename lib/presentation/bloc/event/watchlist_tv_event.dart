part of '../bloc/watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTv extends WatchlistTvEvent {}

class AddWatchListTv extends WatchlistTvEvent {
  final TVDetail tv;

  AddWatchListTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchListTv extends WatchlistTvEvent {
  final TVDetail tv;

  RemoveFromWatchListTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistTvStatus extends WatchlistTvEvent {
  final int id;

  LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
