import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/storage_mode_provider.dart';

class CustomDrawer extends StatelessWidget {
  final String buttonTitle;
  final Icon icon;
  final VoidCallback callback;

  const CustomDrawer(this.buttonTitle, this.icon, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    final storageModeProvider = Provider.of<StorageModeProvider>(context);
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            "Navigation Menu",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/insat.jpg",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // First option: Navigation type
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  icon.icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  buttonTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: callback,
                tileColor: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // Second option: Storage mode switch
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.cloud_sync,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(storageModeProvider.mode == StorageMode.cloud ? 'Online Mode' : 'Offline Mode'),
                trailing: Switch(
                  value: storageModeProvider.mode == StorageMode.cloud,
                  onChanged: (val) {
                    storageModeProvider.setMode(
                      val ? StorageMode.cloud : StorageMode.offline,
                    );
                  },
                ),
                tileColor: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
