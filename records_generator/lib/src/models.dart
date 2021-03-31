class Scope {
  final Iterable<RecordType> types;
  final String uri;
  final String originalUri;
  final bool exportOriginalUri;

  Scope({
    required this.types,
    required this.uri,
    required this.originalUri,
    required this.exportOriginalUri,
  });
}

class RecordType {
  final String name;
  final Iterable<RecordTypeParameter> typeParameters;
  final Iterable<RecordField> fields;

  RecordType({
    required this.name,
    required this.typeParameters,
    required this.fields,
  });
}

class RecordField {
  final String name;
  final Symbol type;
  final bool isMandatory;
  final bool isPositional;

  RecordField({
    required this.name,
    required this.type,
    required this.isMandatory,
    required this.isPositional,
  });
}

class RecordTypeParameter {
  final String name;
  final Symbol? bound;

  RecordTypeParameter({
    required this.name,
    this.bound,
  });

  @override
  String toString() {
    final bound = this.bound?.name;
    return bound != null ? '$name extends $bound' : name;
  }
}

class Symbol {
  final String name;
  final String? uri;

  Symbol({
    required this.name,
    required this.uri,
  });
}
