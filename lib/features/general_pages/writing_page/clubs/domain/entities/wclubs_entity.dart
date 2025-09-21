import 'package:equatable/equatable.dart';

class WClubsEntity extends Equatable {
  final int index;
  final String name;
  final String description;

  const WClubsEntity({
    required this.index,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [index, name, description];
}