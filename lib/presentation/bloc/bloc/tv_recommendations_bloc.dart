import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part '../event/tv_recommendations_event.dart';
part '../state/tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTVRecommendations _getTVRecommendations;
  TvRecommendationsBloc(this._getTVRecommendations)
      : super(TvRecommendationsEmpty()) {
    on<FetchTvRecommendations>((event, emit) async {
      emit(TvRecommendationsLoading());

      final result = await _getTVRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(TvRecommendationsHasError(failure.message)),
        (data) => emit(
          TvRecommendationsHasData(data),
        ),
      );
    });
  }
}
