class Account{
  String _name = "";
  int _bank = 0;
  final List _history = [];

  Account(this._name, this._bank, {required List hist}){
    for(var item in hist) {
      _history.add(item);
    }
  }

  List get history => _history;

  int get bank => _bank;

  String get name => _name;

  income(int bank){
    _bank += bank;
  }

  expense(int bank){
    _bank -= bank;
  }

  rename(String name){
    _name = name;
  }

  newBalance(int bal){
    _bank = bal;
  }

  addHistory(Map hist){
    _history.add(hist);
  }

  clearHistory(){
    _history.clear();
  }
}