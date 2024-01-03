import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/data.dart';
import 'package:betticos/features/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

abstract class BetticosRepository {
  Future<Either<Failure, List<Post>>> fetchPosts();

  Future<Either<Failure, PaginatedResponseData<Post>>> explorePosts(int page, int limit);

  Future<Either<Failure, List<Post>>> fetchFollowingPosts();

  Future<Either<Failure, ListPage<Post>>> fetchPaginatedPosts(
    int page,
    int limit,
  );

  Future<Either<Failure, List<Post>>> fetchPostComments(String postId);

  Future<Either<Failure, Post>> addPost({
    List<Uint8List>? files,
    String? text,
    String? slipCode,
    bool? isOddbox,
    bool? isReply,
    String? postId,
    required Function(int count, int total) onSendProgress,
  });

  Future<Either<Failure, Setup>> getSetup();

  Future<Either<Failure, Post>> updatePost({
    required String postId,
    String? text,
    String? slipCode,
    bool? isOddbox,
    List<String>? likeUsers,
    List<String>? dislikeUsers,
    List<String>? shares,
  });

  Future<Either<Failure, Post>> likePost({
    required String postId,
    required String user,
  });

  Future<Either<Failure, Post>> dislikePost({
    required String postId,
    required String user,
  });

  Future<Either<Failure, Reply>> addReply({
    required String text,
    required String commentId,
  });

  Future<Either<Failure, Feeling>> addFeeling({
    required String type,
    required String postId,
  });

  Future<Either<Failure, void>> addReport({
    required String type,
    required String optionId,
    String? postId,
    String? userId,
  });

  Future<Either<Failure, Follow>> followUser({
    required String userId,
  });

  Future<Either<Failure, User>> blockUser({
    required String userId,
  });

  Future<Either<Failure, Subscription>> subscribeToUser({
    required String userId,
  });

  Future<Either<Failure, Subscription>> checkSubscription({
    required String userId,
  });

  Future<Either<Failure, Follow>> checkFollowing({
    required String userId,
  });

  Future<Either<Failure, List<User>>> getMyMembers();

  Future<Either<Failure, User>> resolveUser({required String userId});

  Future<Either<Failure, List<Post>>> fetchSubscribedOddbox();

  Future<Either<Failure, void>> unfollowUser({required String userId});

  Future<Either<Failure, void>> deletePost({required String postId});

  Future<Either<Failure, User>> getReferralCode();

  Future<Either<Failure, User>> updateUserDevice({required String device});

  Future<Either<Failure, void>> referUser({
    required String email,
  });

  Future<Either<Failure, List<User>>> getMyFollowers(String userId);

  Future<Either<Failure, List<User>>> getMyFollowings(String userId);

  Future<Either<Failure, List<Post>>> getMyPosts(String userId);

  Future<Either<Failure, List<Post>>> getMyOddboxes(String userId);

  Future<Either<Failure, List<User>>> getAllOddsters();

  Future<Either<Failure, List<User>>> searchAllOddsters(String query);

  Future<Either<Failure, List<User>>> searchAllUsers(String query);

  Future<Either<Failure, List<ReportOption>>> getReportOptions(String type);

  Future<Either<Failure, List<Listing>>> fetchListings();

  Future<Either<Failure, Listing>> getListing({required String symbol});

  Future<Either<Failure, List<Hashtag>>> fetchHashtags();

  Future<Either<Failure, SearchResponse>> searchPosts(String keyword, int page, int limit);
}
