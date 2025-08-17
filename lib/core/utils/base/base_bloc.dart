import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, T extends BaseBlocState> extends Bloc<E, T> {
  BaseBloc(super.blocState);

  final Set<ChangeNotifier> changeNotifiers = {};

  void send(E event) => add(event);

  void attachNotifier(ChangeNotifier notifier) {
    changeNotifiers.add(notifier);
  }

  @override
  Future<void> close() async {
    for (var notifier in changeNotifiers) {
      notifier.dispose();
    }
    changeNotifiers.clear();
    return super.close();
  }
}
