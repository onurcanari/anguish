import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.postRepository}) : super(AppState.initial);

  final PostRepository postRepository;
  late SharedPreferences _sharedPreferences;

  Future<void> initializeConfigs() async {
    emit(AppState.loadingConfigs);
    await postRepository.initialize();
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_isOnboardingOpened()) {
      _setOnboardingAsOpened();
      emit(AppState.firstTimeOpening);
    } else {
      emit(AppState.finished);
    }
  }

  bool _isOnboardingOpened() {
    return _sharedPreferences.getBool('openOnboardingPage') ?? true;
  }

  void _setOnboardingAsOpened() {
    unawaited(_sharedPreferences.setBool('openOnboardingPage', false));
  }
}
