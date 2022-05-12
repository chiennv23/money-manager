class Product {
  String productCode;
  String supplierCode;

  Product({this.productCode, this.supplierCode});

  Product.fromJson(Map<String, dynamic> data) {
    final json = data['Result'][0];
    productCode = json['PRODUCT_CODE'];
    supplierCode = json['SUPPLIER_CODE'];
  }
}
