import 'package:betticos/core/presentation/widgets/app_web_view.dart';
import 'package:betticos/core/presentation/widgets/success_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/explore_container.dart';
import 'package:betticos/features/betticos/presentation/members/screens/members_screen.dart';
import 'package:betticos/features/betticos/presentation/oddsters/screens/oddsters_screen.dart';
import 'package:betticos/features/betticos/presentation/private_sales/private_sale_congratulation_screen.dart';
import 'package:betticos/features/betticos/presentation/private_sales/private_sales_screen.dart';
import 'package:betticos/features/betticos/presentation/referral/screens/referral_screen.dart';
import 'package:betticos/features/betticos/presentation/timeline/screens/timeline_screen.dart';
import 'package:betticos/features/okx_swap/presentation/address/address_details_screen.dart';
import 'package:betticos/features/okx_swap/presentation/address/addresses_screen.dart';
import 'package:betticos/features/okx_swap/presentation/address/asset_currencies_screen.dart';
import 'package:betticos/features/okx_swap/presentation/convert/screens/conversion_success_screen.dart';
import 'package:betticos/features/okx_swap/presentation/convert/screens/convert_crypto_screen.dart';
import 'package:betticos/features/okx_swap/presentation/crypto/buy_sell_crypto_screen.dart';
import 'package:betticos/features/okx_swap/presentation/crypto/crypto_front_screen.dart';
import 'package:betticos/features/okx_swap/presentation/crypto/send_screen.dart';
import 'package:betticos/features/okx_swap/presentation/funds/screens/transfer_funds.dart';
import 'package:betticos/features/okx_swap/presentation/funds/screens/transfer_history_screen.dart';
import 'package:betticos/features/okx_swap/presentation/history/conversion_history_screen.dart';
import 'package:betticos/features/okx_swap/presentation/history/deposit_history_screen.dart';
import 'package:betticos/features/okx_swap/presentation/history/withdrawal_history_screen.dart';
import 'package:betticos/features/okx_swap/presentation/more/more_screen.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/screens/withdrawal_congratulations_screen.dart';
import 'package:betticos/features/okx_swap/presentation/withdrawal/screens/withdrawal_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/screens/new_livescore_screen.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/screens/p2p_transaction_history_screen.dart';
import 'package:betticos/features/responsiveness/not_found_screen.dart';
import 'package:flutter/material.dart';
import '../../../features/betticos/presentation/oddsbox/screens/oddsbox_screen.dart';
import '../../../features/betticos/presentation/profile/screens/profile_screen.dart';
import '../../../features/settings/presentation/settings/screens/settings_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.profile:
      return _getPageRoute(const ProfileScreen(), settings);
    case AppRoutes.members:
      return _getPageRoute(const MembersScreen(), settings);
    case AppRoutes.oddsters:
      return _getPageRoute(const OddstersScreen(), settings);
    case AppRoutes.oddboxes:
      return _getPageRoute(const OddsboxScreen(), settings);
    case AppRoutes.settings:
      return _getPageRoute(const SettingsScreen(), settings);
    case AppRoutes.livescore:
      return _getPageRoute(const NewLiveScore(), settings);
    case AppRoutes.timeline:
      return _getPageRoute(const TimelineScreen(), settings);
    case AppRoutes.referral:
      return _getPageRoute(const ReferralScreen(), settings);
    case AppRoutes.convertCrypto:
      return _getPageRoute(const ConvertCryptoScreen(), settings);
    case AppRoutes.okxOptions:
      return _getPageRoute(const CryptoFrontScreen(), settings);
    case AppRoutes.buySellCrypto:
      return _getPageRoute(const BuySellCryptoScreen(), settings);
    case AppRoutes.walletAddresses:
      return _getPageRoute(const AddressesScreen(), settings);
    case AppRoutes.currencies:
      return _getPageRoute(const AssetCurrenciesScreen(), settings);
    case AppRoutes.addressDetails:
      return _getPageRoute(const AddressDetailsScreen(), settings);
    case AppRoutes.depositHistory:
      return _getPageRoute(const DepositHistoryScreen(), settings);
    case AppRoutes.conversionSuccess:
      return _getPageRoute(ConversionSuccessScreen(), settings);
    case AppRoutes.conversionHistory:
      return _getPageRoute(const CovnersionHistoryScreen(), settings);
    case AppRoutes.moreScreen:
      return _getPageRoute(const MoreScreen(), settings);
    case AppRoutes.privateSales:
      return _getPageRoute(const PrivateSale(), settings);
    case AppRoutes.saleSuccess:
      return _getPageRoute(PrivateSaleCongratulationScreen(), settings);
    case AppRoutes.transactions:
      return _getPageRoute(const TransactionHistoryScreen(), settings);
    case AppRoutes.withdrawal:
      return _getPageRoute(const WithdrawalScreen(), settings);
    case AppRoutes.withdrawalHistory:
      return _getPageRoute(const WithdrawalHistoryScreen(), settings);
    case AppRoutes.withdrawalSuccess:
      return _getPageRoute(WithdrawalCongratulationsScreen(), settings);
    case AppRoutes.transferFunds:
      return _getPageRoute(const TransferFundsScreen(), settings);
    case AppRoutes.success:
      return _getPageRoute(const SucessScreen(), settings);
    case AppRoutes.transferHistory:
      return _getPageRoute(const TransferHistoryScreen(), settings);
    case AppRoutes.send:
      return _getPageRoute(const SendScreen(), settings);
    case AppRoutes.appwebview:
      return _getPageRoute(const AppWebView(), settings);
    case AppRoutes.explore:
      return _getPageRoute(ExploreContainer(), settings);

    default:
      return _getPageRoute(const NotFoundScreen(), settings);
  }
}

PageRoute<Widget> _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, settings: settings);
}

class _FadeRoute extends PageRouteBuilder<Widget> {
  _FadeRoute({required this.child, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
  final Widget child;
  @override
  final RouteSettings settings;
}
