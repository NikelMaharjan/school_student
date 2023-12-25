

import 'package:eschool/features/updated_model/class_name.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'subject.freezed.dart';
part 'subject.g.dart';


@freezed
class UpdatedSubject with _$UpdatedSubject {

  @JsonSerializable(explicitToJson: true)
  const factory UpdatedSubject ({
    required int id,
    required String subject_name,
    required ClassName class_name,



  }) = _UpdatedSubject;

  factory UpdatedSubject.fromJson(Map<String, dynamic> json) => _$UpdatedSubjectFromJson(json);





}