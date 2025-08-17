import 'package:equatable/equatable.dart';

abstract class BaseBlocState<T> extends Equatable {
  T copyWith();
}