import 'package:betticos/features/data.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class AddressDetailsScreenRouteArgument {
  const AddressDetailsScreenRouteArgument({this.address});

  final OkxAddress? address;
}

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressDetailsScreenRouteArgument? args =
        ModalRoute.of(context)!.settings.arguments as AddressDetailsScreenRouteArgument?;
    return Scaffold(body: AddressDetails(address: args!.address!, isScreen: true));
  }
}
