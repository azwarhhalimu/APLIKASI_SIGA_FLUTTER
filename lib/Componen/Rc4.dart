import 'dart:convert';

class RC4 {
  static List<int> _S = [];

  static void _swap(List<int> arr, int i, int j) {
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
  }

  static List<int> _KSA(String key) {
    if (_S.isEmpty) {
      _S = List.generate(256, (index) => index);
    } else {
      _S.fillRange(0, 256, 0);
    }

    int j = 0;
    var c = "";
    for (int i = 0; i < 256; i++) {
      int charCode = key.codeUnitAt(i % key.length);
      j = (j + _S[i] + charCode) % 256;
      _swap(_S, i, j);
    }

    return _S;
  }

  static String encrypt(String key, String data) {
    List<int> S = _KSA(key);
    int i = 0;
    int j = 0;
    List<int> result = [];

    for (int m = 0; m < data.length; m++) {
      i = (i + 1) % 256;
      j = (j + S[i]) % 256;
      _swap(S, i, j);
      int charCode = data.codeUnitAt(m);
      int temp = S[(S[i] + S[j]) % 256] ^ charCode;
      result.add(temp);
    }

    return utf8.decode(result);
  }

  static String decrypt(String key, String data) {
    return encrypt(key, data);
  }
}
