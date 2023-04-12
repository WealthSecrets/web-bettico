import 'package:betticos/core/models/paginated_response_data.dart';
import 'package:betticos/features/betticos/data/models/option/option_model.dart';
import 'package:betticos/features/betticos/data/models/setup/setup_model.dart';
import 'package:betticos/features/betticos/domain/requests/referral/referral_request.dart';
import 'package:betticos/features/betticos/domain/requests/report/report_request.dart';
import 'package:betticos/features/betticos/domain/requests/user/user_device_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '/core/core.dart';
import '/features/auth/data/data_sources/auth_local_data_source.dart';
import '/features/auth/data/models/user/user.dart';
import '/features/betticos/data/data_sources/betticos_remote_data_source.dart';
import '/features/betticos/data/models/feeling/feeling_model.dart';
import '/features/betticos/data/models/follow/follow_model.dart';
import '/features/betticos/data/models/listpage/listpage.dart';
import '/features/betticos/data/models/post/post_model.dart';
import '/features/betticos/data/models/reply/reply_model.dart';
import '/features/betticos/data/models/subscription/subscription_model.dart';
import '/features/betticos/domain/repositories/betticos_repository.dart';
import '/features/betticos/domain/requests/feeling/feeling_request.dart';
import '/features/betticos/domain/requests/post/like_dislike_post_request.dart';
import '/features/betticos/domain/requests/post/post_request.dart';
import '/features/betticos/domain/requests/reply/reply_request.dart';
import '/features/betticos/domain/requests/subscrbe/subscribe_request.dart';
import '../../domain/requests/follow/user_request.dart';
import '../models/listing/listing_model.dart';

class BetticosRepositoryImpl extends Repository implements BetticosRepository {
  BetticosRepositoryImpl({
    required this.betticoslineRemoteDataSource,
    required this.authLocalDataSource,
  });

