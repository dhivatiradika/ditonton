import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingTVs();
  Future<Either<Failure, List<TV>>> getPopularTVs();
  Future<Either<Failure, List<TV>>> getTopRatedTVs();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTVs(String query);
  Future<Either<Failure, String>> saveTVWatchlist(TVDetail tv);
  Future<Either<Failure, String>> removeTVWatchlist(TVDetail tv);
  Future<bool> isAddedToTVWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTVs();
  Future<Either<Failure, TVEpisode>> getEpisodeDetail(
      int id, int season, int episode);
}
