part of 'change_them_counter_cubit.dart';

@immutable
abstract class ChangeThemCounterState {}

class ChangeThemCounterInitial extends ChangeThemCounterState {}

class ThemeChanged extends ChangeThemCounterState {
  ThemeMode nowTheme;
  ThemeChanged({
    required this.nowTheme,
  });
}

class ThemeCounted extends ChangeThemCounterState {
  late int add;
  bool what;
  ThemeMode nowTheme;
  ThemeCounted({
    required this.nowTheme,
    required this.what,
  }) {
    if (nowTheme == ThemeMode.dark) if (what) {
      add = 2;
    } else {
      add = -2;
    }
    else if (what) {
      add = 1;
    } else {
      add = -1;
    }
  }
}
