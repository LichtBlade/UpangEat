import 'package:flutter/cupertino.dart';

class TokenCard extends StatelessWidget {
  final String tokenImage;
  final String tokenName;
  final String tokenAmount;
  final String tokenChange;

  const TokenCard({
    Key? key,
    required this.tokenImage,
    required this.tokenName,
    required this.tokenAmount,
    required this.tokenChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            tokenImage,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 10),
          Text(
            tokenName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  tokenAmount,
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.black,
                  ),
                ),
                Text(
                  tokenChange,
                  style: TextStyle(
                    fontSize: 16,
                    color: tokenChange.startsWith('+')
                        ? CupertinoColors.systemGreen
                        : CupertinoColors.systemRed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
