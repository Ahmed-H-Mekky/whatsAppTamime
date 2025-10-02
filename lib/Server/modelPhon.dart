class Modelphon {
  final String myNumber;
  final String otherNamber;
  Modelphon({required this.myNumber, required this.otherNamber});
  factory Modelphon.fromjson(phon) {
    return Modelphon(
      myNumber: phon['myNumber'],
      otherNamber: phon['otherNamber'],
    );
  }
}
