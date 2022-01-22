import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late PopularTvsBloc popularTvsBloc;
  late MockGetPopularTVs mockGetPopularTVs;

  setUp(() {
    mockGetPopularTVs = MockGetPopularTVs();
    popularTvsBloc = PopularTvsBloc(mockGetPopularTVs);
  });

  tearDown(() {
    popularTvsBloc.close();
  });

  test('initial state should be empty', () {
    expect(popularTvsBloc.state, PopularTvsEmpty());
  });

  blocTest<PopularTvsBloc, PopularTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsHasData(testTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<PopularTvsBloc, PopularTvsState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Fialure')));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsError('Server Fialure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );
}
