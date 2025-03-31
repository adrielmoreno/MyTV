import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_modules.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../../../common/controllers/session_controller.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../widgets/movie_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    final sessionController = inject<SessionController>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder(
                    future: inject<TrendingRepository>().getMoviesAndSeries(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.hasData) {
                        final moviesResponse = snapshot.data!;
                        final movies = moviesResponse.success?.results ?? [];

                        if (movies.isEmpty) {
                          return const Text('No movies found');
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(media: movies[index]);
                          },
                        );
                      }

                      return const Text('No data');
                    },
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    sessionController.signOut();
                    context.pushReplacement(SignInView.route);
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
