import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PresenceScreen extends HookWidget {
  const PresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hooks for state management
    final imageFile = useState<File?>(null);
    final isLoading = useState<bool>(false);
    final selectedType = useState<String?>(null);

    // Image picker instance
    final picker = useMemoized(() => ImagePicker(), []);

    // Take picture function
    final takePicture = useCallback(() async {
      try {
        final XFile? image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 70,
          preferredCameraDevice: CameraDevice.front,
        );

        if (image != null) {
          imageFile.value = File(image.path);
        }
      } catch (e) {
        if (context.mounted) {
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text('Error taking picture: $e')));
        }
      }
    }, [picker]);

    // Submit presence function
    final submitPresence = useCallback(() async {
      if (imageFile.value == null || selectedType.value == null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Please take a photo and select presence type'),
        //   ),
        // );
        return;
      }

      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      if (context.mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       '${selectedType.value} presence recorded successfully!',
        //     ),
        //     backgroundColor: Colors.green,
        //   ),
        // );

        // Reset form
        imageFile.value = null;
        selectedType.value = null;
      }
    }, [imageFile.value, selectedType.value]);

    final FColors colors = context.theme.colors;

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Attendance'),
        prefixes: [FHeaderAction.back(onPress: () => context.pop())],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            FCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(FIcons.timer, size: 48, color: colors.primary),
                    const SizedBox(height: 8),
                    Text(
                      'Mark Your Attendance',
                      // style: Theme.of(context).textTheme.headlineSmall
                      //     ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateTime.now().toString().substring(0, 19),
                      // style: Theme.of(
                      //   context,
                      // ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Photo Section
            Text(
              'Take Your Photo',
              // style: Theme.of(
              //   context,
              // ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            FCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (imageFile.value != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          imageFile.value!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ] else ...[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          // color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          // border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FIcons.camera,
                              size: 48,
                              color: colors.secondary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No photo taken',
                              style: TextStyle(
                                color: colors.secondary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    SizedBox(
                      width: double.infinity,
                      child: FButton(
                        onPress: takePicture,
                        style: FButtonStyle.outline(),
                        child: Text(
                          imageFile.value != null
                              ? 'Retake Photo'
                              : 'Take Photo',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Presence Type Selection
            Text(
              'Presence Type',
              // style: Theme.of(
              //   context,
              // ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // FCard(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Column(
            //       children: [
            //         RadioListTile<String>(
            //           title: const Text('Check In'),
            //           subtitle: const Text('Mark your arrival'),
            //           value: 'Check In',
            //           groupValue: selectedType.value,
            //           onChanged: (value) {
            //             selectedType.value = value;
            //           },
            //         ),
            //         RadioListTile<String>(
            //           title: const Text('Check Out'),
            //           subtitle: const Text('Mark your departure'),
            //           value: 'Check Out',
            //           groupValue: selectedType.value,
            //           onChanged: (value) {
            //             selectedType.value = value;
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              height: 50,
              child: FButton(
                onPress: isLoading.value ? null : submitPresence,
                child: isLoading.value
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: FProgress.circularIcon(),
                            // child: CircularProgressIndicator(
                            //   strokeWidth: 2,
                            //   color: Colors.white,
                            // ),
                          ),
                          SizedBox(width: 8),
                          Text('Recording...'),
                        ],
                      )
                    : const Text('Record Attendance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
