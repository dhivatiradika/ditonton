import 'package:ditonton/presentation/bloc/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTVsPageState createState() => _PopularTVsPageState();
}

class _PopularTVsPageState extends State<PopularTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvsBloc>().add(FetchPopularTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvsBloc, PopularTvsState>(
          builder: (context, state) {
            if (state is PopularTvsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TVCard(tv);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is PopularTvsError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
