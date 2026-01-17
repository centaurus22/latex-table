class Table {
  final List<ColumnDefinition> columnDefinitions;
  final List<Row> rows;
  Table({required this.columnDefinitions, required this.rows});
}

class ColumnDefinition{}
class LeftAlignedColumn extends ColumnDefinition {}
class CenteredColumn extends ColumnDefinition {}
class RightAlignedColumn extends ColumnDefinition {}

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

sealed class Result {
  final List<String> warnings = [];
}

class Success extends Result {
  final String value;
  Success({required this.value});
}

class Error extends Result {
  final String error;
  Error({required this.error});
}
