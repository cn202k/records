import 'package:code_builder/code_builder.dart';
import 'package:records_generator/src/models.dart';

Method inflate(RecordType type) {
  final method = MethodBuilder()
    ..name = 'toString'
    ..returns = refer('String')
    ..annotations.add(refer('override'))
    ..lambda = true
    ..body = _bodyCode(type);
  return method.build();
}

Code _bodyCode(RecordType type) {
  final values =
      type.fields.map((it) => '${it.name}: \$${it.name}').join(', ');
  return Code("'${type.name}($values)'");
}
