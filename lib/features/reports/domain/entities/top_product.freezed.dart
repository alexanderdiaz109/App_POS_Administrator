// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopProduct {

@JsonKey(name: 'producto_id') String get productoId; String get nombre; int get unidades;
/// Create a copy of TopProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopProductCopyWith<TopProduct> get copyWith => _$TopProductCopyWithImpl<TopProduct>(this as TopProduct, _$identity);

  /// Serializes this TopProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopProduct&&(identical(other.productoId, productoId) || other.productoId == productoId)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.unidades, unidades) || other.unidades == unidades));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productoId,nombre,unidades);

@override
String toString() {
  return 'TopProduct(productoId: $productoId, nombre: $nombre, unidades: $unidades)';
}


}

/// @nodoc
abstract mixin class $TopProductCopyWith<$Res>  {
  factory $TopProductCopyWith(TopProduct value, $Res Function(TopProduct) _then) = _$TopProductCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'producto_id') String productoId, String nombre, int unidades
});




}
/// @nodoc
class _$TopProductCopyWithImpl<$Res>
    implements $TopProductCopyWith<$Res> {
  _$TopProductCopyWithImpl(this._self, this._then);

  final TopProduct _self;
  final $Res Function(TopProduct) _then;

/// Create a copy of TopProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productoId = null,Object? nombre = null,Object? unidades = null,}) {
  return _then(_self.copyWith(
productoId: null == productoId ? _self.productoId : productoId // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,unidades: null == unidades ? _self.unidades : unidades // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TopProduct].
extension TopProductPatterns on TopProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopProduct value)  $default,){
final _that = this;
switch (_that) {
case _TopProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopProduct value)?  $default,){
final _that = this;
switch (_that) {
case _TopProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'producto_id')  String productoId,  String nombre,  int unidades)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopProduct() when $default != null:
return $default(_that.productoId,_that.nombre,_that.unidades);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'producto_id')  String productoId,  String nombre,  int unidades)  $default,) {final _that = this;
switch (_that) {
case _TopProduct():
return $default(_that.productoId,_that.nombre,_that.unidades);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'producto_id')  String productoId,  String nombre,  int unidades)?  $default,) {final _that = this;
switch (_that) {
case _TopProduct() when $default != null:
return $default(_that.productoId,_that.nombre,_that.unidades);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopProduct implements TopProduct {
  const _TopProduct({@JsonKey(name: 'producto_id') required this.productoId, required this.nombre, required this.unidades});
  factory _TopProduct.fromJson(Map<String, dynamic> json) => _$TopProductFromJson(json);

@override@JsonKey(name: 'producto_id') final  String productoId;
@override final  String nombre;
@override final  int unidades;

/// Create a copy of TopProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopProductCopyWith<_TopProduct> get copyWith => __$TopProductCopyWithImpl<_TopProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopProduct&&(identical(other.productoId, productoId) || other.productoId == productoId)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.unidades, unidades) || other.unidades == unidades));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productoId,nombre,unidades);

@override
String toString() {
  return 'TopProduct(productoId: $productoId, nombre: $nombre, unidades: $unidades)';
}


}

/// @nodoc
abstract mixin class _$TopProductCopyWith<$Res> implements $TopProductCopyWith<$Res> {
  factory _$TopProductCopyWith(_TopProduct value, $Res Function(_TopProduct) _then) = __$TopProductCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'producto_id') String productoId, String nombre, int unidades
});




}
/// @nodoc
class __$TopProductCopyWithImpl<$Res>
    implements _$TopProductCopyWith<$Res> {
  __$TopProductCopyWithImpl(this._self, this._then);

  final _TopProduct _self;
  final $Res Function(_TopProduct) _then;

/// Create a copy of TopProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productoId = null,Object? nombre = null,Object? unidades = null,}) {
  return _then(_TopProduct(
productoId: null == productoId ? _self.productoId : productoId // ignore: cast_nullable_to_non_nullable
as String,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,unidades: null == unidades ? _self.unidades : unidades // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
