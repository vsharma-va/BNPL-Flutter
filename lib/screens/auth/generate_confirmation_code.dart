import 'dart:math';

String getConfirmationCode() {
  var rng = Random();
  var code = '';
  for (var i = 0; i < 7; i++) {
    code += rng.nextInt(10).toString(); // till 9
  }
  return code;
}
