class Table {
  final RowDefinition rowDefinition;
  final List<Row> rows;
}

class RowDefinition{
  final List<FieldDefinition> fields; 
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
}

class Field {
  final String value;
}

class EuroField extends Field {}
