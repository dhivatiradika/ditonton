import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late NowPlayingTvsBloc nowPlayingTvsBloc;
  late MockGetNowPlayingTVs mockGetNowPlayingTVs;

  setUp(() {
    mockGetNowPlayingTVs = MockGetNowPlayingTVs();
    nowPlayingTvsBloc = NowPlayingTvsBloc(mockGetNowPlayingTVs);
  });

  tearDown(() {
    nowPlayingTvsBloc.close();
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvsBloc.state, NowPlayingTvsEmpty());
  });

  blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return nowPlayingTvsBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvs()),
    expect: () => [
      NowPlayingTvsLoading(),
      NowPlayingTvsHasData(testTVList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVs.execute());
    },
  );

  blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvsBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvs()),
    expect: () => [
      NowPlayingTvsLoading(),
      NowPlayingTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVs.execute());
    },
  );
}
