class StateManager{
  Map<String, dynamic> _statesContainer = {};


  void addValue(String key, dynamic value) {
    _statesContainer[key] = value;
  }

  void updateValue(String key, dynamic value) {
    _statesContainer[key] = value;

  }

  dynamic getValue(String key) {
    return _statesContainer[key];
  }

  bool existsValue(String key) {
    return _statesContainer.containsKey(key);
  }

  dynamic getAndDestroyValue(String key) {
    var result = _statesContainer[key];
    _statesContainer.remove(key);
    return result;
  }

  void removeValue(String key) {
    _statesContainer.remove(key);
  }

  void resetState() {
    _statesContainer = Map();

  }


}