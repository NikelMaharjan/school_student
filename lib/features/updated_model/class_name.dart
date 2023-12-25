



import 'package:eschool/features/updated_model/batch.dart';
import 'package:eschool/features/updated_model/class_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'class_name.freezed.dart';
part 'class_name.g.dart';


@freezed
class ClassName with _$ClassName {

  @JsonSerializable(explicitToJson: true)
  const factory ClassName ({
    required int id,
    required Batch batch,
    required ClassLevel class_level,


  }) = _ClassName;

  factory ClassName.fromJson(Map<String, dynamic> json) => _$ClassNameFromJson(json);





}