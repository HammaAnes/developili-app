int? getUserId(String? id) {
  if (id == null || id.isEmpty) {
    return null;
  }
  try {
    return int.parse(id);
  } catch (e) {
    return null; // Return null if parsing fails
  }
}

