import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  tearDown(() {
    movieRecommendationsBloc.close();
  });

  test('initial state should be empty', () {
    expect(movieRecommendationsBloc.state, MovieRecommendationsEmpty());
  });

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendations(1)),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendations(1)),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(1));
    },
  );
}
