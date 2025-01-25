class ApiConstants{
/// google maps

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String estimatedTimeUrl="https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&";
   /// App Url
    static String baseUrl="http://10.0.60.205:9090/v1";
    static String  imageBaseUrl="http://10.0.60.205:9090";
    static String socketUrl="http://10.0.60.205:9090";

  static String googleApiKey="AIzaSyBFi80uuJIWkkLCpodFa8oXmD8XD_h8LMc";


///>>>>>>>>>>>>>>>>>>>>>>>>>>> User Auth>>>>>>>>>>>>>>>>>>>

static String registerUrl= '$baseUrl/auth/register';

static String emailSendUrl= '$baseUrl/auth/forgot-password';
static String verifyEmailWithOtpUrl= '$baseUrl/auth/verify-email';
static String resendOtpUrl= '$baseUrl/auth/re-send-otp';
static String logInUrl= '$baseUrl/auth/login';
static String resetPasswordUrl= '$baseUrl/auth/reset-password';


static String timelinePostUrl= '$baseUrl/post/home';
static String myPostUrl= '$baseUrl/post';
static String createPostUrl= '$baseUrl/post';
static String createGroupPostUrl= '$baseUrl/post';
static String allGroupListUrl= '$baseUrl/group';
static String createGroupUrl= '$baseUrl/group';
static String otherGroupListUrl= '$baseUrl/group/joined';
static String myGroupListUrl= '$baseUrl/group/my';
static String friendRequestListUrl= '$baseUrl/friend/requests';
static String myFriendLIstUrl= '$baseUrl/friend/friends';
static String subscriptionPackageListUrl= '$baseUrl/subscription';
static String paymentSubscriptionUrl= '$baseUrl/payment/subscription';
static String chatListUrl= '$baseUrl/chat/chart-list';
static String sendMessageUrl= '$baseUrl/message/add-message';
static String privacyPolicyUrl= '$baseUrl/info/privacy-policy';
static String termAndConditionUrl= '$baseUrl/info/terms-condition';
static String aboutUsUrl= '$baseUrl/info/about-us';
static String supportUrl= '$baseUrl/info/support';
static String removeGroupMemberUrl= '$baseUrl/group/remove-member';
static String addGroupMemberUrl= '$baseUrl/group/add-member';
static String createChatUrl= '$baseUrl/chat';
static String addGroupChatMember= '$baseUrl/chat/group';
static String removeGroupChatMember= '$baseUrl/chat/group/remove';
static String leaveGroupChatUrl= '$baseUrl/chat/group/live';
static String notificationUrl= '$baseUrl/notification';
static String rewardPaymentUrl= '$baseUrl/payment/post/reward';
static String groupTimelinePostUrl(dynamic groupId) => '$baseUrl/group/posts?groupId=$groupId';
static String getMessageUrl(dynamic chatId) => '$baseUrl/message/get-messages?chatId=$chatId';
static String updateGroupChatUrl(dynamic chatId) => '$baseUrl/chat?id=$chatId';
static String deleteGroupUrl(dynamic groupId) => '$baseUrl/group/$groupId';
static String inviteFriendUrl(dynamic groupId) => '$baseUrl/group/all-invite-friend?groupId=$groupId';
static String updateGroupUrl(dynamic groupId) => '$baseUrl/group/update/$groupId';
static String groupSearchResultUrl(String name) => '$baseUrl/group/search?name=$name';
static String searchMyFriendListUrl(String name) => '$baseUrl/friend/friends?fullName=$name';
static String searchMyGroupChatMemberListUrl(String name) => '$baseUrl/chat/group/all-member?fullName=$name';
static String groupJoinUrl(dynamic groupId) => '$baseUrl/group/join?groupId=$groupId';
static String leaveGroupUrl(dynamic groupId) => '$baseUrl/group/left?groupId=$groupId';
static String acceptFriendRequestUrl(dynamic requestId) => '$baseUrl/friend/accept?requestId=$requestId';
static String removeFriendUrl(dynamic friendId) => '$baseUrl/friend/remove?friendId=$friendId';
static String groupAboutUrl(dynamic groupId) => '$baseUrl/group/$groupId';
static String deletePostUrl(dynamic postId)=> '$baseUrl/post/$postId';
static String  likeUrl (dynamic postId)=> '$baseUrl/post/like-toggle?postId=$postId';
static String  getCommentsUrl (dynamic postId)=> '$baseUrl/post/comments?postId=$postId';
static String  postCommentsUrl (dynamic postId)=> '$baseUrl/post/comment?postId=$postId';
static String  getProfileUrl (dynamic postId)=> '$baseUrl/users/$postId';
static String  updateProfileUrl (dynamic postId)=> '$baseUrl/users/$postId';
static String  sendFriendRequestUrl (dynamic postId)=> '$baseUrl/friend/request?receiverId=$postId';
static String  searchNameUrl (String name)=> '$baseUrl/users?fullName=$name';


}