import 'dart:io';

import 'package:course_scheduling/core/theme/app_pallet.dart';
import 'package:course_scheduling/features/resources/presentation/bloc/resource_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcePage extends StatefulWidget {
  final int courseId;
  final int sectionId;
  final String userId;
  final String userRole; // 'student' or 'lecturer'

  const ResourcePage({
    super.key,
    required this.courseId,
    required this.sectionId,
    required this.userId,
    required this.userRole,
  });

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  void initState() {
    super.initState();
    context.read<ResourceBloc>().add(
          LoadResources(
            courseId: widget.courseId,
            sectionId: widget.sectionId,
          ),
        );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        actions: [
          if (widget.userRole == 'lecturer')
            IconButton(
              icon: const Icon(Icons.upload_file),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  final file = File(result.files.single.path!);
                  final fileName = result.files.single.name;

                  // Show dialog to enter description
                  if (context.mounted) {
                    final descriptionController = TextEditingController();
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Upload Resource'),
                        content: TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(hintText: 'Description'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<ResourceBloc>().add(
                                    UploadResourceEvent(
                                      courseId: widget.courseId,
                                      sectionId: widget.sectionId,
                                      uploadedBy: widget.userId,
                                      file: file,
                                      fileName: fileName,
                                      description: descriptionController.text,
                                    ),
                                  );
                            },
                            child: const Text('Upload'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
        ],
      ),
      body: BlocConsumer<ResourceBloc, ResourceState>(
        listener: (context, state) {
           if (state is ResourcesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ResourcesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ResourcesLoaded) {
             if (state.resources.isEmpty) {
              return const Center(child: Text('No resources available.'));
            }
            return ListView.builder(
              itemCount: state.resources.length,
              itemBuilder: (context, index) {
                final resource = state.resources[index];
                return ListTile(
                  leading: const Icon(Icons.description, color: AppPallete.gradient2),
                  title: Text(resource.fileName),
                  subtitle: Text(resource.description ?? 'No description'),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => _launchUrl(resource.fileUrl),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
