class User {
  var _name;
  var _email;
  var _password;

  User(this._name, this._email, this._password);

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

