class SimbolList {
  final List<String> _symbolList;

  SimbolList() : _symbolList = _listSembol();

  static List<String> _listSembol() {
    List<String> _symbolList = [];
    for (int i = 1; i < 99999; i++) {
      if (String.fromCharCode(i).isNotEmpty) {
        _symbolList.add('${String.fromCharCode(i)}');
      } else {
        _symbolList.add('Alt+$i: NOT');
      }
    }
    return _symbolList;
  }

  List<String> getSymbolList() => _symbolList;
}
