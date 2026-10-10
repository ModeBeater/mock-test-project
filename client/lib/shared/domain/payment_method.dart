enum PaymentMethod {
  cash('Наличные', 'нал'),
  card('Безнал', 'безнал');

  const PaymentMethod(this.label, this.tag);

  final String label;

  /// Короткая метка в ленте поездок.
  final String tag;
}
