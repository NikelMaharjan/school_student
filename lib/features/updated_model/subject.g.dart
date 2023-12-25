// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatedSubjectImpl _$$UpdatedSubjectImplFromJson(Map<String, dynamic> json) =>
    _$UpdatedSubjectImpl(
      id: json['id'] as int,
      subject_name: json['subject_name'] as String,
      class_name:
          ClassName.fromJson(json['class_name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UpdatedSubjectImplToJson(
        _$UpdatedSubjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject_name': instance.subject_name,
      'class_name': instance.class_name.toJson(),
    };
