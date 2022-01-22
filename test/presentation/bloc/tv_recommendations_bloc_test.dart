import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTVRecommendations mockGetTVRecommendations;

  setUp(() {
    mockGetTVRecommendations = MockGetTVRecommendations();
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTVRecommendations);
  });

  tearDown(() {
    tvRecommendationsBloc.close();
  });

  test('initial state should be empty', () {
    expect(tvRecommendationsBloc.state, TvRecommendationsEmpty());
  });

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTVList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(1)),
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsHasData(testTVList),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendations.execute(1));
    },
  );

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [Loading, HasData] when data unsuccessfully loaded',
    build: () {
      when(mockGetTVRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendations(1)),
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVRecommendations.execute(1));
    },
  );
}
