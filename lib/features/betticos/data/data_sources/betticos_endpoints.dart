class BetticosEndpoints {
  static const String posts = 'posts';
  static const String followingPosts = 'follow/followingPosts';
  static const String oddbox = 'posts/oddbox';
  static const String comments = 'comments';
  static const String replies = 'replies';
  static const String feelings = 'feelings';
  static const String follow = 'follow';
  static const String reports = 'reports';
  static const String options = 'options';
  static const String device = 'users/device';
  static const String oddsters = 'users?role=oddster';
  static String paginatedPosts(int page, int limit) =>
      'follow/followingPosts?page=$page&limit=$limit';
  static String searchOddsters(String query) =>
      'users/search?query=$query&role=oddster';
  static String searchUsers(String query) =>
      'users/search?query=$query&role=user';
  static String followers(String userId) => 'follow/$userId/followers';
  static String followings(String userId) => 'follow/$userId/followings';
  static const String subscription = 'subscriptions';
  static const String members = 'subscriptions/members';
  static const String referUser = 'users/refer';
  static const String referCode = 'users/refer/code';
  static const String subscribedOddboxes = 'subscriptions/oddboxes';
  static String resetPassword = 'users/resetPassword';
  static String checkSubscription(String userId) =>
      'subscriptions/check/$userId';
  static String checkFollowing(String userId) => 'follow/check/$userId';
  static String resolveUser(String userId) => 'users/$userId';
  static String postComments(String postId) => 'posts/$postId/comments';
  static String myPosts(String userId) => 'posts/$userId/posts';
  static String myOddboxes(String userId) => 'posts/$userId/oddboxes';
  static String thePost(String postId) => 'posts/$postId';
  static String likePost(String postId) => 'posts/$postId/likePost';
  static String dislikePost(String postId) => 'posts/$postId/dislikePost';
  static String commentReplies(String commentId) => '';
  static String unfollowUser(String userId) => 'follow/$userId';
  static String blockUser(String userId) => 'users/$userId/block';
  static String optionsByType(String type) => 'options/$type/type';
  static const String setup = 'setup';
  static String explore(int page, int limit) =>
      'posts/explore?page=$page&limit=$limit';
}
