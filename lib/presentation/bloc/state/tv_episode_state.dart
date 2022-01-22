part of '../bloc/tv_episode_bloc.dart';

abstract class TvEpisodeState extends Equatable {
  const TvEpisodeState();

  @override
  List<Object> get props => [];
}

class TvEpisodeEmpty extends TvEpisodeState {}

class TvEpisodeLoading extends TvEpisodeState {}

class TvEpisodeError extends TvEpisodeState {
  final String message;

  TvEpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

class TvEpisodeHasData extends TvEpisodeState {
  final TVEpisode tvEpisode;

  TvEpisodeHasData(this.tvEpisode);

  @override
  List<Object> get props => [tvEpisode];
}
