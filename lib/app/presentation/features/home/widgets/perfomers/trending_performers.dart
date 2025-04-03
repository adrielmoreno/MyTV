import 'package:flutter/material.dart';

import '../../../../../core/di/app_modules.dart';
import '../../../../../domain/common/result.dart';
import '../../../../../domain/enums/signin_failure.dart';
import '../../../../../domain/models/performer/performer_responses.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import '../../../../common/widgets/request_failed.dart';
import 'performer_tile.dart';

typedef EitherListPerformers = Result<SignInFailure, PerformerResponses>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({
    super.key,
  });

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  final _repository = inject<TrendingRepository>();
  late Future<EitherListPerformers> _futre;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
    _updateFuture();
  }

  void _updateFuture() {
    _futre = _repository.getPerformers();
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<EitherListPerformers>(
        key: ValueKey(_futre),
        future: _futre,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return RequestFailed(
              text: 'Error: ${snapshot.error}',
              onRetry: _updateFuture,
            );
          }

          return snapshot.data!.when(
            (failure) => RequestFailed(
              text: 'Error: ${failure.message}',
              onRetry: _updateFuture,
            ),
            (success) {
              final performers = success.results ?? [];

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: performers.length,
                    itemBuilder: (context, index) {
                      final perfomer = performers[index];
                      return PerformerTile(
                        perfomer: perfomer,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 30,
                    child: AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        final currentCard =
                            _pageController.page?.truncate() ?? 0;
                        return Row(
                          children: List.generate(
                            performers.length,
                            (index) => Icon(
                              Icons.circle,
                              color: currentCard == index
                                  ? Colors.redAccent
                                  : Colors.white30,
                              size: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
