// import 'package:dartz/dartz.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '/core/core.dart';
// import '/features/betticos/data/models/post/post_model.dart';
// import '/features/betticos/domain/usecases/subscription/fetch_subscribed_oddboxes.dart';

// class OddboxController extends GetxController {
//   OddboxController({required this.fetchSubscribedOddboxes});

//   final FetchSubscribedOddboxes fetchSubscribedOddboxes;

//   RxList<Post> oddboxes = <Post>[].obs;
//   RxBool isLoading = false.obs;

//   void getAllSubscribedOddboxes(BuildContext context) async {
//     isLoading(true);

//     final Either<Failure, List<Post>> failureOrOddboxes =
//         await fetchSubscribedOddboxes(NoParams());

//     failureOrOddboxes.fold<void>(
//       (Failure failure) {
//         isLoading(false);
//         AppSnacks.show(context, message: failure.message);
//       },
//       (List<Post> value) {
//         isLoading(false);
//         oddboxes(value);
//       },
//     );
//   }
// }
