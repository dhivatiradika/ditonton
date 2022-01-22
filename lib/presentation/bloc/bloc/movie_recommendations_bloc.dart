import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part '../event/movie_recommendations_event.dart';
part '../state/movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<FetchMovieRecommendations>((event, emit) async {
      emit(MovieRecommendationsLoading());

      final result = await _getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(
          MovieRecommendationsError(failure.message),
        ),
        (data) => emit(
          MovieRecommendationsHasData(data),
        ),
      );
    });
  }
}
