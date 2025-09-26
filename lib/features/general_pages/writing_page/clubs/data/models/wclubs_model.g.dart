// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wclubs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WClubsModel _$WClubsModelFromJson(Map<String, dynamic> json) => WClubsModel(
  index: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  parts: (json['parts'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, PartModel.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$WClubsModelToJson(WClubsModel instance) =>
    <String, dynamic>{
      'id': instance.index,
      'name': instance.name,
      'description': instance.description,
      'parts': instance.parts.map((k, e) => MapEntry(k, e.toJson())),
    };
