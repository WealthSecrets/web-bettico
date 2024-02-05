import 'package:betticos/common/common.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

abstract class BetticosRemoteDataSource {
  Future<List<Post>> fetchPosts();

  Future<PaginatedResponseData<Post>> explorePosts(int page, int limit);

  Future<List<Post>> fetchFollowingPosts();

  Future<ListPage<Post>> fetchPaginatedPosts(int page, int limit);

  Future<List<Post>> fetchPostComments(String postId);

  Future<Post> addPost({
    required PostRequest request,
    required Function(int count, int total) onSendProgress,
  });

  Future<Setup> getSetup();

  Future<Post> updatePost({
    required String postId,
    required PostRequest request,
  });

  Future<Post> likePost({
    required String postId,
    required LikeDislikePostRequest request,
  });

  Future<Post> dislikePost({
    required String postId,
    required LikeDislikePostRequest request,
  });

  Future<Reply> addReply({
    required ReplyRequest request,
  });

  Future<Feeling> addFeeling({
    required FeelingRequest request,
  });

  Future<void> addReport({
    required ReportRequest request,
  });

  Future<Follow> followUser({
    required UserRequest request,
  });

  Future<User> blockUser({
    required String userId,
  });

  Future<Subscription> subscribeToUser({
    required SubscribeRequest request,
  });

  Future<Subscription> checkSubscription(String userId);

  Future<Follow> checkFollowing(String userId);

  Future<List<Post>> fetchSubscribedOddbox();

  Future<List<User>> getMyMembers();

  Future<User> resolveUser(String userId);

  Future<void> referUser(ReferralRequest request);

  Future<User> getReferralCode();

  Future<User> updateUserDevice(UserDeviceRequest request);

  Future<void> unfollowUser(String userId);

  Future<void> deletePost(String userId);

  Future<List<User>> getMyFollowers(String userId);

  Future<List<User>> getMyFollowings(String userId);

  Future<List<Post>> getMyPosts(String userId);

  Future<List<Post>> getMyOddboxes(String userId);

  Future<List<Post>> getMyLikedPosts();

  Future<List<User>> getAllOddsters();

  Future<List<User>> searchAllOddsters(String query);

  Future<List<User>> searchAllUsers(String query);

  Future<List<ReportOption>> getReportOptions(String type);

  Future<List<Listing>> fetchListings();

  Future<Listing> getListing({required String symbol});

  Future<List<Hashtag>> fetchHashtags();

  Future<SearchResponse> searchPosts(String keyword, int page, int limit);
}
