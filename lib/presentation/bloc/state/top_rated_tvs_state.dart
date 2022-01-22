part of '../bloc/top_rated_tvs_bloc.dart';

abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class TopRatedTvsEmpty extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState {}

class TopRatedTvsError extends TopRatedTvsState {
  final String message;

  TopRatedTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvsHasData extends TopRatedTvsState {
  final List<TV> tvs;

  TopRatedTvsHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
