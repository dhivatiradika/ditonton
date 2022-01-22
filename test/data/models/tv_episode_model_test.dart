import 'package:ditonton/data/models/tv_episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTVEpisodeModel = TVEpisodeModel(
      airDate: 'airDate',
      episodeNumber: 1,
      name: 'name',
      overview: 'overview',
      id: 1,
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1);

  final tTVEpisode = testEpisodeDetail;

  test('should be a subclass of TV Episode entity', () async {
    final result = tTVEpisodeModel.toEntity();
    expect(result, tTVEpisode);
  });
}
