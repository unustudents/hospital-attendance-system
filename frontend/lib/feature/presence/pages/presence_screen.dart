import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PresenceScreen extends HookWidget {
  const PresenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // State for captured image
    final imageFile = useState<File?>(null);
    final isLoading = useState<bool>(false);

    // Image picker instance
    final picker = useMemoized(() => ImagePicker(), []);

    // Take selfie function
    final takeSelfie = useCallback(() async {
      try {
        final XFile? image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          preferredCameraDevice: CameraDevice.front, // Front camera for selfie
        );

        if (image != null) {
          imageFile.value = File(image.path);
        }
      } catch (e) {
        if (context.mounted) {
          // Show error dialog using Forui
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return FDialog(
                title: const Text('Error'),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: context.theme.colors.destructive,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error taking selfie: $e',
                      style: context.theme.typography.sm,
                    ),
                  ],
                ),
                actions: [
                  FButton(
                    onPress: () => context.pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }, [picker]);

    // Confirm selfie function
    final confirmSelfie = useCallback(() async {
      if (imageFile.value == null) return;

      isLoading.value = true;

      // Show loading dialog using Forui
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return FDialog(
              title: const Text('Confirming Selfie'),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FProgress(value: null), // Indeterminate progress
                  const SizedBox(height: 16),
                  Text(
                    'Please wait while we verify your selfie...',
                    style: context.theme.typography.sm,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: const [], // Empty actions for loading dialog
            );
          },
        );
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        // Show success dialog using Forui
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return FDialog(
              title: const Text('Success!'),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: context.theme.colors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Selfie confirmed successfully!',
                    style: context.theme.typography.sm,
                  ),
                ],
              ),
              actions: [
                FButton(
                  onPress: () {
                    context.pop(); // Close dialog
                    context.pop(); // Navigate back
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }, [imageFile.value]);

    // Retake selfie function
    final retakeSelfie = useCallback(() async {
      // Reset image first
      imageFile.value = null;

      // Call existing takeSelfie function
      await takeSelfie();
    }, [takeSelfie]);

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Ambil Gambar'),
        prefixes: [
          FHeaderAction.back(
            onPress: () => context.pop(),
            onHoverChange: (hovered) {},
            onStateChange: (delta) {},
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Title
            Text(
              'Take a Selfie',
              style: context.theme.typography.xl.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Please take a clear selfie for verification',
              style: context.theme.typography.sm.copyWith(
                color: context.theme.colors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Camera/Photo Preview Area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.theme.colors.border,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: context.theme.colors.background,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageFile.value != null
                      ? Image.file(
                          imageFile.value!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: context.theme.colors.muted,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FIcons.camera,
                                size: 80,
                                color: context.theme.colors.mutedForeground,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Tap the camera button to\ntake a selfie',
                                style: context.theme.typography.sm.copyWith(
                                  color: context.theme.colors.mutedForeground,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            if (imageFile.value == null) ...[
              // Take Selfie Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FButton(
                  onPress: takeSelfie,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FIcons.camera, size: 20),
                      SizedBox(width: 8),
                      Text('Take Selfie'),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // Confirmation Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FButton(
                        onPress: retakeSelfie,
                        style: FButtonStyle.outline(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FIcons.refreshCw, size: 20),
                            SizedBox(width: 8),
                            Text('Retake'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FButton(
                        onPress: isLoading.value ? null : confirmSelfie,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FIcons.check, size: 20),
                            SizedBox(width: 8),
                            Text('Confirm'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
