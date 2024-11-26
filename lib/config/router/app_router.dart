import 'package:flutter_application_1/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieID = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieID);
          }
        )
      ]
    ),

  ]
);