extension DoubleExtension on double {
  String decimalToFraction() {
    const EPSILON = 1.0E-15;
    double h1 = 1;
    double h2 = 0;
    double k1 = 0;
    double k2 = 1;
    double b = this;
    do {
      double a = b.floorToDouble();
      double aux = h1;
      h1 = a * h1 + h2;
      h2 = aux;
      aux = k1;
      k1 = a * k1 + k2;
      k2 = aux;
      b = 1 / (b - a);
    } while ((this - h1 / k1).abs() > this * EPSILON);

    String fraction = "${h1.toInt()}/${k1.toInt()}";
    return fraction;
  }
}