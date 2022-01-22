part of '../bloc/watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class IsAddedToWatchListTv extends WatchlistTvState {
  final bool isAdded;
  final String message;

  IsAddedToWatchListTv(this.isAdded, this.message);

  @override
  List<Object> get props => [isAdded, message];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  final List<TV> tvs;

  WatchlistTvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
