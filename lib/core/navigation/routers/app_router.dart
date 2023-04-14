import 'package:betticos/core/navigation/route_animations/fade_in.dart';
import 'package:betticos/core/presentation/widgets/app_web_view.dart';
import 'package:betticos/core/presentation/widgets/success_screen.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/explore_container.dart';
import 'package:betticos/features/betticos/presentation/explore/widgets/search_container.dart';
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
import '../app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return FadeInRoute<void>(
      builder: (BuildContext context) {
        return _widgetBuilder(settings, context);
      },
    );
  }

  static Widget _widgetBuilder(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AppRoutes.profile:
        return const ProfileScreen();
      case AppRoutes.members:
        return const MembersScreen();
      case AppRoutes.oddsters:
        return const OddstersScreen();
      case AppRoutes.oddboxes:
        return const OddsboxScreen();
      case AppRoutes.settings:
        return const SettingsScreen();
      case AppRoutes.livescore:
        return const NewLiveScore();
      case AppRoutes.timeline:
        return const TimelineScreen();
      case AppRoutes.referral:
        return const ReferralScreen();
      case AppRoutes.convertCrypto:
        return const ConvertCryptoScreen();
      case AppRoutes.okxOptions:
        return const CryptoFrontScreen();
      case AppRoutes.buySellCrypto:
        return const BuySellCryptoScreen();
      case AppRoutes.walletAddresses:
        return const AddressesScreen();
      case AppRoutes.currencies:
        return const AssetCurrenciesScreen();
      case AppRoutes.addressDetails:
        return const AddressDetailsScreen();
      case AppRoutes.depositHistory:
        return const DepositHistoryScreen();
      case AppRoutes.conversionSuccess:
        return ConversionSuccessScreen();
      case AppRoutes.conversionHistory:
        return const CovnersionHistoryScreen();
      case AppRoutes.moreScreen:
        return const MoreScreen();
      case AppRoutes.privateSales:
        return const PrivateSale();
      case AppRoutes.saleSuccess:
        return PrivateSaleCongratulationScreen();
      case AppRoutes.transactions:
        return const TransactionHistoryScreen();
      case AppRoutes.withdrawal:
        return const WithdrawalScreen();
      case AppRoutes.withdrawalHistory:
        return const WithdrawalHistoryScreen();
      case AppRoutes.withdrawalSuccess:
        return WithdrawalCongratulationsScreen();
      case AppRoutes.transferFunds:
        return const TransferFundsScreen();
      case AppRoutes.success:
        return const SucessScreen();
      case AppRoutes.transferHistory:
        return const TransferHistoryScreen();
      case AppRoutes.send:
        return const SendScreen();
      case AppRoutes.appwebview:
        return const AppWebView();
      case AppRoutes.explore:
        return ExploreContainer();
      case AppRoutes.search:
        return SearchContainer();
      default:
        return const NotFoundScreen();
    }
  }
}
