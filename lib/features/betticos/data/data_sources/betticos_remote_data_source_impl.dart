import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';

class BetticosRemoteDataSourceImpl implements BetticosRemoteDataSource {
  const BetticosRemoteDataSourceImpl({required AppHTTPClient client}) : _client = client;
  final AppHTTPClient _client;

  @override
  Future<Post> addPost({
    required PostRequest request,
    required Function(int count, int total) onSendProgress,
  }) async {
    final Map<String, dynamic> json = await _client.post(
      BetticosEndpoints.posts,
      body: request.toJson(),
      onReceiveProgress: (int count, int total) {},
      onSendProgress: onSendProgress,
    );
    return Post.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Post> updatePost({required String postId, required PostRequest request}) async {
    final Map<String, dynamic> json = await _client.patch(BetticosEndpoints.thePost(postId), body: request.toJson());
    return Post.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deletePost(String postId) async {
    await _client.delete(BetticosEndpoints.thePost(postId), body: <String, dynamic>{});
  }

  @override
  Future<Post> likePost({required String postId, required LikeDislikePostRequest request}) async {
    final Map<String, dynamic> json = await _client.post(BetticosEndpoints.likePost(postId), body: request.toJson());
    return Post.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Post> dislikePost({required String postId, required LikeDislikePostRequest request}) async {
    final Map<String, dynamic> json = await _client.post(BetticosEndpoints.dislikePost(postId), body: request.toJson());
    return Post.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<Feeling> addFeeling({required FeelingRequest request}) async {
    final Map<String, dynamic> json = await _client.post(BetticosEndpoints.feelings, body: request.toJson());
    return Feeling.fromJson(json);
  }

  @override
  Future<void> addReport({required ReportRequest request}) async {
    await _client.post(BetticosEndpoints.reports, body: request.toJson());
  }

  @override
  Future<Reply> addReply({required ReplyRequest request}) async {
    final Map<String, dynamic> json = await _client.post(BetticosEndpoints.replies, body: request.toJson());
    return Reply.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Post>> fetchPosts() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.posts);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<PaginatedResponseData<Post>> explorePosts(int page, int limit) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.explore(page, limit));
    return PaginatedResponseData<Post>.fromJson(
      json,
      (Object? j) => j == null ? Post.empty() : Post.fromJson(j as Map<String, dynamic>),
    );
  }

  @override
  Future<List<Post>> fetchFollowingPosts() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.followingPosts);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<User> resolveUser(String userId) async {
    final Map<String, dynamic> json = await _client.get(
      BetticosEndpoints.resolveUser(userId),
    );

    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<void> referUser(ReferralRequest request) async {
    await _client.post(
      BetticosEndpoints.referUser,
      body: request.toJson(),
    );
  }

  @override
  Future<User> getReferralCode() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.referCode);
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<List<Post>> fetchPostComments(String postId) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.postComments(postId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<Follow> followUser({required UserRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      BetticosEndpoints.follow,
      body: request.toJson(),
    );
    return Follow.fromJson(json);
  }

  @override
  Future<User> updateUserDevice(UserDeviceRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      BetticosEndpoints.device,
      body: request.toJson(),
    );
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> blockUser({required String userId}) async {
    final Map<String, dynamic> json =
        await _client.post(BetticosEndpoints.blockUser(userId), body: <String, dynamic>{});
    return User.fromJson(json['user'] as Map<String, dynamic>);
  }

  @override
  Future<Subscription> subscribeToUser({required SubscribeRequest request}) async {
    final Map<String, dynamic> json = await _client.post(
      BetticosEndpoints.subscription,
      body: request.toJson(),
    );
    if (json.isEmpty) {
      return Subscription.empty();
    }
    return Subscription.fromJson(json);
  }

  @override
  Future<Subscription> checkSubscription(String userId) async {
    final Map<String, dynamic> json = await _client.get(
      BetticosEndpoints.checkSubscription(userId),
    );
    if (json.isEmpty) {
      return Subscription.empty();
    }
    return Subscription.fromJson(json);
  }

  @override
  Future<Follow> checkFollowing(String userId) async {
    final Map<String, dynamic> json = await _client.get(
      BetticosEndpoints.checkFollowing(userId),
    );
    if (json.isEmpty) {
      return Follow.empty();
    }
    return Follow.fromJson(json);
  }

  @override
  Future<Setup> getSetup() async {
    final Map<String, dynamic> json = await _client.get(
      BetticosEndpoints.setup,
    );
    if (json.isEmpty) {
      return Setup.empty();
    }
    return Setup.fromJson(json);
  }

  @override
  Future<List<Post>> fetchSubscribedOddbox() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.subscribedOddboxes);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<User>> getMyMembers() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.members);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<User>> getMyFollowers(String userId) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.followers(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<User>> getMyFollowings(String userId) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.followings(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Post>> getMyPosts(String userId) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.myPosts(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<Post>> getMyOddboxes(String userId) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.myOddboxes(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await _client.delete(BetticosEndpoints.unfollowUser(userId), body: <String, dynamic>{});
  }

  @override
  Future<List<User>> getAllOddsters() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.oddsters);
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<User>> searchAllOddsters(String query) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.searchOddsters(query));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<User>> searchAllUsers(String query) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.searchUsers(query));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<List<ReportOption>> getReportOptions(String type) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.optionsByType(type));
    final List<dynamic> items = json['items'] as List<dynamic>;
    return List<ReportOption>.from(
      items.map<ReportOption>(
        (dynamic json) => ReportOption.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<ListPage<Post>> fetchPaginatedPosts(int page, int limit) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.paginatedPosts(page, limit));
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Post> posts = List<Post>.from(
      items.map<Post>(
        (dynamic json) => Post.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Post>(
      grandTotalCount: json['results'] as int,
      itemList: posts,
    );
  }

  @override
  Future<List<Listing>> fetchListings() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.listings);
    final List<dynamic> items = json['data'] as List<dynamic>;
    return List<Listing>.from(
      items.map<Listing>(
        (dynamic json) => Listing.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<Listing> getListing({required String symbol}) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.listing(symbol));
    return Listing.fromJson(json['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Hashtag>> fetchHashtags() async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.hashtags);
    final List<dynamic> items = json['data'] as List<dynamic>;
    return List<Hashtag>.from(
      items.map<Hashtag>(
        (dynamic json) => Hashtag.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<SearchResponse> searchPosts(String keyword, int page, int limit) async {
    final Map<String, dynamic> json = await _client.get(BetticosEndpoints.searchPosts(keyword, page, limit));
    return SearchResponse.fromJson(json['data'] as Map<String, dynamic>);
  }
}
