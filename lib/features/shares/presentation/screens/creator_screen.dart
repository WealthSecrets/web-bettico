import 'package:betticos/core/core.dart';
import 'package:betticos/core/presentation/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatorScreen extends StatefulWidget {
  const CreatorScreen({super.key});

  @override
  State<CreatorScreen> createState() => _CreatorScreenState();
}

class _CreatorScreenState extends State<CreatorScreen> {
  WalletController controller = Get.find<WalletController>();
  @override
  void initState() {
    super.initState();
    controller.walletInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const _TopRow(),
            Divider(color: context.colors.faintGrey),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(child: _ClickCard()),
                  AppSpacing(h: 16),
                  Expanded(child: _ClickCard()),
                ],
              ),
            ),
            Divider(color: context.colors.faintGrey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _ColumnCard(
                  title: 'Deposit',
                  imagePath: AssetImages.deposit,
                ),
                _ColumnCard(
                  title: 'Withdraw',
                  imagePath: AssetImages.withdrawal,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppButton(
                padding: EdgeInsets.zero,
                borderRadius: AppBorderRadius.largeAll,
                backgroundColor: context.colors.primary,
                onPressed: () {},
                child: const Text(
                  'Export Private Key',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColumnCard extends StatelessWidget {
  const _ColumnCard({required this.title, required this.imagePath});
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconCard(
          imagePath: imagePath,
          backgroundColor: context.colors.text,
          color: context.colors.textDark,
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: context.caption.copyWith(
            color: context.colors.textDark,
          ),
        ),
      ],
    );
  }
}

class _ClickCard extends StatelessWidget {
  const _ClickCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: context.colors.faintGrey),
        borderRadius: AppBorderRadius.card,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '0.2490117 Eth',
            style: context.sub2.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
          ),
          Text(
            'Fees Earned',
            style: context.caption.copyWith(color: context.colors.text),
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                const Avatar(
                  imageUrl:
                      'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                ),
                const AppSpacing(h: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '@blanksonR',
                      style: context.caption.copyWith(color: context.colors.textDark, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0x42f....b624',
                      style: context.caption.copyWith(color: context.colors.text),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '0.2490117 Eth',
                  style: context.sub2.copyWith(color: context.colors.textDark),
                ),
                Text(
                  'Balance',
                  style: context.caption.copyWith(color: context.colors.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
