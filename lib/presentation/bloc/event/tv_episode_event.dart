part of '../bloc/tv_episode_bloc.dart';

abstract class TvEpisodeEvent extends Equatable {
  const TvEpisodeEvent();

  @override
  List<Object> get props => [];
}

class FetchEpisodeDetail extends TvEpisodeEvent {
  final int id;
  final int season;
  final int episode;

  FetchEpisodeDetail(this.id, this.season, this.episode);

  @override
  List<Object> get props => [id, season, episode];
}
