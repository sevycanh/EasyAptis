import 'package:easyaptis/features/general_pages/writing_page/clubs/domain/entities/wclubs_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wclubs_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WClubsModel {
  @JsonKey(name: 'id')
  final int index;
  final String name;
  final String description;

  const WClubsModel({
    required this.index,
    required this.name,
    required this.description,
  });

  factory WClubsModel.fromJson(Map<String, dynamic> json) =>
      _$WClubsModelFromJson(json);

  Map<String, dynamic> toJson() => _$WClubsModelToJson(this);

  WClubsEntity toEntity() {
    return WClubsEntity(index: index, name: name, description: description);
  }
}
