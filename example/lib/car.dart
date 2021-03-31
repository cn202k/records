import 'package:example/car.d.dart' as d;
import 'package:records/records_export.dart';

@record
typedef Car(String name);

@record
typedef Google(dynamic x);

d.Car makeCar(String name) => d.Car(name);
