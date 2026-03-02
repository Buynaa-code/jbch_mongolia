import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// State for theme management
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.system});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}

/// Cubit for managing app-wide theme state
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  /// Set the theme mode
  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  /// Toggle between light and dark mode
  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newMode));
  }
}
