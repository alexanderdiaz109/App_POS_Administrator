// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaleResult {

 String get id; String get folio; double get total; double? get montoRecibido; double? get cambio;
/// Create a copy of SaleResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleResultCopyWith<SaleResult> get copyWith => _$SaleResultCopyWithImpl<SaleResult>(this as SaleResult, _$identity);

  /// Serializes this SaleResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleResult&&(identical(other.id, id) || other.id == id)&&(identical(other.folio, folio) || other.folio == folio)&&(identical(other.total, total) || other.total == total)&&(identical(other.montoRecibido, montoRecibido) || other.montoRecibido == montoRecibido)&&(identical(other.cambio, cambio) || other.cambio == cambio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,folio,total,montoRecibido,cambio);

@override
String toString() {
  return 'SaleResult(id: $id, folio: $folio, total: $total, montoRecibido: $montoRecibido, cambio: $cambio)';
}


}

/// @nodoc
abstract mixin class $SaleResultCopyWith<$Res>  {
  factory $SaleResultCopyWith(SaleResult value, $Res Function(SaleResult) _then) = _$SaleResultCopyWithImpl;
@useResult
$Res call({
 String id, String folio, double total, double? montoRecibido, double? cambio
});




}
/// @nodoc
class _$SaleResultCopyWithImpl<$Res>
    implements $SaleResultCopyWith<$Res> {
  _$SaleResultCopyWithImpl(this._self, this._then);

  final SaleResult _self;
  final $Res Function(SaleResult) _then;

/// Create a copy of SaleResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? folio = null,Object? total = null,Object? montoRecibido = freezed,Object? cambio = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,folio: null == folio ? _self.folio : folio // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,montoRecibido: freezed == montoRecibido ? _self.montoRecibido : montoRecibido // ignore: cast_nullable_to_non_nullable
as double?,cambio: freezed == cambio ? _self.cambio : cambio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleResult].
extension SaleResultPatterns on SaleResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleResult value)  $default,){
final _that = this;
switch (_that) {
case _SaleResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleResult value)?  $default,){
final _that = this;
switch (_that) {
case _SaleResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String folio,  double total,  double? montoRecibido,  double? cambio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleResult() when $default != null:
return $default(_that.id,_that.folio,_that.total,_that.montoRecibido,_that.cambio);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String folio,  double total,  double? montoRecibido,  double? cambio)  $default,) {final _that = this;
switch (_that) {
case _SaleResult():
return $default(_that.id,_that.folio,_that.total,_that.montoRecibido,_that.cambio);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String folio,  double total,  double? montoRecibido,  double? cambio)?  $default,) {final _that = this;
switch (_that) {
case _SaleResult() when $default != null:
return $default(_that.id,_that.folio,_that.total,_that.montoRecibido,_that.cambio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleResult implements SaleResult {
  const _SaleResult({required this.id, required this.folio, required this.total, this.montoRecibido, this.cambio});
  factory _SaleResult.fromJson(Map<String, dynamic> json) => _$SaleResultFromJson(json);

@override final  String id;
@override final  String folio;
@override final  double total;
@override final  double? montoRecibido;
@override final  double? cambio;

/// Create a copy of SaleResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleResultCopyWith<_SaleResult> get copyWith => __$SaleResultCopyWithImpl<_SaleResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleResult&&(identical(other.id, id) || other.id == id)&&(identical(other.folio, folio) || other.folio == folio)&&(identical(other.total, total) || other.total == total)&&(identical(other.montoRecibido, montoRecibido) || other.montoRecibido == montoRecibido)&&(identical(other.cambio, cambio) || other.cambio == cambio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,folio,total,montoRecibido,cambio);

@override
String toString() {
  return 'SaleResult(id: $id, folio: $folio, total: $total, montoRecibido: $montoRecibido, cambio: $cambio)';
}


}

/// @nodoc
abstract mixin class _$SaleResultCopyWith<$Res> implements $SaleResultCopyWith<$Res> {
  factory _$SaleResultCopyWith(_SaleResult value, $Res Function(_SaleResult) _then) = __$SaleResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String folio, double total, double? montoRecibido, double? cambio
});




}
/// @nodoc
class __$SaleResultCopyWithImpl<$Res>
    implements _$SaleResultCopyWith<$Res> {
  __$SaleResultCopyWithImpl(this._self, this._then);

  final _SaleResult _self;
  final $Res Function(_SaleResult) _then;

/// Create a copy of SaleResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? folio = null,Object? total = null,Object? montoRecibido = freezed,Object? cambio = freezed,}) {
  return _then(_SaleResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,folio: null == folio ? _self.folio : folio // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,montoRecibido: freezed == montoRecibido ? _self.montoRecibido : montoRecibido // ignore: cast_nullable_to_non_nullable
as double?,cambio: freezed == cambio ? _self.cambio : cambio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
