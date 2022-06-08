


class User{
  dynamic id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  dynamic urlPropic;
  String address;
  dynamic password;
  dynamic roles;
  User({this.id, required this.firstName, required this.lastName, required this.phoneNumber, required this.email, required this.address,this.urlPropic, this.password,this.roles});
  factory User.def(){
    return User(id:null,firstName: "undefined", lastName: "undefined", phoneNumber: "undefined", email: "undefined", address: "undefined", urlPropic: null,password: "undefined",roles: []);
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id:json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        urlPropic: json['urlPropic'],
        address: json['address'],
        password: json['password'],
        roles: json['roles'],
    );
  }
  Map<String, dynamic> toJson() => {

    'firstName': firstName,
    'lastName':lastName,
    'phoneNumber':phoneNumber,
    'email': email,
    'urlPropic':urlPropic,
    'address':address,
    'password':password,
    'roles':roles,

  };
  @override
  String toString() {
    // TODO: implement toString
    return "user{name: "+firstName+" last: "+lastName+" email: "+email+" number: "+phoneNumber+" urlPropic: "+(urlPropic!=null?urlPropic:"")+"address: "+address;
  }
}
