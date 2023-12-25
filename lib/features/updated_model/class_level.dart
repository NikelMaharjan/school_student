



import 'package:freezed_annotation/freezed_annotation.dart';
part 'class_level.freezed.dart';
part 'class_level.g.dart';


@freezed
class ClassLevel with _$ClassLevel {

  @JsonSerializable(explicitToJson: true)
  const factory ClassLevel ({
    required int id,
    required String class_name,
    required bool is_bachelors_class,


  }) = _ClassLevel;

  factory ClassLevel.fromJson(Map<String, dynamic> json) => _$ClassLevelFromJson(json);





}