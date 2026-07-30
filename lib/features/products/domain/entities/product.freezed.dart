// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

 String get id;@JsonKey(name: 'store_id') String get storeId;@JsonKey(name: 'categoria_id') String? get categoriaId; String get nombre;@JsonKey(name: 'precio_venta') double get precioVenta;@JsonKey(name: 'costo_compra') double? get costoCompra;@JsonKey(name: 'stock_actual') int get stockActual;@JsonKey(name: 'stock_minimo') int? get stockMinimo; Map<String, dynamic>? get atributos;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.categoriaId, categoriaId) || other.categoriaId == categoriaId)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.precioVenta, precioVenta) || other.precioVenta == precioVenta)&&(identical(other.costoCompra, costoCompra) || other.costoCompra == costoCompra)&&(identical(other.stockActual, stockActual) || other.stockActual == stockActual)&&(identical(other.stockMinimo, stockMinimo) || other.stockMinimo == stockMinimo)&&const DeepCollectionEquality().equals(other.atributos, atributos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,storeId,categoriaId,nombre,precioVenta,costoCompra,stockActual,stockMinimo,const DeepCollectionEquality().hash(atributos));

@override
String toString() {
  return 'Product(id: $id, storeId: $storeId, categoriaId: $categoriaId, nombre: $nombre, precioVenta: $precioVenta, costoCompra: $costoCompra, stockActual: $stockActual, stockMinimo: $stockMinimo, atributos: $atributos)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'store_id') String storeId,@JsonKey(name: 'categoria_id') String? categoriaId, String nombre,@JsonKey(name: 'precio_venta') double precioVenta,@JsonKey(name: 'costo_compra') double? costoCompra,@JsonKey(name: 'stock_actual') int stockActual,@JsonKey(name: 'stock_minimo') int? stockMinimo, Map<String, dynamic>? atributos
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? storeId = null,Object? categoriaId = freezed,Object? nombre = null,Object? precioVenta = null,Object? costoCompra = freezed,Object? stockActual = null,Object? stockMinimo = freezed,Object? atributos = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,categoriaId: freezed == categoriaId ? _self.categoriaId : categoriaId // ignore: cast_nullable_to_non_nullable
as String?,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,precioVenta: null == precioVenta ? _self.precioVenta : precioVenta // ignore: cast_nullable_to_non_nullable
as double,costoCompra: freezed == costoCompra ? _self.costoCompra : costoCompra // ignore: cast_nullable_to_non_nullable
as double?,stockActual: null == stockActual ? _self.stockActual : stockActual // ignore: cast_nullable_to_non_nullable
as int,stockMinimo: freezed == stockMinimo ? _self.stockMinimo : stockMinimo // ignore: cast_nullable_to_non_nullable
as int?,atributos: freezed == atributos ? _self.atributos : atributos // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'store_id')  String storeId, @JsonKey(name: 'categoria_id')  String? categoriaId,  String nombre, @JsonKey(name: 'precio_venta')  double precioVenta, @JsonKey(name: 'costo_compra')  double? costoCompra, @JsonKey(name: 'stock_actual')  int stockActual, @JsonKey(name: 'stock_minimo')  int? stockMinimo,  Map<String, dynamic>? atributos)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.storeId,_that.categoriaId,_that.nombre,_that.precioVenta,_that.costoCompra,_that.stockActual,_that.stockMinimo,_that.atributos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'store_id')  String storeId, @JsonKey(name: 'categoria_id')  String? categoriaId,  String nombre, @JsonKey(name: 'precio_venta')  double precioVenta, @JsonKey(name: 'costo_compra')  double? costoCompra, @JsonKey(name: 'stock_actual')  int stockActual, @JsonKey(name: 'stock_minimo')  int? stockMinimo,  Map<String, dynamic>? atributos)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.storeId,_that.categoriaId,_that.nombre,_that.precioVenta,_that.costoCompra,_that.stockActual,_that.stockMinimo,_that.atributos);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'store_id')  String storeId, @JsonKey(name: 'categoria_id')  String? categoriaId,  String nombre, @JsonKey(name: 'precio_venta')  double precioVenta, @JsonKey(name: 'costo_compra')  double? costoCompra, @JsonKey(name: 'stock_actual')  int stockActual, @JsonKey(name: 'stock_minimo')  int? stockMinimo,  Map<String, dynamic>? atributos)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.storeId,_that.categoriaId,_that.nombre,_that.precioVenta,_that.costoCompra,_that.stockActual,_that.stockMinimo,_that.atributos);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product extends Product {
  const _Product({required this.id, @JsonKey(name: 'store_id') required this.storeId, @JsonKey(name: 'categoria_id') this.categoriaId, required this.nombre, @JsonKey(name: 'precio_venta') required this.precioVenta, @JsonKey(name: 'costo_compra') this.costoCompra, @JsonKey(name: 'stock_actual') required this.stockActual, @JsonKey(name: 'stock_minimo') this.stockMinimo, final  Map<String, dynamic>? atributos}): _atributos = atributos,super._();
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override final  String id;
@override@JsonKey(name: 'store_id') final  String storeId;
@override@JsonKey(name: 'categoria_id') final  String? categoriaId;
@override final  String nombre;
@override@JsonKey(name: 'precio_venta') final  double precioVenta;
@override@JsonKey(name: 'costo_compra') final  double? costoCompra;
@override@JsonKey(name: 'stock_actual') final  int stockActual;
@override@JsonKey(name: 'stock_minimo') final  int? stockMinimo;
 final  Map<String, dynamic>? _atributos;
@override Map<String, dynamic>? get atributos {
  final value = _atributos;
  if (value == null) return null;
  if (_atributos is EqualUnmodifiableMapView) return _atributos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.categoriaId, categoriaId) || other.categoriaId == categoriaId)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.precioVenta, precioVenta) || other.precioVenta == precioVenta)&&(identical(other.costoCompra, costoCompra) || other.costoCompra == costoCompra)&&(identical(other.stockActual, stockActual) || other.stockActual == stockActual)&&(identical(other.stockMinimo, stockMinimo) || other.stockMinimo == stockMinimo)&&const DeepCollectionEquality().equals(other._atributos, _atributos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,storeId,categoriaId,nombre,precioVenta,costoCompra,stockActual,stockMinimo,const DeepCollectionEquality().hash(_atributos));

