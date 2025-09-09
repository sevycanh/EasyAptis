import 'package:equatable/equatable.dart';

class ListeningP2Entity extends Equatable {
  final int index;
  final String topic;
  final String audioUrl;
  final String transcript;
  final List<ListeningP2OptionEntity> options;
  final List<ListeningP2SpeakerEntity> speakers;

  const ListeningP2Entity({
    required this.index,
    required this.topic,
    required this.audioUrl,
    required this.transcript,
    required this.options,
    required this.speakers,
  });

  @override
  List<Object?> get props =>
      [index, topic, audioUrl, transcript, options, speakers];
}

class ListeningP2OptionEntity extends Equatable {
  final int index;
  final String text;

  const ListeningP2OptionEntity({
    required this.index,
    required this.text,
  });

  @override
  List<Object?> get props => [index, text];
}

class ListeningP2SpeakerEntity extends Equatable {
  final int speaker;
  final int correctOption;

  const ListeningP2SpeakerEntity({
    required this.speaker,
    required this.correctOption,
  });

  @override
  List<Object?> get props => [speaker, correctOption];
}
