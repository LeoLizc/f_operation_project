class Operation {
  final int operando1;
  final int operando2;
  final String operador;
  final int resultado;

  Operation({
    required this.operando1,
    required this.operando2,
    required this.operador,
    required this.resultado,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Operation &&
          runtimeType == other.runtimeType &&
          operando1 == other.operando1 &&
          operando2 == other.operando2 &&
          operador == other.operador &&
          resultado == other.resultado;

  @override
  int get hashCode =>
      operando1.hashCode ^
      operando2.hashCode ^
      operador.hashCode ^
      resultado.hashCode;
}
