import 'package:example/car.dart';
import 'package:example/example.dart';
import 'package:records/records.dart';

typedef Korone<N extends num, M extends List<num>>();

@record
typedef User<T extends num>({
  String name,
  T value,
  Example example,
  Korone<int, List<int>> korone,
  Korone korene_0,
  bool func(int x, {required int y})?,
});

@record
typedef Foo(int x, User<int> user);

@record
typedef Bar<C extends Calculator>(C calculator, {Car car});
