import 'package:code_builder/code_builder.dart';
import 'package:records_generator/src/models.dart';

Method inflate(RecordType type) {
  final method = MethodBuilder()
    ..name = 'hashCode'
    ..returns = refer('int')
    ..lambda = true
    ..type = MethodType.getter
    ..annotations.add(refer('override'))
    ..body = _bodyCode(type);
  return method.build();
}

Code _bodyCode(RecordType type) => Code([
      'runtimeType.hashCode',
      ...type.fields.map(
        (it) => 'const DeepCollectionEquality().hash(${it.name})',
      ),
      'super.hashCode',
    ].join('^'));
