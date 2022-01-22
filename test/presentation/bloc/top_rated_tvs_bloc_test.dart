import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late TopRatedTvsBloc topRatedTvsBloc;
  late MockGetTopRatedTVs mockGetTopRatedTVs;

  setUp(() {
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTVs);
  });

  tearDown(() {
    topRatedTvsBloc.close();
  });

  test('initial state should be empty', () {
    expect(topRatedTvsBloc.state, TopRatedTvsEmpty());
  });

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsHasData(testTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );
}
