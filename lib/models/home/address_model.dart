class AddressModel{
  int? id;
  String? name;

  String? mobile;

  String? province;

  String? city;

  String? district;

  String? address;

  int? isDefault;

  AddressModel({
    this.id,
    this.name,
    this.mobile,
    this.province,
    this.city,
    this.district,
    this.address,
    this.isDefault,
  });

  factory AddressModel.empty() {
    return AddressModel(id: null,name: '',mobile: '',province: '',city: '',district: '',address: '',isDefault: 0);
  }
}