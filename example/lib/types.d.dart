// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RecordGenerator
// **************************************************************************

import 'package:records/records.dart';
import 'package:example/example.dart';
import 'package:example/types.dart';
import 'package:example/car.d.dart';

class User<T extends num> {
  User(
      {required this.name,
      required this.value,
      required this.example,
      required this.korone,
      required this.korene_0,
      this.func});

  final String name;

  final T value;

  final Example example;

  final Korone<int, List<int>> korone;

  final Korone korene_0;

  final bool Function(int, {required int y})? func;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is User<T> &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.example, example) ||
                const DeepCollectionEquality()
                    .equals(other.example, example)) &&
            (identical(other.korone, korone) ||
                const DeepCollectionEquality().equals(other.korone, korone)) &&
            (identical(other.korene_0, korene_0) ||
                const DeepCollectionEquality()
                    .equals(other.korene_0, korene_0)) &&
            (identical(other.func, func) ||
                const DeepCollectionEquality().equals(other.func, func)) &&
            super == other);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(example) ^
      const DeepCollectionEquality().hash(korone) ^
      const DeepCollectionEquality().hash(korene_0) ^
      const DeepCollectionEquality().hash(func) ^
      super.hashCode;
  @override
  String toString() =>
      'User(name: $name, value: $value, example: $example, korone: $korone, korene_0: $korene_0, func: $func)';
  User<T> copyWith(
          {String? name,
          T? value,
          Example? example,
          Korone<int, List<int>>? korone,
          Korone? korene_0,
          bool Function(int, {required int y})? func}) =>
      User(
          name: name ?? this.name,
          value: value ?? this.value,
          example: example ?? this.example,
          korone: korone ?? this.korone,
          korene_0: korene_0 ?? this.korene_0,
          func: func ?? this.func);
}

class Foo {
  Foo(this.x, this.user);

  final int x;

  final User<int> user;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Foo &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            super == other);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(user) ^
      super.hashCode;
  @override
  String toString() => 'Foo(x: $x, user: $user)';
  Foo copyWith({int? x, User<int>? user}) =>
      Foo(x ?? this.x, user ?? this.user);
}

class Bar<C extends Calculator> {
  Bar(this.calculator, {required this.car});

  final C calculator;

  final Car car;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Bar<C> &&
            (identical(other.calculator, calculator) ||
                const DeepCollectionEquality()
                    .equals(other.calculator, calculator)) &&
            (identical(other.car, car) ||
                const DeepCollectionEquality().equals(other.car, car)) &&
            super == other);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(calculator) ^
      const DeepCollectionEquality().hash(car) ^
      super.hashCode;
  @override
  String toString() => 'Bar(calculator: $calculator, car: $car)';
  Bar<C> copyWith({C? calculator, Car? car}) =>
      Bar(calculator ?? this.calculator, car: car ?? this.car);
}
