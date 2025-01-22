import 'package:courier_app/features/account/widgets/invitation_code.dart';
import 'package:courier_app/features/account/widgets/logout.dart';
import 'package:courier_app/features/account/widgets/my_userInfo.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      includeAppBar: false,
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          MyUserInfo(),
          InvitationCode(),
          Logout(),
        ],
      ),
    );
  }
}
