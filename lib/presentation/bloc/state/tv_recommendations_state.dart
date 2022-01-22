part of '../bloc/tv_recommendations_bloc.dart';

abstract class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvRecommendationsEmpty extends TvRecommendationsState {}

class TvRecommendationsLoading extends TvRecommendationsState {}

class TvRecommendationsHasError extends TvRecommendationsState {
  final String message;

  TvRecommendationsHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecommendationsHasData extends TvRecommendationsState {
  final List<TV> tvs;

  TvRecommendationsHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
