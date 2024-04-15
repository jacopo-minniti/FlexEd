class User {
  final String username;
  final String coursesCompleted;
  final String coursesEnrolled;
  final String coursesLiked;
  final String profilePicture;
  final String bio;
  User({
    required this.username,
    required this.bio,
    required this.coursesCompleted,
    required this.coursesEnrolled,
    required this.coursesLiked,
    required this.profilePicture,
  });

  static User fromMap(userMap) {
    return User(
        username: userMap['username'],
        bio: userMap['bio'],
        coursesCompleted: userMap['courses_completed'],
        coursesEnrolled: userMap['courses_enrolled'],
        coursesLiked: userMap['courses_liked'],
        profilePicture: updateDriveLink(userMap['profile_picture']));
  }

  static String updateDriveLink(String originalURL) {
    String fileId = originalURL.substring(
        originalURL.indexOf('/d/') + 3, originalURL.indexOf('/view'));
    String newURL = 'https://drive.google.com/uc?export=view&id=$fileId';
    return newURL;
  }
}
