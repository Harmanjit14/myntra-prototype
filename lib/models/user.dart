class User {
  String? name;
  String? email;
  String? image;
  String? jobType;
  int? score;
  bool verified=false;
  User(this.name, this.image, this.jobType, this.score, this.email,
      this.verified);
}

User user = User(
    "User",
    "https://firebasestorage.googleapis.com/v0/b/myntra-shybois.appspot.com/o/Constants%2Fuser.png?alt=media&token=ceb0f6b0-19d7-4869-890a-189a3fb22749",
    "No",
    100,
    "No Email Added",
    false);
