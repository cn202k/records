import 'package:code_builder/code_builder.dart';
import 'package:records_generator/src/models.dart';
import 'package:records_generator/src/template/equals_method_template.dart'
    as equalsMethod;
import 'package:records_generator/src/template/hashcode_method_template.dart'
    as hashCodeMethod;
import 'package:records_generator/src/template/to_string_method.dart'
    as toStringMethod;
import 'package:records_generator/src/template/copy_with_method_template.dart'
    as copyWithMethod;

Class inflate(RecordType type) {
  final klass = ClassBuilder()
    ..name = type.name
    ..types.addAll(_typeParameters(type))
    ..constructors.add(_constructor(type))
    ..fields.addAll(_fields(type))
    ..methods.addAll(_methods(type));
  return klass.build();
}

Iterable<Reference> _typeParameters(RecordType type) =>
    type.typeParameters.map((it) {
      final name = it.name;
      final bound = it.bound?.name;
      return bound != null ? '$name extends $bound' : name;
    }).map((it) => refer(it));

Constructor _constructor(RecordType type) {
  final ctor = ConstructorBuilder()
    ..requiredParameters.addAll(
      type.fields
          .where((it) => it.isPositional)
          .map(_constructorParameter),
    )
    ..optionalParameters.addAll(
      type.fields
          .where((it) => !it.isPositional)
          .map(_constructorParameter),
    );
  return ctor.build();
}

Parameter _constructorParameter(RecordField field) {
  final parameter = ParameterBuilder()
    ..name = field.name
    ..toThis = true
    ..named = _shouldBeNamedParameter(field)
    ..required = _shouldBeMarkedAsRequired(field);
  return parameter.build();
}

bool _shouldBeNamedParameter(RecordField field) => !field.isPositional;

bool _shouldBeMarkedAsRequired(RecordField field) =>
    _shouldBeNamedParameter(field) && field.isMandatory;

Field _field(RecordField field) {
  final field_ = FieldBuilder()
    ..name = field.name
    ..type = refer(field.type.name)
    ..modifier = FieldModifier.final$;
  return field_.build();
}

Iterable<Field> _fields(RecordType type) => type.fields.map(_field);

Iterable<Method> _methods(RecordType type) => [
      equalsMethod.inflate(type),
      hashCodeMethod.inflate(type),
      toStringMethod.inflate(type),
      copyWithMethod.inflate(type),
    ];
