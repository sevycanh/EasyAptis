import 'package:easyaptis/core/utils/base/base_bloc.dart';
import 'package:easyaptis/core/utils/base/base_bloc_state.dart';
import 'package:easyaptis/core/utils/log/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBlocWidget<
  E,
  T extends BaseBlocState,
  B extends BaseBloc<E, T>
>
    extends StatelessWidget {
  final B _bloc;

  B get bloc => _bloc;

  const BaseBlocWidget(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return _DisposableWidgetWrapper(
      onInit: onInit,
      onDispose: onDispose,
      child: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<B, T>(
          bloc: _bloc,
          listener: onStateChanged,
          builder:
              (context, state) =>
                  buildWidget(context, context.read<B>(), state),
          buildWhen: (oldState, newState) => oldState != newState,
          listenWhen:
              (oldState, newState) =>
                  oldState != newState &&
                  shouldCallbackStateChanged(oldState, newState),
        ),
      ),
    );
  }

  void onInit() {
    Logger.d("On Widget $this init.");
  }

  void onDispose() {
    Logger.d("On Widget $this dispose.");
  }

  bool shouldCallbackStateChanged(T oldState, T newState) {
    return true;
  }

  void onStateChanged(BuildContext context, T state) {
    // do nothing
  }

  Widget buildWidget(BuildContext context, B bloc, T state);
}

class _DisposableWidgetWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onInit;
  final VoidCallback onDispose;

  const _DisposableWidgetWrapper({
    required this.child,
    required this.onInit,
    required this.onDispose,
  });

  @override
  State<StatefulWidget> createState() => _DisposableWidgetWrapperState();
}

class _DisposableWidgetWrapperState extends State<_DisposableWidgetWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }
}