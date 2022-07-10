class CompleteForm {
  String name = "";
  String address = "";
  String phone = "";
  String emailAddress = "";
  String password = "";
  int radioButtonGender = 0;

  CompleteForm() {
    name = "";
    address = "";
    phone = "";
    emailAddress = "";
    password = "";
    radioButtonGender = 0;
  }

  CompleteForm.fromMap(map) {
    this.name = map["name"];
    this.address = map["address"];
    this.phone = map["phone"];
    this.emailAddress = map["emailAdress"];
    this.password = map["password"];
    this.radioButtonGender = map["radioButtonGender"];
  }

  String getName() {
    return name;
  }

  String getAddress() {
    return address;
  }

  String getPhone() {
    return phone;
  }

  String getEmailAddress() {
    return emailAddress;
  }

  String getPassword() {
    return password;
  }

  int getRadioButtonGender() {
    return radioButtonGender;
  }

  void setName(String name) {
    this.name = name;
  }

  void setAddress(String address) {
    this.address = address;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  void setEmailAddress(String emailAddress) {
    this.emailAddress = emailAddress;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setRadioButtonGender(int radioButtonGender) {
    this.radioButtonGender = radioButtonGender;
  }

  printCompleteForm() {
    print("Name: $name");
    print("Address: $address");
    print("Phone: $phone");
    print("E-mail: $emailAddress");
    print("Password: $password");
    print("Gender: $radioButtonGender");
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["address"] = address;
    map["phone"] = phone;
    map["emailAdress"] = emailAddress;
    map["password"] = password;
    map["radioButtonGender"] = radioButtonGender;
    return map;
  }
}
