class Shared {
  static dynamic getNestedValue(Map<String, dynamic> data, List<String> path) {
    dynamic result = data;
    for(var key in path) {
      if(result is Map<String, dynamic> && result.containsKey(key)) {
        result = result[key];
      } else {
        result = null;
      }
    }

    return result;
  }
}