import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TVEpisodeModel extends Equatable {
  TVEpisodeModel({
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

  factory TVEpisodeModel.fromJson(Map<String, dynamic> json) => TVEpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "name": name,
        "overview": overview,
        "id": id,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVEpisode toEntity() {
    return TVEpisode(
        airDate: airDate,
        episodeNumber: episodeNumber,
        name: name,
        overview: overview,
        id: id,
        productionCode: productionCode,
        seasonNumber: seasonNumber,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

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
