// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatedClassImpl _$$UpdatedClassImplFromJson(Map<String, dynamic> json) =>
    _$UpdatedClassImpl(
      id: json['id'] as int,
      subject: UpdatedSubject.fromJson(json['subject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UpdatedClassImplToJson(_$UpdatedClassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject.toJson(),
    };
