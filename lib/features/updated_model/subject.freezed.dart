// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdatedSubject _$UpdatedSubjectFromJson(Map<String, dynamic> json) {
  return _UpdatedSubject.fromJson(json);
}

/// @nodoc
mixin _$UpdatedSubject {
  int get id => throw _privateConstructorUsedError;
  String get subject_name => throw _privateConstructorUsedError;
  ClassName get class_name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatedSubjectCopyWith<UpdatedSubject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatedSubjectCopyWith<$Res> {
  factory $UpdatedSubjectCopyWith(
          UpdatedSubject value, $Res Function(UpdatedSubject) then) =
      _$UpdatedSubjectCopyWithImpl<$Res, UpdatedSubject>;
  @useResult
  $Res call({int id, String subject_name, ClassName class_name});

  $ClassNameCopyWith<$Res> get class_name;
}

/// @nodoc
class _$UpdatedSubjectCopyWithImpl<$Res, $Val extends UpdatedSubject>
    implements $UpdatedSubjectCopyWith<$Res> {
  _$UpdatedSubjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject_name = null,
    Object? class_name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subject_name: null == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String,
      class_name: null == class_name
          ? _value.class_name
          : class_name // ignore: cast_nullable_to_non_nullable
              as ClassName,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClassNameCopyWith<$Res> get class_name {
    return $ClassNameCopyWith<$Res>(_value.class_name, (value) {
      return _then(_value.copyWith(class_name: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdatedSubjectImplCopyWith<$Res>
    implements $UpdatedSubjectCopyWith<$Res> {
  factory _$$UpdatedSubjectImplCopyWith(_$UpdatedSubjectImpl value,
          $Res Function(_$UpdatedSubjectImpl) then) =
      __$$UpdatedSubjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String subject_name, ClassName class_name});

  @override
  $ClassNameCopyWith<$Res> get class_name;
}

/// @nodoc
class __$$UpdatedSubjectImplCopyWithImpl<$Res>
    extends _$UpdatedSubjectCopyWithImpl<$Res, _$UpdatedSubjectImpl>
    implements _$$UpdatedSubjectImplCopyWith<$Res> {
  __$$UpdatedSubjectImplCopyWithImpl(
      _$UpdatedSubjectImpl _value, $Res Function(_$UpdatedSubjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject_name = null,
    Object? class_name = null,
  }) {
    return _then(_$UpdatedSubjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subject_name: null == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String,
      class_name: null == class_name
          ? _value.class_name
          : class_name // ignore: cast_nullable_to_non_nullable
              as ClassName,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$UpdatedSubjectImpl implements _UpdatedSubject {
  const _$UpdatedSubjectImpl(
      {required this.id, required this.subject_name, required this.class_name});

  factory _$UpdatedSubjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatedSubjectImplFromJson(json);

  @override
  final int id;
  @override
  final String subject_name;
  @override
  final ClassName class_name;

  @override
  String toString() {
    return 'UpdatedSubject(id: $id, subject_name: $subject_name, class_name: $class_name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedSubjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subject_name, subject_name) ||
                other.subject_name == subject_name) &&
            (identical(other.class_name, class_name) ||
                other.class_name == class_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, subject_name, class_name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedSubjectImplCopyWith<_$UpdatedSubjectImpl> get copyWith =>
      __$$UpdatedSubjectImplCopyWithImpl<_$UpdatedSubjectImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatedSubjectImplToJson(
      this,
    );
  }
}

abstract class _UpdatedSubject implements UpdatedSubject {
  const factory _UpdatedSubject(
      {required final int id,
      required final String subject_name,
      required final ClassName class_name}) = _$UpdatedSubjectImpl;

  factory _UpdatedSubject.fromJson(Map<String, dynamic> json) =
      _$UpdatedSubjectImpl.fromJson;

  @override
  int get id;
  @override
  String get subject_name;
  @override
  ClassName get class_name;
  @override
  @JsonKey(ignore: true)
  _$$UpdatedSubjectImplCopyWith<_$UpdatedSubjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
