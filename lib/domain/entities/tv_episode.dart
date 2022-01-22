import 'package:equatable/equatable.dart';

class TVEpisode extends Equatable {
  TVEpisode({
    required this.airDate,
    required this.episodeNumber,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? airDate;
  final int episodeNumber;
  final String name;
  final String overview;
  final int id;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        name,
        overview,
        id,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
