// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassNameImpl _$$ClassNameImplFromJson(Map<String, dynamic> json) =>
    _$ClassNameImpl(
      id: json['id'] as int,
      batch: Batch.fromJson(json['batch'] as Map<String, dynamic>),
      class_level:
          ClassLevel.fromJson(json['class_level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClassNameImplToJson(_$ClassNameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'batch': instance.batch.toJson(),
      'class_level': instance.class_level.toJson(),
    };
