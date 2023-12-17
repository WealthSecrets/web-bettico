import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:betticos/features/shares/presentation/widgets/sales_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sale_details_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final WalletController walletController = Get.find<WalletController>();

  @override
  void initState() {
    walletController.walletInit((String wallet) {
      walletController.getAllSales();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: walletController.isLoading.value,
          child: Column(
            children: <Widget>[
              if (!isSmallScreen) const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Sales',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.colors.textDark),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const AppSpacing(h: 16),
                  Avatar(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.creator),
                    size: 30,
                    imageUrl:
                        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  ),
                ],
              ),
              const AppSpacing(v: 16),
              Expanded(
                child: walletController.sales.isEmpty
                    ? const AppEmptyScreen(
                        message: 'There are no active sales at the moment',
                        title: 'Sorry, Nothing Found',
                      )
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final dynamic value = walletController.sales[index];
                          return SalesCard(
                            value: value,
                            onPressed: () => Navigator.of(context).pushNamed(
                              AppRoutes.saleDetails,
                              arguments: SaleDetailsScreenRouteArgument(value: value),
                            ),
                          );
                        },
                        itemCount: walletController.sales.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
