import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:records/records.dart';
import 'package:records_generator/src/config.dart';
import 'package:records_generator/src/models.dart';

Scope parse(LibraryReader library) => Scope(
      uri: _generatedFileUri(library.element.source.uri),
      originalUri: library.element.source.uri.toString(),
      exportOriginalUri:
          _shouldExportOriginalUriFromGeneratedFile(library),
      types: library
          .annotatedWith(const TypeChecker.fromRuntime(Record))
          .map((it) => it.element)
          .whereType<FunctionTypeAliasElement>()
          .map(_recordType),
    );

RecordType _recordType(FunctionTypeAliasElement element) => RecordType(
      name: _recordTypeName(element),
      typeParameters: _recordTypeParameters(element),
      fields: _recordFields(element),
    );

String _recordTypeName(FunctionTypeAliasElement element) => element.name;

Iterable<RecordTypeParameter> _recordTypeParameters(
        FunctionTypeAliasElement element) =>
    element.typeParameters.map(_recordTypeParameter);

RecordTypeParameter _recordTypeParameter(TypeParameterElement parameter) =>
    RecordTypeParameter(
      name: parameter.name,
      bound: _recordTypeParameterBound(parameter),
    );

Symbol? _recordTypeParameterBound(TypeParameterElement parameter) {
  final DartType? bound = parameter.bound;
  return bound != null
      ? Symbol(
          name: bound.toString(),
          uri: _recordTypeParameterBoundUri(parameter),
        )
      : null;
}

String? _recordTypeParameterBoundUri(TypeParameterElement parameter) {
  final boundElement = parameter.bound?.element;
  return boundElement != null ? _resolvedUri(boundElement) : null;
}

Iterable<RecordField> _recordFields(FunctionTypeAliasElement element) =>
    element.function.parameters.map(_recordField);

RecordField _recordField(ParameterElement element) => RecordField(
      name: _recordFieldName(element),
      type: _recordFieldType(element),
      isMandatory: _recordFieldIsMandatory(element),
      isPositional: _recordFieldIsPositional(element),
    );

String _recordFieldName(ParameterElement element) => element.name;

String? _recordFieldTypeUri(ParameterElement element) {
  final Element? typeElement = element.type.element;
  return typeElement != null ? _resolvedUri(typeElement) : null;
}

Symbol _recordFieldType(ParameterElement element) => Symbol(
      name: _recordFieldTypeSource(element),
      uri: _recordFieldTypeUri(element),
    );

final _parameterTypePattern = RegExp(r'\s*\w+\s*(<.+>)?\s*\??\s*$');

String _recordFieldTypeSource(ParameterElement element) {
  final type = element.type;
  if (_isFunctionTypeAlias(type.element)) {
    final source = element.source.contents.data;
    final match = _parameterTypePattern
        .firstMatch(source.substring(0, element.nameOffset))
        ?.group(0)
        ?.trim();
    if (match != null) return match;
  }
  return type.toString();
}

bool _isFunctionTypeAlias(Element? element) =>
    element != null && _resolveAlias(element) != null;

FunctionTypeAliasElement? _resolveAlias(Element element) {
  if (element is FunctionTypeAliasElement) return element;
  final enclosingElement = element.enclosingElement;
  if (enclosingElement is FunctionTypeAliasElement)
    return enclosingElement;
  return null;
}

bool _recordFieldIsPositional(ParameterElement element) =>
    element.isPositional;

bool _recordFieldIsMandatory(ParameterElement element) =>
    element.isRequiredPositional ||
    element.isRequiredNamed ||
    (element.isNamed && !_isNullableType(element.type));

bool _isNullableType(DartType type) =>
    type.nullabilitySuffix == NullabilitySuffix.question;

String? _resolvedUri(Element element) {
  if (element is TypeParameterElement) return null;
  final uri = element.source?.uri;
  if (uri == null) return null;
  if (_isCoreLibrary(uri)) return null;
  return _isRecordElement(element)
      ? _generatedFileUri(uri)
      : uri.toString();
}

bool _isCoreLibrary(Uri uri) => uri.toString().startsWith('dart:core');

bool _isRecordElement(Element element) {
  final alias = _resolveAlias(element);
  if (alias == null) return false;
  return _hasRecordAnnotation(element);
}

String _generatedFileUri(Uri uri) =>
    uri.toString().replaceFirst('.dart', generated_file_extension);

bool _hasRecordAnnotation(Element element) =>
    const TypeChecker.fromRuntime(Record).hasAnnotationOf(element);

bool _shouldExportOriginalUriFromGeneratedFile(LibraryReader library) =>
    library.element.imports
        .any((it) => it.uri == 'package:records/records_export.dart');
