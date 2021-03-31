// https://github.com/rrousselGit/freezed/blob/59f5473225c9d127abb730a69fab17fecdc89afb/packages/freezed/lib/src/templates/concrete_template.dart#L338

import 'package:code_builder/code_builder.dart';
import 'package:records_generator/src/models.dart';

Method inflate(RecordType type) {
  final method = MethodBuilder()
    ..name = 'operator =='
    ..returns = refer('bool')
    ..requiredParameters.add(_parameter())
    ..annotations.add(refer('override'))
    ..body = _bodyCode(type);
  return method.build();
}

Parameter _parameter() => Parameter(
      (param) => param
        ..name = 'other'
        ..type = refer('dynamic'),
    );

String _parameterizedType(RecordType type) {
  final params = type.typeParameters.map((it) => it.name);
  return params.isEmpty
      ? '${type.name}'
      : '${type.name}<${params.join(', ')}>';
}

Code _bodyCode(RecordType type) {
  final selfType = _parameterizedType(type);
  final details = [
    'other is $selfType',
    ...type.fields.map((it) {
      final name = it.name;
      return '''
    (identical(other.$name, $name) ||
                const DeepCollectionEquality().equals(other.$name, $name))
    ''';
    }),
    'super == other',
  ].join(' && ');
  return Code('return identical(this, other) || ($details);');
}
