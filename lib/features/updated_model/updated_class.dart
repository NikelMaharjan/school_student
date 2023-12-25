

import 'package:eschool/features/model/school.dart';
import 'package:eschool/features/updated_model/class_name.dart';
import 'package:eschool/features/updated_model/subject.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'updated_class.freezed.dart';
part 'updated_class.g.dart';


@freezed
class UpdatedClass with _$UpdatedClass {

  @JsonSerializable(explicitToJson: true)
  const factory UpdatedClass ({
    required int id,
    required UpdatedSubject subject



  }) = _UpdatedClass;

  factory UpdatedClass.fromJson(Map<String, dynamic> json) => _$UpdatedClassFromJson(json);





}