import 'package:barcode/barcode.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/okx_swap/data/models/okx_address/okx_address.dart';
import 'package:betticos/features/okx_swap/presentation/getx/okx_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({Key? key, required this.address, this.isScreen = false})
      : super(key: key);

  final OkxAddress address;
  final bool? isScreen;

  @override
  State<AddressDetails> createState() => _ShareQRViewState();
}

class _ShareQRViewState extends State<AddressDetails> {
  static const double _boxHeight = 200;

  final OkxController controller = Get.find<OkxController>();

  @override
  Widget build(BuildContext context) {
    const Widget loadingBox =
        SizedBox(height: _boxHeight, child: LoadingLogo(color: Colors.white));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          if (widget.isScreen == false) ...<Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Ionicons.close_sharp,
                  size: 24,
                  color: context.colors.error,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
          if (widget.isScreen == true) ...<Widget>[
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Ionicons.close_sharp,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Deposit ${widget.address.currency.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          Align(
            alignment: Alignment.center,
            child: FutureBuilder<String>(
              future: generateQrCode(widget.address.address),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                final String? data = snapshot.data;
                if (data != null) {
                  return SvgPicture.string(
                    data,
                    height: _boxHeight,
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.color),
                  );
                }

                return loadingBox;
              },
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 290,
              child: Text(
                'Please send only ${widget.address.currency.toUpperCase()} to this deposit address. There might be loss of assets if you different token is sent.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: context.colors.text,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _WalletAddressRow(address: widget.address),
          const SizedBox(height: 16),
          if (widget.address.chain != null && widget.isScreen == true)
            InkWell(
              onTap: () {
                controller.setSelectedCurrency(widget.address.chain!);
                WidgetUtils.showChainModal(
                  context: context,
                  currencies: controller.getTokens(widget.address.currency),
                  controller: controller,
                  onTap: (Currency item) {
                    Navigator.of(context).pop();
                    controller.createOkxDepositAddress(
                      context,
                      item.currency,
                      item.chain!,
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.lightGrey,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _ChainWidget(chain: widget.address.chain!),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Ionicons.arrow_forward_sharp,
                      size: 30,
                      color: context.colors.lightGrey,
                    )
                  ],
                ),
              ),
            )
          else
            _ChainWidget(chain: widget.address.chain!),
        ],
      ),
    );
  }

  Future<String> generateQrCode(String data) async {
    const double size = _ShareQRViewState._boxHeight * 2;
    return Barcode.qrCode()
        .toSvg(data, width: size, height: size, color: 0x1F1056);
  }
}

class _ChainWidget extends StatelessWidget {
  const _ChainWidget({Key? key, required this.chain}) : super(key: key);
  final String chain;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Chain (Network)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.colors.text,
            fontSize: 14,
          ),
        ),
        Text(
          chain,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: context.colors.textDark,
          ),
        ),
      ],
    );
  }
}

class _WalletAddressRow extends StatelessWidget {
  const _WalletAddressRow({
    Key? key,
    required this.address,
  }) : super(key: key);

  final OkxAddress address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Wallet Address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.colors.text,
                  fontSize: 14,
                ),
              ),
              Text(
                address.address,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.colors.textDark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: address.address));

            AppSnacks.show(
              context,
              message: 'Address copied to clipboard',
              backgroundColor: context.colors.success,
              leadingIcon: const Icon(
                Ionicons.checkmark_circle_sharp,
                size: 20,
                color: Colors.white,
              ),
            );
          },
          icon: Image.asset(
            AssetImages.copyFile,
            height: 24,
            width: 24,
            color: const Color(0xFF999999),
          ),
        )
      ],
    );
  }
}
