class NoInternetException {
  String message = "Your Internet is off";
  NoInternetException(this.message);

}

class NoServiceFoundException {
  String message;
  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  String message;
  InvalidFormatException(this.message);
}

class UnknownException {
  String message;
  UnknownException(this.message);
}

class TimeOutException {
  String message;
  TimeOutException(this.message);
}

class IOException {
  String message;
  IOException(this.message);
}