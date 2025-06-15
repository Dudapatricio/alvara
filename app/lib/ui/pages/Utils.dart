class Validators {
  List<bool> _vlidators = [];
  String _errorMessage = "";
  final String? value;

  Validators(this.value);

  Validators setErroMessage(String errorMessage) {
    _errorMessage = errorMessage;
    return this;
  }

  bool valid() {
    return !_vlidators.any((it) => !it);
  }

  String? apply() {
    return valid() ? null : _errorMessage;
  }

  Validators isNotNull() {
    final b = value != null;
    _vlidators.add(b);
    return this;
  }

  Validators isNotEmpty() {
    final b = value!.isNotEmpty;
    _vlidators.add(b);
    return this;
  }

  Validators isMinLengh(int min) {
    final b = value!.length < min;
    _vlidators.add(b);
    return this;
  }

  Validators isMaxLengh(int max) {
    final b = value!.length > max;
    _vlidators.add(b);
    return this;
  }

  Validators isOnlyNumber() {
    final b = value!.replaceAll(RegExp(r"[^0-9]"), "").isEmpty;
    _vlidators.add(b);
    return this;
  }
}
