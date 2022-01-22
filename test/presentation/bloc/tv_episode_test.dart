import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_episode_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late TvEpisodeBloc tvEpisodeBloc;
  late MockGetEpisodeDetail mockGetEpisodeDetail;

  setUp(() {
    mockGetEpisodeDetail = MockGetEpisodeDetail();
    tvEpisodeBloc = TvEpisodeBloc(mockGetEpisodeDetail);
  });

  tearDown(() {
    tvEpisodeBloc.close();
  });

  test('initial state should be empty', () {
    expect(tvEpisodeBloc.state, TvEpisodeEmpty());
  });

  blocTest<TvEpisodeBloc, TvEpisodeState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetEpisodeDetail.execute(1, 1, 1))
          .thenAnswer((_) async => Right(testTVEpisode));
      return tvEpisodeBloc;
    },
    act: (bloc) => bloc.add(FetchEpisodeDetail(1, 1, 1)),
    expect: () => [
      TvEpisodeLoading(),
      TvEpisodeHasData(testTVEpisode),
    ],
    verify: (bloc) {
      verify(mockGetEpisodeDetail.execute(1, 1, 1));
    },
  );

  blocTest<TvEpisodeBloc, TvEpisodeState>(
    'Should emit [Loading, HasData] when data unsuccessfully loaded',
    build: () {
      when(mockGetEpisodeDetail.execute(1, 1, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvEpisodeBloc;
    },
    act: (bloc) => bloc.add(FetchEpisodeDetail(1, 1, 1)),
    expect: () => [
      TvEpisodeLoading(),
      TvEpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetEpisodeDetail.execute(1, 1, 1));
    },
  );
}
