import 'package:betticos/features/betticos/data/models/option/option_model.dart';
import 'package:betticos/features/betticos/data/models/setup/setup_model.dart';
import 'package:betticos/features/betticos/domain/requests/post/like_dislike_post_request.dart';
import 'package:betticos/features/betticos/domain/requests/report/report_request.dart';
import 'package:betticos/features/betticos/domain/requests/user/user_device_request.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/data/models/feeling/feeling_model.dart';
import '/features/betticos/data/models/follow/follow_model.dart';
import '/features/betticos/data/models/listpage/listpage.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/data/models/reply/reply_model.dart';
import '/features/betticos/data/models/subscription/subscription_model.dart';
import '/features/betticos/domain/requests/feeling/feeling_request.dart';
import '/features/betticos/domain/requests/post/post_request.dart';
import '/features/betticos/domain/requests/reply/reply_request.dart';
import '/features/betticos/domain/requests/subscrbe/subscribe_request.dart';
import '../../domain/requests/follow/user_request.dart';
import '../../domain/requests/referral/referral_request.dart';

abstract class BetticosRemoteDataSource {
  Future<List<Post>> fetchPosts();

  Future<ListPage<Post>> explorePosts(int page, int limit);

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

  Future<List<User>> getAllOddsters();

  Future<List<User>> searchAllOddsters(String query);

  Future<List<User>> searchAllUsers(String query);

  Future<List<ReportOption>> getReportOptions(String type);
}
