// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CashSummary {

 double get total;@JsonKey(name: 'numVentas') int get numVentas; double get efectivo; double get tarjeta; double get transferencia;@JsonKey(name: 'gananciaNeta') double get gananciaNeta;
/// Create a copy of CashSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashSummaryCopyWith<CashSummary> get copyWith => _$CashSummaryCopyWithImpl<CashSummary>(this as CashSummary, _$identity);

  /// Serializes this CashSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashSummary&&(identical(other.total, total) || other.total == total)&&(identical(other.numVentas, numVentas) || other.numVentas == numVentas)&&(identical(other.efectivo, efectivo) || other.efectivo == efectivo)&&(identical(other.tarjeta, tarjeta) || other.tarjeta == tarjeta)&&(identical(other.transferencia, transferencia) || other.transferencia == transferencia)&&(identical(other.gananciaNeta, gananciaNeta) || other.gananciaNeta == gananciaNeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,numVentas,efectivo,tarjeta,transferencia,gananciaNeta);

@override
String toString() {
  return 'CashSummary(total: $total, numVentas: $numVentas, efectivo: $efectivo, tarjeta: $tarjeta, transferencia: $transferencia, gananciaNeta: $gananciaNeta)';
}


}

/// @nodoc
abstract mixin class $CashSummaryCopyWith<$Res>  {
  factory $CashSummaryCopyWith(CashSummary value, $Res Function(CashSummary) _then) = _$CashSummaryCopyWithImpl;
@useResult
$Res call({
 double total,@JsonKey(name: 'numVentas') int numVentas, double efectivo, double tarjeta, double transferencia,@JsonKey(name: 'gananciaNeta') double gananciaNeta
});




}
/// @nodoc
class _$CashSummaryCopyWithImpl<$Res>
    implements $CashSummaryCopyWith<$Res> {
  _$CashSummaryCopyWithImpl(this._self, this._then);

  final CashSummary _self;
  final $Res Function(CashSummary) _then;

/// Create a copy of CashSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? numVentas = null,Object? efectivo = null,Object? tarjeta = null,Object? transferencia = null,Object? gananciaNeta = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,numVentas: null == numVentas ? _self.numVentas : numVentas // ignore: cast_nullable_to_non_nullable
as int,efectivo: null == efectivo ? _self.efectivo : efectivo // ignore: cast_nullable_to_non_nullable
as double,tarjeta: null == tarjeta ? _self.tarjeta : tarjeta // ignore: cast_nullable_to_non_nullable
as double,transferencia: null == transferencia ? _self.transferencia : transferencia // ignore: cast_nullable_to_non_nullable
as double,gananciaNeta: null == gananciaNeta ? _self.gananciaNeta : gananciaNeta // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CashSummary].
extension CashSummaryPatterns on CashSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashSummary value)  $default,){
final _that = this;
switch (_that) {
case _CashSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CashSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double total, @JsonKey(name: 'numVentas')  int numVentas,  double efectivo,  double tarjeta,  double transferencia, @JsonKey(name: 'gananciaNeta')  double gananciaNeta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashSummary() when $default != null:
return $default(_that.total,_that.numVentas,_that.efectivo,_that.tarjeta,_that.transferencia,_that.gananciaNeta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double total, @JsonKey(name: 'numVentas')  int numVentas,  double efectivo,  double tarjeta,  double transferencia, @JsonKey(name: 'gananciaNeta')  double gananciaNeta)  $default,) {final _that = this;
switch (_that) {
case _CashSummary():
return $default(_that.total,_that.numVentas,_that.efectivo,_that.tarjeta,_that.transferencia,_that.gananciaNeta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double total, @JsonKey(name: 'numVentas')  int numVentas,  double efectivo,  double tarjeta,  double transferencia, @JsonKey(name: 'gananciaNeta')  double gananciaNeta)?  $default,) {final _that = this;
switch (_that) {
case _CashSummary() when $default != null:
return $default(_that.total,_that.numVentas,_that.efectivo,_that.tarjeta,_that.transferencia,_that.gananciaNeta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashSummary implements CashSummary {
  const _CashSummary({required this.total, @JsonKey(name: 'numVentas') required this.numVentas, required this.efectivo, required this.tarjeta, required this.transferencia, @JsonKey(name: 'gananciaNeta') required this.gananciaNeta});
  factory _CashSummary.fromJson(Map<String, dynamic> json) => _$CashSummaryFromJson(json);

@override final  double total;
@override@JsonKey(name: 'numVentas') final  int numVentas;
@override final  double efectivo;
@override final  double tarjeta;
@override final  double transferencia;
@override@JsonKey(name: 'gananciaNeta') final  double gananciaNeta;

/// Create a copy of CashSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashSummaryCopyWith<_CashSummary> get copyWith => __$CashSummaryCopyWithImpl<_CashSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashSummary&&(identical(other.total, total) || other.total == total)&&(identical(other.numVentas, numVentas) || other.numVentas == numVentas)&&(identical(other.efectivo, efectivo) || other.efectivo == efectivo)&&(identical(other.tarjeta, tarjeta) || other.tarjeta == tarjeta)&&(identical(other.transferencia, transferencia) || other.transferencia == transferencia)&&(identical(other.gananciaNeta, gananciaNeta) || other.gananciaNeta == gananciaNeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,numVentas,efectivo,tarjeta,transferencia,gananciaNeta);

@override
String toString() {
  return 'CashSummary(total: $total, numVentas: $numVentas, efectivo: $efectivo, tarjeta: $tarjeta, transferencia: $transferencia, gananciaNeta: $gananciaNeta)';
}


}

/// @nodoc
abstract mixin class _$CashSummaryCopyWith<$Res> implements $CashSummaryCopyWith<$Res> {
  factory _$CashSummaryCopyWith(_CashSummary value, $Res Function(_CashSummary) _then) = __$CashSummaryCopyWithImpl;
@override @useResult
$Res call({
 double total,@JsonKey(name: 'numVentas') int numVentas, double efectivo, double tarjeta, double transferencia,@JsonKey(name: 'gananciaNeta') double gananciaNeta
});




}
/// @nodoc
class __$CashSummaryCopyWithImpl<$Res>
    implements _$CashSummaryCopyWith<$Res> {
  __$CashSummaryCopyWithImpl(this._self, this._then);

  final _CashSummary _self;
  final $Res Function(_CashSummary) _then;

/// Create a copy of CashSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? numVentas = null,Object? efectivo = null,Object? tarjeta = null,Object? transferencia = null,Object? gananciaNeta = null,}) {
  return _then(_CashSummary(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,numVentas: null == numVentas ? _self.numVentas : numVentas // ignore: cast_nullable_to_non_nullable
as int,efectivo: null == efectivo ? _self.efectivo : efectivo // ignore: cast_nullable_to_non_nullable
as double,tarjeta: null == tarjeta ? _self.tarjeta : tarjeta // ignore: cast_nullable_to_non_nullable
as double,transferencia: null == transferencia ? _self.transferencia : transferencia // ignore: cast_nullable_to_non_nullable
as double,gananciaNeta: null == gananciaNeta ? _self.gananciaNeta : gananciaNeta // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
