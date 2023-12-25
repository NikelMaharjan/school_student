// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'updated_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdatedClass _$UpdatedClassFromJson(Map<String, dynamic> json) {
  return _UpdatedClass.fromJson(json);
}

/// @nodoc
mixin _$UpdatedClass {
  int get id => throw _privateConstructorUsedError;
  UpdatedSubject get subject => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatedClassCopyWith<UpdatedClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatedClassCopyWith<$Res> {
  factory $UpdatedClassCopyWith(
          UpdatedClass value, $Res Function(UpdatedClass) then) =
      _$UpdatedClassCopyWithImpl<$Res, UpdatedClass>;
  @useResult
  $Res call({int id, UpdatedSubject subject});

  $UpdatedSubjectCopyWith<$Res> get subject;
}

/// @nodoc
class _$UpdatedClassCopyWithImpl<$Res, $Val extends UpdatedClass>
    implements $UpdatedClassCopyWith<$Res> {
  _$UpdatedClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as UpdatedSubject,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdatedSubjectCopyWith<$Res> get subject {
    return $UpdatedSubjectCopyWith<$Res>(_value.subject, (value) {
      return _then(_value.copyWith(subject: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdatedClassImplCopyWith<$Res>
    implements $UpdatedClassCopyWith<$Res> {
  factory _$$UpdatedClassImplCopyWith(
          _$UpdatedClassImpl value, $Res Function(_$UpdatedClassImpl) then) =
      __$$UpdatedClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, UpdatedSubject subject});

  @override
  $UpdatedSubjectCopyWith<$Res> get subject;
}

/// @nodoc
class __$$UpdatedClassImplCopyWithImpl<$Res>
    extends _$UpdatedClassCopyWithImpl<$Res, _$UpdatedClassImpl>
    implements _$$UpdatedClassImplCopyWith<$Res> {
  __$$UpdatedClassImplCopyWithImpl(
      _$UpdatedClassImpl _value, $Res Function(_$UpdatedClassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
  }) {
    return _then(_$UpdatedClassImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as UpdatedSubject,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$UpdatedClassImpl implements _UpdatedClass {
  const _$UpdatedClassImpl({required this.id, required this.subject});

  factory _$UpdatedClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatedClassImplFromJson(json);

  @override
  final int id;
  @override
  final UpdatedSubject subject;

  @override
  String toString() {
    return 'UpdatedClass(id: $id, subject: $subject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subject, subject) || other.subject == subject));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, subject);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedClassImplCopyWith<_$UpdatedClassImpl> get copyWith =>
      __$$UpdatedClassImplCopyWithImpl<_$UpdatedClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatedClassImplToJson(
      this,
    );
  }
}

abstract class _UpdatedClass implements UpdatedClass {
  const factory _UpdatedClass(
      {required final int id,
      required final UpdatedSubject subject}) = _$UpdatedClassImpl;

  factory _UpdatedClass.fromJson(Map<String, dynamic> json) =
      _$UpdatedClassImpl.fromJson;

  @override
  int get id;
  @override
  UpdatedSubject get subject;
  @override
  @JsonKey(ignore: true)
  _$$UpdatedClassImplCopyWith<_$UpdatedClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
