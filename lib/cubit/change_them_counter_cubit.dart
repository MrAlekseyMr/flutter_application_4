import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_them_counter_state.dart';

class ChangeThemCounter extends Cubit<ChangeThemCounterState> {
  ChangeThemCounter() : super(ChangeThemCounterInitial());

  void countheme(ThemeMode themeMode, bool what) {
    emit(ThemeCounted(nowTheme: themeMode, what: what));
  }

  void changeTheme(ThemeMode themeMode) {
    emit(ThemeChanged(nowTheme: themeMode));
  }
}
