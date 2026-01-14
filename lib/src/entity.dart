class Table {
  final List<FieldDefinition> fieldDefinitions;
  final List<Row> rows;
  Table({required this.fieldDefinitions, required this.rows});
}

class FieldDefinition{}
class LeftAlignedField extends FieldDefinition {}
class CenteredField extends FieldDefinition {}
class RightAlignedField extends FieldDefinition {}

class Row {}
class TopRule extends Row {}
class MidRule extends Row {}
class BottomRule extends Row {}

class DataRow extends Row {
  final List<Field> fields;
  DataRow({required this.fields});
}

class Field {
  final String value;
  Field ({required this.value});
}

class EuroField extends Field {
  EuroField({required super.value});
}
