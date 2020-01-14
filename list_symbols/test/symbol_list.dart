class ModelSymbolList {
  final List<String> _listSimbol;

  ModelSymbolList() : this._listSimbol = _list();

  static List<String> _list() {
    List<String> _listSimbol = [];
    for (var i = 0; i < 10000; i++) {
      _listSimbol.add(String.fromCharCode(i));
    }
    return _listSimbol;
  }

  List<String> getListSimbol() => _listSimbol;
}
