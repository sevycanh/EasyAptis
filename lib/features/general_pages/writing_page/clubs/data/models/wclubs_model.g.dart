// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wclubs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WClubsModel _$WClubsModelFromJson(Map<String, dynamic> json) => WClubsModel(
  index: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$WClubsModelToJson(WClubsModel instance) =>
    <String, dynamic>{
      'id': instance.index,
      'name': instance.name,
      'description': instance.description,
    };
