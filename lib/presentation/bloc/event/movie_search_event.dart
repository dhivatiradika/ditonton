part of '../bloc/movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryMovieChanged extends MovieSearchEvent {
  final String query;

  OnQueryMovieChanged(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
