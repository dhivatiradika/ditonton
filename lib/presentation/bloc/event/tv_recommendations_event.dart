part of '../bloc/tv_recommendations_bloc.dart';

abstract class TvRecommendationsEvent extends Equatable {
  const TvRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchTvRecommendations extends TvRecommendationsEvent {
  final int id;

  FetchTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
