part of '../bloc/tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTvChanged extends TvSearchEvent {
  final String query;

  OnQueryTvChanged(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
