void main() {
  List<int> danhsach = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
  
  for (int phantu in danhsach) {
    if (phantu < 5) {
      print(phantu);
    }
  }
}