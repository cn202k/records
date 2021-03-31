import 'dart:async';

import 'package:build/build.dart';
import 'package:records/records.dart';
import 'package:records_generator/src/models.dart';
import 'package:records_generator/src/parser.dart';
import 'package:records_generator/src/template/library_template.dart';
import 'package:records_generator/src/validator.dart';
import 'package:records_generator/src/writer.dart';
import 'package:source_gen/source_gen.dart';

class RecordGenerator extends Generator {
  FutureOr<String> generate(
    LibraryReader library,
    BuildStep buildStep,
    // ) =>
    //     write(infalte(parse(validate(library))));
  ) {
    final model = parse(validate(library));
    model.types.forEach((it) => print(log(it, model.uri)));
    return write(inflate(model));
  }
}

String log(RecordType model, String uri) => [
      '######################################',
      'name: ${model.name}@$uri',
      'typeParameters: <${model.typeParameters.map((it) => '${it.name} extends ${it.bound?.name}').join(',')}>',
      'fields:',
      for (final field in model.fields) ...[
        '---------------------------------------',
        '> name: ${field.name}',
        '> type: ${field.type.name}@${field.type.uri}',
        '> isMandatory: ${field.isMandatory}',
        '> isPositional: ${field.isPositional}',
      ],
      '######################################',
    ].join('\n');
