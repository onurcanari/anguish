import 'package:depression/app/cubit/app_cubit.dart';
import 'package:depression/app/view/onboarding_page.dart';
import 'package:depression/app/view/splash_page.dart';
import 'package:depression/l10n/l10n.dart';
import 'package:depression/posts_overview/view/posts_overview_page.dart';
import 'package:depression/sign_up/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final _tabIndex = ValueNotifier<int>(0);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = <Widget>[
    PostsOverviewPage(),
    Text(
      'Search',
      style: optionStyle,
    ),
    SignUpPage()
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (AppState.initial == state || AppState.loadingConfigs == state) {
          return const SplashPage();
        } else if (AppState.firstTimeOpening == state) {
          return OnboardingPage();
        }

        return ValueListenableBuilder(
          valueListenable: _tabIndex,
          builder: (builder, i, widget) => Scaffold(
            body: SafeArea(
              child: _widgetOptions.elementAt(_tabIndex.value),
            ),
            bottomNavigationBar: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 300),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              selectedIndex: _tabIndex.value,
              onTabChange: (index) => _tabIndex.value = index,
              tabs: [
                GButton(
                  icon: Icons.home_filled,
                  text: l10n.feed,
                ),
                GButton(
                  icon: Icons.brush,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: l10n.profile,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
