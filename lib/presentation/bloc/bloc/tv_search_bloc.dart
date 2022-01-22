import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part '../event/tv_search_event.dart';
part '../state/tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTVs _searchTVs;

  TvSearchBloc(this._searchTVs) : super(TvSearchEmpty()) {
    on<OnQueryTvChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await _searchTVs.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          emit(TvSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
