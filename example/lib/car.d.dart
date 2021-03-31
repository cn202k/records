// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RecordGenerator
// **************************************************************************

import 'package:records/records.dart';
export 'package:example/car.dart' hide Car, Google;

class Car {
  Car(this.name);

  final String name;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Car &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            super == other);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      super.hashCode;
  @override
  String toString() => 'Car(name: $name)';
  Car copyWith({String? name}) => Car(name ?? this.name);
}

class Google {
  Google(this.x);

  final dynamic x;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Google &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            super == other);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(x) ^
      super.hashCode;
  @override
  String toString() => 'Google(x: $x)';
  Google copyWith({dynamic? x}) => Google(x ?? this.x);
}
