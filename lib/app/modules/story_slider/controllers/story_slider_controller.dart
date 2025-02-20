import 'package:get/get.dart';

class Story {
  final String imageUrl;

  Story({required this.imageUrl});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
    };
  }
}



class User {
  final String name;
  final List<Story> stories;

  User({required this.name, required this.stories});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      stories: (json['stories'] as List).map((story) => Story.fromJson(story)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stories': stories.map((story) => story.toJson()).toList(),
    };
  }
}


class StorySliderController extends GetxController{
  RxList<User> users = RxList<User>([
    User(
      name: 'User 1',
      stories: [
        Story(imageUrl: 'https://plus.unsplash.com/premium_photo-1724654643848-ab19f6ec1c79?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9scGhpbnxlbnwwfHwwfHx8MA%3D%3D'),
        Story(imageUrl: 'https://plus.unsplash.com/premium_photo-1724654645061-e1d2c5f319b1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDI0fHx8ZW58MHx8fHx8'),
        Story(imageUrl: 'https://plus.unsplash.com/premium_photo-1724654643848-ab19f6ec1c79?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9scGhpbnxlbnwwfHwwfHx8MA%3D%3D'),
      ],
    ),
    User(
      name: 'User 2',
      stories: [
        Story(imageUrl: 'https://images.pexels.com/photos/1054655/pexels-photo-1054655.jpeg?cs=srgb&dl=pexels-hsapir-1054655.jpg&fm=jpg'),
        Story(imageUrl: 'https://images.pexels.com/photos/1054658/pexels-photo-1054658.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
      ],
    ),
    User(
      name: 'User 3',
      stories: [
        Story(imageUrl: 'https://thumbs.dreamstime.com/b/bengal-tiger-walks-towards-camera-grass-93930359.jpg'),
      ],
    ),
  ]);

  var currentUserIndex = 0.obs;
  var currentStoryIndex = 0.obs;

  void nextUser() {
    print("nextUser called");
    if (currentStoryIndex.value == users[currentUserIndex.value].stories.length - 1) {
      print("nextUser if check last index of the user");
      // Check if there's a next user
      if (currentUserIndex.value < users.length -1) {
        print("go to next user logic");
        currentUserIndex.value++; // Move to the next user
        currentStoryIndex.value = 0; // Reset story index for the next user
      } else {
        print("No more users, you are on the last one.");
      }
    } else {
      // This will be called if we're not on the last story for the current user
      print("Moving to the next story...");
      currentStoryIndex.value++; // Move to the next story for the current user
    }
  }

  // Function to move to the previous story or user
  void prevUser() {
    if (currentStoryIndex.value == 0) {
      // If we are on the first story of the current user, move to the previous user
      if (currentUserIndex.value > 0) {
        currentUserIndex.value--;
        currentStoryIndex.value = users[currentUserIndex.value].stories.length - 1;
      }
    } else {
      // Otherwise, move to the previous story of the current user
      currentStoryIndex.value--;
    }
  }

  // Reset current story index when user changes
  void resetStoryIndex() {
    currentStoryIndex.value = 0;
  }
}