//the model used for every post.
//while a post on the database is described by more fields, some of them have no use on the client and would only decrement performances.
//For example, filters are only used to sort posts, and ca not be modified after post creation,
//therefore, there is no need to pass more data than that used.

class Course {
  final String courseId;
  final String username;
  final String profilePicture;
  final String title;
  final String description;
  final String requirements;
  final bool isEnrolled;
  final bool isLiked;
  final String thumbnail;
  final String photo1;
  final String photo2;
  final int likes;
  final int enrolled;
  final String language;

  Course(
      {required this.courseId,
      required this.username,
      required this.profilePicture,
      required this.title,
      required this.description,
      required this.requirements,
      required this.isEnrolled,
      required this.isLiked,
      required this.likes,
      required this.enrolled,
      required this.photo1,
      required this.photo2,
      required this.language,
      required this.thumbnail});

  static Course fromMap(
      String courseId, bool isLiked, bool isEnrolled, Map course_data) {
    final course = Course(
      courseId: courseId,
      username: course_data['username'],
      profilePicture: updateDriveLink(course_data['profile_picture']),
      title: course_data['title'],
      description: course_data['description'],
      isEnrolled: isEnrolled,
      requirements: course_data['requirements'],
      isLiked: isLiked,
      likes: course_data['likes'],
      enrolled: course_data['enrolled'],
      photo1: updateDriveLink(course_data['photo1']),
      photo2: updateDriveLink(course_data['photo2']),
      language: course_data['language'],
      thumbnail: updateDriveLink(course_data['thumbnail']),
    );
    return course;
  }

  static String updateDriveLink(String originalURL) {
    String fileId = originalURL.substring(
        originalURL.indexOf('/d/') + 3, originalURL.indexOf('/view'));
    String newURL = 'https://drive.google.com/uc?export=view&id=$fileId';
    return newURL;
  }
}
