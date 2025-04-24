void main() {

  String chuoi = "Hello, World!";

  
  print("Chuỗi đảo ngược: ${daoNguocChuoi(chuoi)}");


  print("Số lần xuất hiện của từng ký tự:");
  var ketQuaDem = demKyTu(chuoi);
  ketQuaDem.forEach((kyTu, soLan) {
  
    String hienThiKyTu = kyTu == ' ' ? "'khoảng trắng'" : kyTu;
    print("$hienThiKyTu: $soLan");
  });


  print("Chuỗi chữ hoa: ${chuyenThanhHoa(chuoi)}");
}


String daoNguocChuoi(String chuoi) {
  return chuoi.split('').reversed.join('');
}


Map<String, int> demKyTu(String chuoi) {
  Map<String, int> ketQua = {};
  for (var kyTu in chuoi.split('')) {
    ketQua[kyTu] = (ketQua[kyTu] ?? 0) + 1;
  }
  return ketQua;
}


String chuyenThanhHoa(String chuoi) {
  return chuoi.toUpperCase();
}