  final BetticosRemoteDataSource betticoslineRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, Post>> addPost({
    List<Uint8List>? files,
    String? text,
    String? slipCode,
    bool? isOddbox,
    bool? isReply,
    String? postId,
    required Function(int count, int total) onSendProgress,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.addPost(
          request: PostRequest(
            text: text,
            isOddbox: isOddbox,
            slipCode: slipCode,
            isReply: isReply,
            postId: postId,
            files: files,
          ),
          onSendProgress: onSendProgress,
        ),
      );

  @override
  Future<Either<Failure, Post>> updatePost({
    required String postId,
    String? text,
    String? slipCode,
    bool? isOddbox,
    List<String>? likeUsers,
    List<String>? dislikeUsers,
    List<String>? shares,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.updatePost(
          postId: postId,
          request: PostRequest(
            text: text,
            isOddbox: isOddbox,
            slipCode: slipCode,
            dislikeUsers: dislikeUsers,
            likeUsers: likeUsers,
            shares: shares,
          ),
        ),
      );

  @override
  Future<Either<Failure, Post>> likePost({
    required String postId,
    required String user,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.likePost(
          postId: postId,
          request: LikeDislikePostRequest(user: user),
        ),
      );

  @override
  Future<Either<Failure, Post>> dislikePost({
    required String postId,
    required String user,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.dislikePost(
          postId: postId,
          request: LikeDislikePostRequest(user: user),
        ),
      );

  @override
  Future<Either<Failure, List<Post>>> fetchPosts() => makeRequest(
        betticoslineRemoteDataSource.fetchPosts(),
      );

  @override
  Future<Either<Failure, PaginatedResponseData<Post>>> explorePosts(
          int page, int limit) =>
      makeRequest(
        betticoslineRemoteDataSource.explorePosts(page, limit),
      );

  @override
  Future<Either<Failure, List<Post>>> fetchFollowingPosts() => makeRequest(
        betticoslineRemoteDataSource.fetchFollowingPosts(),
      );

  @override
  Future<Either<Failure, List<Post>>> fetchPostComments(String postId) =>
      makeRequest(
        betticoslineRemoteDataSource.fetchPostComments(postId),
      );

  @override
  Future<Either<Failure, User>> resolveUser({required String userId}) async {
    final Either<Failure, User> response =
        await makeRequest(betticoslineRemoteDataSource.resolveUser(userId));
    return response.fold((Failure failure) => left(failure),
        (User response) async {
      return right(response);
    });
  }

  @override
  Future<Either<Failure, void>> referUser({required String email}) =>
      makeRequest(
        betticoslineRemoteDataSource.referUser(
          ReferralRequest(email: email),
        ),
      );

  @override
  Future<Either<Failure, User>> getReferralCode() async {
    final Either<Failure, User> response =
        await makeRequest(betticoslineRemoteDataSource.getReferralCode());
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, Reply>> addReply({
    required String text,
    required String commentId,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.addReply(
          request: ReplyRequest(
            text: text,
            commentId: commentId,
          ),
        ),
      );

  @override
  Future<Either<Failure, User>> updateUserDevice(
      {required String device}) async {
    final Either<Failure, User> response = await makeRequest(
        betticoslineRemoteDataSource
            .updateUserDevice(UserDeviceRequest(device: device)));
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, Feeling>> addFeeling({
    required String type,
    required String postId,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.addFeeling(
          request: FeelingRequest(
            type: type,
            postId: postId,
          ),
        ),
      );

  @override
  Future<Either<Failure, void>> addReport({
    required String type,
    required String optionId,
    String? postId,
    String? userId,
  }) =>
      makeRequest(
        betticoslineRemoteDataSource.addReport(
          request: ReportRequest(
            type: type,
            postId: postId,
            optionId: optionId,
            userId: userId,
          ),
        ),
      );

  @override
  Future<Either<Failure, Follow>> followUser({required String userId}) =>
      makeRequest(
        betticoslineRemoteDataSource.followUser(
          request: UserRequest(
            userId: userId,
          ),
        ),
      );

  @override
  Future<Either<Failure, Setup>> getSetup() =>
      makeRequest(betticoslineRemoteDataSource.getSetup());

  @override
  Future<Either<Failure, User>> blockUser({required String userId}) async {
    final Either<Failure, User> response = await makeRequest(
      betticoslineRemoteDataSource.blockUser(userId: userId),
    );
    return response.fold((Failure failure) => left(failure), (User user) async {
      await authLocalDataSource.persistUserData(user);
      return right(user);
    });
  }

  @override
  Future<Either<Failure, Subscription>> subscribeToUser(
          {required String userId}) =>
      makeRequest(
        betticoslineRemoteDataSource.subscribeToUser(
          request: SubscribeRequest(
            userId: userId,
          ),
        ),
      );

  @override
  Future<Either<Failure, Subscription>> checkSubscription(
          {required String userId}) =>
      makeRequest(betticoslineRemoteDataSource.checkSubscription(userId));

  @override
  Future<Either<Failure, Follow>> checkFollowing({required String userId}) =>
      makeRequest(betticoslineRemoteDataSource.checkFollowing(userId));

  @override
  Future<Either<Failure, List<User>>> getMyMembers() =>
      makeRequest(betticoslineRemoteDataSource.getMyMembers());

  @override
  Future<Either<Failure, List<Post>>> fetchSubscribedOddbox() => makeRequest(
        betticoslineRemoteDataSource.fetchSubscribedOddbox(),
      );

  @override
  Future<Either<Failure, List<User>>> getMyFollowers(String userId) =>
      makeRequest(betticoslineRemoteDataSource.getMyFollowers(userId));

  @override
  Future<Either<Failure, List<User>>> getMyFollowings(String userId) =>
      makeRequest(betticoslineRemoteDataSource.getMyFollowings(userId));

  @override
  Future<Either<Failure, List<Post>>> getMyPosts(String userId) =>
      makeRequest(betticoslineRemoteDataSource.getMyPosts(userId));

  @override
  Future<Either<Failure, List<Post>>> getMyOddboxes(String userId) =>
      makeRequest(betticoslineRemoteDataSource.getMyOddboxes(userId));

  @override
  Future<Either<Failure, void>> unfollowUser({required String userId}) =>
      makeRequest(betticoslineRemoteDataSource.unfollowUser(userId));

  @override
  Future<Either<Failure, void>> deletePost({required String postId}) =>
      makeRequest(betticoslineRemoteDataSource.deletePost(postId));

  @override
  Future<Either<Failure, List<User>>> getAllOddsters() =>
      makeRequest(betticoslineRemoteDataSource.getAllOddsters());

  @override
  Future<Either<Failure, List<User>>> searchAllOddsters(String query) =>
      makeRequest(betticoslineRemoteDataSource.searchAllOddsters(query));

  @override
  Future<Either<Failure, List<User>>> searchAllUsers(String query) =>
      makeRequest(betticoslineRemoteDataSource.searchAllUsers(query));

  @override
  Future<Either<Failure, List<ReportOption>>> getReportOptions(String type) =>
      makeRequest(betticoslineRemoteDataSource.getReportOptions(type));

  @override
  Future<Either<Failure, ListPage<Post>>> fetchPaginatedPosts(
          int page, int limit) =>
      makeRequest(
          betticoslineRemoteDataSource.fetchPaginatedPosts(page, limit));

  @override
  Future<Either<Failure, List<Listing>>> fetchListings() => makeRequest(
        betticoslineRemoteDataSource.fetchListings(),
      );

  @override
  Future<Either<Failure, Listing>> getListing({required String symbol}) =>
      makeRequest(
        betticoslineRemoteDataSource.getListing(symbol: symbol),
      );
}
