class User {
  var _name;
  var _email;
  var _password;

  //Constructor
  User(this._name, this._email, this._password);

  //Constructor vacío
  User.Empty();

  //Transformar a JSON
  User.fromJson(Map<String, dynamic> json)
  : _name = json['name'],
    _email = json['email'],
    _password = json['password'];

  Map<String, dynamic> ToJson() => {
    'name' : _name,
    'email' : _email,
    'password' : _password
  };
  
  //Getters &Setters
  get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;

  get password => _password;

  set password(value) {
    _password = value;
  }

  set email(value) {
    _email = value;
  }
}

