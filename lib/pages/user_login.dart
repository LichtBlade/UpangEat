import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upang_eat/Pages/home.dart';
import 'package:upang_eat/main.dart';
import 'package:upang_eat/pages/admin_pages/admin_dashboard.dart';
import 'package:upang_eat/pages/seller_center/seller_center.dart';
import 'package:upang_eat/pages/slideshow.dart';
import 'package:upang_eat/user_data.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import '../bloc/login_bloc/login_bloc.dart';
import 'package:http/http.dart' as http;

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    context.read<LoginBloc>().add(RemoveUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is UserLoading) {
              print("UserLoading");
            } else if (state is UserLoaded) {
              print("Loaded");
              globalUserData = state.user;
              print(globalUserData);
            }
            if (state is LoginLoading) {
              print("Loading");
              isLoading = true;
            } else if (state is LoginSuccess) {
              // Create Web3 client
              print("Success");
              isLoading = false;
              if (state.userType == 'admin') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const AdminDashboard()),
                );
              } else if (state.userType == 'stall_owner') {
                String globalSelletWallet =
                    '0xcd72e17e23b55819612cb4a79fd1eb3634802c28d912c6c76c612e65cc550827';
                globalPrivateKey = globalSelletWallet;
                _fetchWalletGanche(globalPrivateKey);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SellerCenter()),
                );
              } else {
                String globalUserWallet =
                    '0x8e32f7442f65bdb5ea7fe253af3bbc284faaeca10d2634a495b48a0ab2d9ee1d';
                globalPrivateKey = globalUserWallet;
                _fetchWalletGanche(globalPrivateKey);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SlideshowScreen()),
                );
              }
            } else if (state is LoginFailed) {
              print(state.error);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Failed: ${state.error}')),
              );
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/upang.jpg',
                  fit: BoxFit.cover,
                  color: Color(0xFF9A140A).withOpacity(0.5),
                  colorBlendMode: BlendMode.luminosity,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,  // More than half of the screen
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Image(
                          image: AssetImage("assets/upangeats.png"),
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginButtonPressed(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3A3A3A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Loader if isLoading is true
              if (isLoading)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: Container(
                    color: Colors.black54,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchWalletGanche(String privateKey) async {
    String rpcUrl = IpAddress.rpGanacheUrl; // For Android emulator
    String wsUrl = IpAddress.wsGanacheUrl;

    Web3Client client = Web3Client(
      rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(wsUrl).cast<String>();
      },
    );

    // Obtain credentials from private key
    Credentials credentials =
    await client.credentialsFromPrivateKey(privateKey);

    // Get your Ethereum address from the credentials
    EthereumAddress ownAddress = await credentials.extractAddress();

    // Fetch balance
    EtherAmount balance = await client.getBalance(ownAddress);

    globalEthBalance = balance.getValueInUnit(EtherUnit.ether);
    globalWalletEthAddress = ownAddress.toString();
    print(globalWalletEthAddress); // Convert balance to ETH
  }
}