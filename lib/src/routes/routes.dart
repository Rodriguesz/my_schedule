import 'package:go_router/go_router.dart';
import 'package:my_schedule/src/pages/agenda_page.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AgendaPage(),
    ),
    // GoRoute(
    //   path: '/calendar/activity/:index',
    //   builder: (context, state) {
    //     final params = state.pathParameters; // Obter os parâmetros da rota
    //     final index =
    //         int.parse(params['index']!); // Acessar o parâmetro 'index'
    //     return ActivityPage(index: index);
    //   },
    // ),
    // GoRoute(
    //   path: '/calendar/activity/speaker/:speaker',
    //   builder: (context, state) {
    //     final params = state.pathParameters;
    //     final speakerJson = params['speaker']!;
    //     final speaker = Orador.fromJson(jsonDecode(speakerJson));
    //     return SpeakerPage(orador: speaker);
    //   },
    // ),
  ],
);
