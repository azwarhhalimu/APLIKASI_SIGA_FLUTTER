import 'dart:convert';

String encryptRC4(String plainText, String key) {
  List<int> s = List<int>.generate(256, (i) => i);
  int j = 0;

  for (int i = 0; i < 256; i++) {
    j = (j + s[i] + key.codeUnitAt(i % key.length)) % 256;
    int temp = s[i];
    s[i] = s[j];
    s[j] = temp;
  }

  int i = 0;
  j = 0;
  List<int> cipher = [];

  for (int n = 0; n < plainText.length; n++) {
    i = (i + 1) % 256;
    j = (j + s[i]) % 256;
    int temp = s[i];
    s[i] = s[j];
    s[j] = temp;
    int keyIndex = s[(s[i] + s[j]) % 256];
    int cipherByte = plainText.codeUnitAt(n) ^ keyIndex;
    cipher.add(cipherByte);
  }

  return base64.encode(cipher);
}
