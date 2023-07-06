import 'package:betticos/features/okx_swap/data/models/okx_address/okx_address.dart';
import 'package:betticos/features/okx_swap/presentation/address/widgets/address_details.dart';
import 'package:flutter/material.dart';

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
