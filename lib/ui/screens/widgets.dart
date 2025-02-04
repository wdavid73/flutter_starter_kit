import 'package:flutter/material.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/widgets/widgets.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widgets"),
        actions: [
          Icon(Icons.favorite),
          Icon(Icons.settings),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 32),
        /*child: Text("Add"),*/
        /*label: Row(
          children: [
            Icon(Icons.add),
            Text("FAB"),
          ],
        ),*/
      ),
      drawer: _Drawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Translate: ${context.translate('sign_up')}",
                ),
                _IconsWidget(),
                const Divider(),
                _ChipWidget(),
                const Divider(),
                Text("Textos"),
                _TextsStyles(),
                const Divider(),
                Text("Botones"),
                _ButtonsWidgets(),
                const Divider(),
                Text("SnackBar"),
                FilledButton(
                  onPressed: () {
                    CustomSnackBar.showSnackBar(
                      context,
                      message: "Hello World!",
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {},
                      ),
                    );
                  },
                  child: Text("Show SnackBar"),
                ),
                const Divider(),
                Text("Progress Indicators"),
                CircularProgressIndicator(),
                const SizedBox(height: 10),
                LinearProgressIndicator(),
                const Divider(),
                Text("BottomSheet"),
                _BottomSheet(),
                const Divider(),
                Text("Switch"),
                Row(
                  children: [
                    Switch(value: false, onChanged: (val) {}),
                    Switch(value: true, onChanged: (val) {}),
                  ],
                ),
                const Divider(),
                Text("Radio"),
                _RadioWidget(),
                const Divider(),
                Text("Checkbox"),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (val) {}),
                    Checkbox(value: true, onChanged: (val) {}),
                  ],
                ),
                const Divider(),
                Text("Checkbox"),
                _InputsWidget(),

                // END
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioWidget extends StatelessWidget {
  const _RadioWidget({
    super.key,
  });

  final bool groupValue = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: false,
          groupValue: groupValue,
          onChanged: (val) {},
        ),
        Radio(
          value: true,
          groupValue: groupValue,
          onChanged: (val) {},
        ),
      ],
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              width: 450,
              height: 250,
              child: Center(
                child: Text(
                  "Bottom Sheet",
                ),
              ),
            );
          },
        );
      },
      child: Text("Show BottomSheet"),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Text("Drawer Title"),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Disable"),
              subtitle: Text("SubTitle"),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Enable"),
              subtitle: Text("SubTitle"),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              title: Text("Selected"),
              selected: true,
            ),
            ListTile(
              title: Text("Selected with icons"),
              leading: Icon(Icons.add),
              trailing: Icon(Icons.adaptive.arrow_forward),
              selected: true,
            ),
            ListTile(title: Text("Item 5")),
            ListTile(title: Text("Item 6")),
          ],
        ),
      ),
    );
  }
}

class _IconsWidget extends StatelessWidget {
  const _IconsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Icons",
          style: AppTypography.getSemiBoldStyle(fontSize: 16),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Icon(Icons.favorite),
            Icon(Icons.linked_camera),
            Icon(Icons.add),
          ],
        ),
      ],
    );
  }
}

class _ChipWidget extends StatelessWidget {
  const _ChipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Chip Widget"),
        Row(
          spacing: 10,
          children: [
            Chip(label: Text("Chip #1")),
            Chip(label: Text("Chip #2")),
            Chip(label: Text("Chip #3")),
          ],
        ),
      ],
    );
  }
}

class _TextsStyles extends StatelessWidget {
  const _TextsStyles({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final textTheme = brightness == Brightness.light
        ? AppTheme.getTheme().textTheme
        : AppTheme.getDarkTheme().textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('displayLarge', style: textTheme.displayLarge),
        Text('displayMedium', style: textTheme.displayMedium),
        Text('displaySmall', style: textTheme.displaySmall),
        Text('headlineLarge', style: textTheme.headlineLarge),
        Text('headlineMedium', style: textTheme.headlineMedium),
        Text('headlineSmall', style: textTheme.headlineSmall),
        Text('titleLarge', style: textTheme.titleLarge),
        Text('titleMedium', style: textTheme.titleMedium),
        Text('titleSmall', style: textTheme.titleSmall),
        Text('bodyLarge', style: textTheme.bodyLarge),
        Text('bodyMedium', style: textTheme.bodyMedium),
        Text('bodySmall', style: textTheme.bodySmall),
        Text('labelLarge', style: textTheme.labelLarge),
        Text('labelMedium', style: textTheme.labelMedium),
        Text('labelSmall', style: textTheme.labelSmall),
      ]
          .map(
            (widget) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: widget,
            ),
          )
          .toList(),
    );
  }
}

class _ButtonsWidgets extends StatelessWidget {
  const _ButtonsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("ElevatedButton:"),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {},
              child: Text("Press me!"),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("TextButton:"),
            const SizedBox(width: 50),
            TextButton(onPressed: () {}, child: Text("Press me!")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("OutlinedButton:"),
            const SizedBox(width: 50),
            OutlinedButton(onPressed: () {}, child: Text("Press me!")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("FilledButton:"),
            const SizedBox(width: 50),
            FilledButton(onPressed: () {}, child: Text("Press me!")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Icon Button:"),
            const SizedBox(width: 50),
            IconButton(onPressed: () {}, icon: Icon(Icons.adb)),
          ],
        ),
      ],
    );
  }
}

class _InputsWidget extends StatelessWidget {
  const _InputsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: responsive.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Text:"),
              const SizedBox(width: 50),
              Expanded(
                child: CustomTextFormField(
                  label: "Text",
                  hint: "Hint",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Text disable:"),
              const SizedBox(width: 50),
              Expanded(
                child: CustomTextFormField(
                  label: "Text",
                  hint: "Hint",
                  enabled: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Number:"),
              const SizedBox(width: 50),
              Expanded(
                child: CustomTextFormField(
                  label: "Number with error",
                  hint: "Hint",
                  errorMessage: "Error Message",
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Password:"),
              const SizedBox(width: 50),
              Expanded(
                child: CustomTextFormField(
                  label: "Password",
                  hint: "Hint",
                  obscureText: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}