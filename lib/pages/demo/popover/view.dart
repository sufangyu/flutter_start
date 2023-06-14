import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DemoPopoverPage extends GetView<DemoPopoverController> {
  const DemoPopoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('气泡弹窗'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                  Button(
                    onTap: (ctx) => controller.showPopoverWindow(
                      context: ctx,
                      body: const ListItems(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key, this.onTap}) : super(key: key);

  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(context);
        }
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: const Center(child: Text('Click Me')),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
            },
            child: Container(
              height: 40,
              color: Colors.amber[100],
              child: const Center(child: Text('Entry A')),
            ),
          ),
          const Divider(),
          Container(
            height: 40,
            color: Colors.amber[200],
            child: const Center(child: Text('Entry B')),
          ),
          const Divider(),
          Container(
            height: 40,
            color: Colors.amber[300],
            child: const Center(child: Text('Entry C')),
          ),
          const Divider(),
          Container(
            height: 40,
            color: Colors.amber[400],
            child: const Center(child: Text('Entry D')),
          ),
          const Divider(),
          Container(
            height: 40,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry E')),
          ),
          const Divider(),
          Container(
            height: 40,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry F')),
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back'),
        ),
      ),
    );
  }
}
