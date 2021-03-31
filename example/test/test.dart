import 'package:example/car.d.dart';

void main() {
  final car = makeCar('wagon');
  final Car newCar = car.copyWith(name: 'wagon2');
}