@override
String toString() {
  return 'Product(id: $id, storeId: $storeId, categoriaId: $categoriaId, nombre: $nombre, precioVenta: $precioVenta, costoCompra: $costoCompra, stockActual: $stockActual, stockMinimo: $stockMinimo, atributos: $atributos)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'store_id') String storeId,@JsonKey(name: 'categoria_id') String? categoriaId, String nombre,@JsonKey(name: 'precio_venta') double precioVenta,@JsonKey(name: 'costo_compra') double? costoCompra,@JsonKey(name: 'stock_actual') int stockActual,@JsonKey(name: 'stock_minimo') int? stockMinimo, Map<String, dynamic>? atributos
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? storeId = null,Object? categoriaId = freezed,Object? nombre = null,Object? precioVenta = null,Object? costoCompra = freezed,Object? stockActual = null,Object? stockMinimo = freezed,Object? atributos = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,categoriaId: freezed == categoriaId ? _self.categoriaId : categoriaId // ignore: cast_nullable_to_non_nullable
as String?,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,precioVenta: null == precioVenta ? _self.precioVenta : precioVenta // ignore: cast_nullable_to_non_nullable
as double,costoCompra: freezed == costoCompra ? _self.costoCompra : costoCompra // ignore: cast_nullable_to_non_nullable
as double?,stockActual: null == stockActual ? _self.stockActual : stockActual // ignore: cast_nullable_to_non_nullable
as int,stockMinimo: freezed == stockMinimo ? _self.stockMinimo : stockMinimo // ignore: cast_nullable_to_non_nullable
as int?,atributos: freezed == atributos ? _self._atributos : atributos // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
