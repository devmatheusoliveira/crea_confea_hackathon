class TabelaValoresController {
  static double getValor(double valor, bool isRotina) {
    if (!isRotina || (valor > 7500 && valor <= 15000)) {
      if (valor <= 15000) return 103.03;
      return 271.47;
    }
    if (valor < 500) return 2;
    if (valor > 500 && valor <= 1000) return 4.06;
    if (valor > 1000 && valor <= 2000) return 6.06;
    if (valor > 2000 && valor <= 3000) return 10.14;
    if (valor > 3000 && valor <= 4500) return 16.31;
    if (valor > 4500 && valor <= 6000) return 24.44;
    if (valor > 6000 && valor <= 7500) return 32.78;
    return -1;
  }
}
