import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_helper.dart';

void main() {
  late FakeTopRatedTvsBloc fakeTopRatedTvsBloc;

  setUp(() {
    registerFallbackValue(FakeTopRatedTvsEvent());
    registerFallbackValue(FakeTopRatedTvsState());
    fakeTopRatedTvsBloc = FakeTopRatedTvsBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeTopRatedTvsBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopRatedTvsBloc>(
          create: (context) => fakeTopRatedTvsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvsBloc.state).thenReturn(TopRatedTvsLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvsBloc.state)
        .thenReturn(TopRatedTvsHasData(<TV>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvsBloc.state)
        .thenReturn(TopRatedTvsError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVsPage()));

    expect(textFinder, findsOneWidget);
  });
}
