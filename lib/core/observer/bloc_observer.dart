import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    dev.log(
      'onChange',
      name: bloc.runtimeType.toString(),
      error: change,
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    dev.log(
      'onError',
      name: bloc.runtimeType.toString(),
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
