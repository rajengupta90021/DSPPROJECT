import 'package:flutter/material.dart';
import '../Model/ChildMember.dart';
import '../repository/ChildMemberRepository.dart';

class ChildMemeberController extends ChangeNotifier {
  final ChildMemberRepository _repository = ChildMemberRepository();
  Stream<List<childmember>>? _childMembersStream;
  List<childmember> _childMembers = [];
  bool _isLoading = false;
  String _error = '';

  Stream<List<childmember>>? get childMembersStream => _childMembersStream;
  List<childmember> get childMembers => _childMembers;
  bool get isLoading => _isLoading;
  String get error => _error;

  void fetchChildMembers(String apiKey) {
    _isLoading = true;
    _error = '';
    _childMembersStream = _repository.getAllChildMembers(apiKey);

    _childMembersStream!.listen(
          (List<childmember> childMembers) {
        _childMembers = childMembers;
        _isLoading = false;
        _error = '';
        notifyListeners();
      },
      onError: (error) {
        _error = 'Failed to fetch child members: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

}
