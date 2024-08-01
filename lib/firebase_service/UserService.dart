import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userCollection = 'User';

  // Create or update user
  Future<void> setUser(String userId, String name, String email, String profileUrl, String gender, String role) async {
    try {
      await _db.collection(userCollection).doc(userId).set({
        'name': name,
        'email': email,
        'profileUrl': profileUrl,
        'gender': gender,
        'createdAt': FieldValue.serverTimestamp(), // Automatically set the timestamp
        'role': role,
      });
      print('User created/updated successfully.');
    } catch (e) {
      print('Error setting user: $e');
    }
  }

  // Read user
  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection(userCollection).doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Update user
  Future<void> updateUser(String userId, {String? name, String? email, String? profileUrl, String? gender, String? role}) async {
    try {
      Map<String, dynamic> updateData = {};
      if (name != null) updateData['name'] = name;
      if (email != null) updateData['email'] = email;
      if (profileUrl != null) updateData['profileUrl'] = profileUrl;
      if (gender != null) updateData['gender'] = gender;
      if (role != null) updateData['role'] = role;

      await _db.collection(userCollection).doc(userId).update(updateData);
      print('User updated successfully.');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection(userCollection).doc(userId).delete();
      print('User deleted successfully.');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  // List all users
  Future<List<Map<String, dynamic>>> listUsers() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection(userCollection).get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error listing users: $e');
      return [];
    }
  }
}
