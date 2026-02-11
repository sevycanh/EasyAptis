import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  // final String? latestTitle;
  final String? latestBody;

  const NotificationState({this.latestBody});

  NotificationState copyWith({String? latestBody, bool clearBody = false}) {
    return NotificationState(
      latestBody: clearBody ? null : (latestBody ?? this.latestBody),
    );
  }

  @override
  List<Object?> get props => [latestBody];
}
