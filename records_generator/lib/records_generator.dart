library records_generator;

import 'package:build/build.dart';
import 'package:records_generator/src/config.dart';
import 'package:records_generator/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder records_generator(BuilderOptions options) => LibraryBuilder(
      RecordGenerator(),
      generatedExtension: generated_file_extension,
    );
