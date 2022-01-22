import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetEpisodeDetail {
  final TVRepository repository;

  GetEpisodeDetail(this.repository);

  Future<Either<Failure, TVEpisode>> execute(int id, int season, int episode) {
    return repository.getEpisodeDetail(id, season, episode);
  }
}
