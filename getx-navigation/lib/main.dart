import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_sample/base_sample.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/list',
    getPages: [
      GetPage(name: '/list', page: () => const List()),
      GetPage(name: '/details/:title', page: () => Details()),
      GetPage(
          name: '/detailsTransition/:title',
          page: () => Details(),
          customTransition: SlideInOutVerticalTransition()),
    ],
    customTransition: SlideInOutHorizontalTransition(),
  ));
}

class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Named-Route with parameter and argument'),
            subtitle: const Text(
                "Get.toNamed('/details/Named-Route', arguments: User('Lukas', 'Vetter', 29))"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.toNamed(
              '/details/Named-Route',
              arguments: User('Lukas', 'Vetter', 29),
            ),
          ),
          ListTile(
            title: const Text('Dynamic-Route with parameter and argument'),
            subtitle: const Text(
                "Get.to(() => Details(title: 'Dynamic-Route'), arguments: User('Lukas', 'Vetter', 29))"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.to(
              () => Details(title: 'Dynamic-Route'),
              arguments: User('Lukas', 'Vetter', 29),
            ),
          ),
          ListTile(
            title: const Text('Named-Route with custom transition on route'),
            subtitle: const Text(
                "Get.toNamed('/detailsTransition/Vertical-Transition', arguments: User('Lukas', 'Vetter', 29))"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.toNamed(
              '/detailsTransition/Vertical-Transition',
              arguments: User('Lukas', 'Vetter', 29),
            ),
          ),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  Details({Key? key, String? title, User? user})
      : title = title ?? Get.parameters['title'] ?? '',
        user = user ?? Get.arguments,
        super(key: key);

  final String title;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: UserWidget(user: user),
    );
  }
}

class SlideInOutHorizontalTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
}

class SlideInOutVerticalTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, -1.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
}
