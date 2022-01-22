import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part '../event/tv_detail_event.dart';
part '../state/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail _getTVDetail;

  TvDetailBloc(this._getTVDetail) : super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());

      final result = await _getTVDetail.execute(event.id);

      result.fold(
        (failure) => emit(
          TvDetailError(failure.message),
        ),
        (data) => emit(
          TvDetailHasData(data),
        ),
      );
    });
  }
}
