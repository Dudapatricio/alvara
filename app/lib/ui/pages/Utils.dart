class Validators {
  final List<bool> _validators = [];
  String _errorMessage = "";
  final String? value;

  Validators(this.value);

  Validators setErroMessage(String errorMessage) {
    _errorMessage = errorMessage;
    return this;
  }

  bool valid() => !_validators.contains(false);

  String? apply() => valid() ? null : _errorMessage;

  Validators isNotNull() {
    _validators.add(value != null);
    return this;
  }

  Validators isNotEmpty() {
    _validators.add(value != null && value!.isNotEmpty);
    return this;
  }

  Validators isMinLengh(int min) {
    _validators.add(value != null && value!.length >= min);
    return this;
  }

  Validators isMaxLengh(int max) {
    _validators.add(value != null && value!.length <= max);
    return this;
  }

  Validators isOnlyNumber() {
    _validators.add(value != null && RegExp(r'^\d+$').hasMatch(value!));
    return this;
  }
}
