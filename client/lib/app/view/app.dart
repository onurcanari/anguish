import 'package:authentication_repository/authentication_repository.dart';
import 'package:depression/app/cubit/app_cubit.dart';
import 'package:depression/app/router.dart';
import 'package:depression/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:post_repository/post_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AppRoute.router;
    final postRepository = PostRepository();
    final authenticationRepository = AuthenticationRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostRepository>(
          create: (context) => postRepository,
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            AppCubit(postRepository: postRepository)..initializeConfigs(),
        child: MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          title: 'Anguish',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF13B9FF),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
