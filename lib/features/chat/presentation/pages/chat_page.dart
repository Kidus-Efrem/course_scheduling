import 'package:course_scheduling/core/theme/app_pallet.dart';
import 'package:course_scheduling/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final int courseId;
  final int sectionId;
  final String userId;
  final bool isLecturer;

  const ChatPage({
    super.key,
    required this.courseId,
    required this.sectionId,
    required this.userId,
    this.isLecturer = false,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(
          EnterChatRoom(
            courseId: widget.courseId,
            sectionId: widget.sectionId,
          ),
        );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Chat'),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatRoomReady) {
            final messages = state.messages;
            return Column(
              children: [
                Expanded(
                  child: messages.isEmpty
                      ? const Center(child: Text('No messages yet'))
                      : ListView.builder(
                          reverse: true, // Usually chats are reversed, but Supabase order is asc. We need to handle this.
                          // If remote data source orders by created_at asc, then last item is newest.
                          // For reverse listview, index 0 is bottom.
                          // So we should reverse the list or use reversed ordering in query.
                          // Let's check datasource: .order('created_at') (default asc).
                          // So index 0 is oldest.
                          // In UI, we usually want bottom-aligned.
                          // Let's reverse the list here for display if we want newest at bottom.
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            // Stream is now Newest -> Oldest calls.
                            // reverse: true builds from bottom.
                            // Index 0 (Bottom) = messages[0] (Newest).
                            // This puts Newest at Bottom.
                            final message = messages[index];
                            final isMe = message.senderId == widget.userId;
                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? (widget.isLecturer ? const Color(0xFF00C853) : AppPallete.gradient2)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isMe) ...[
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            message.senderName ?? 'Unknown',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _formatTime(message.createdAt),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            message.messageText,
                                            style: TextStyle(
                                              color: isMe ? Colors.white : Colors.black,
                                            ),
                                          ),
                                        ),
                                        if (isMe) ...[
                                          const SizedBox(width: 8),
                                          Text(
                                            _formatTime(message.createdAt),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isMe ? Colors.white70 : Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (_messageController.text.trim().isNotEmpty) {
                            context.read<ChatBloc>().add(
                                  SendMessage(
                                    chatRoomId: state.chatRoomId,
                                    messageText: _messageController.text.trim(),
                                    senderId: widget.userId,
                                  ),
                                );
                            _messageController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Initializing chat...'));
        },
      ),
    );
  }
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
