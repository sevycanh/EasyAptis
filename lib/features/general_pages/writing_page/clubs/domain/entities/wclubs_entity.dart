import 'package:easyaptis/features/general_pages/writing_page/club_details/domain/entities/topic_entity.dart';
import 'package:equatable/equatable.dart';

class WClubsEntity extends Equatable {
  final int index;
  final String name;
  // final String description;
  final Map<String, PartEntity> parts;

  const WClubsEntity({
    required this.index,
    required this.name,
    // required this.description,
    required this.parts,
  });

  @override
  List<Object?> get props => [index, name, parts];
}