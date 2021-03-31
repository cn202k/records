import 'package:code_builder/code_builder.dart';
import 'package:records_generator/src/models.dart';
import 'package:records_generator/src/template/concrete_class_template.dart'
    as concreteClass;

Library inflate(Scope library) {
  final lib = LibraryBuilder()
    ..directives.addAll(_imports(library))
    ..body.addAll(library.types.map(concreteClass.inflate));
  if (library.exportOriginalUri) {
    lib.directives.add(_export(library));
  }
  return lib.build();
}

Directive _export(Scope library) => Directive.export(
      library.originalUri,
      hide: library.types.map((it) => it.name).toList(),
    );

Iterable<Directive> _imports(Scope library) => [
      'package:records/records.dart',
      ..._dependencies(library),
    ].toSet().map((uri) => Directive.import(uri));

Iterable<String> _dependencies(Scope library) => [
      for (final type in library.types) ...[
        ...type.fields.map((it) => it.type.uri),
        ...type.typeParameters.map((it) => it.bound?.uri)
      ],
    ].whereType<String>().where((uri) => uri != library.uri);
