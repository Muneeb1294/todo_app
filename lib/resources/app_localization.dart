class LocalizationMap {
  static Map<String, String> get codesEN => {
  "field_required":"Field required",
  "press_again_to_exit":"press again to exit",
  "connection_restored":"Connection Restored",
  "no_internet_connection":"No Internet Connection",
  "retry":"Retry",
  "ok":"Ok",
  "oops":"Oops",
  "something_went_wrong":"Something went wrong",
  "uh_oh":"Uh Oh!",
  "todos":"Todos",
  "your_todos":"Your Todos",
  "add_todo":"Add Todo",
  "save":"Save",
  "enter_title":"enter title",
  "title":"Title",
  "description":"Description",
  "enter_description":"enter description",
  };

  static String getValue(String key) {
    return codesEN[key] ?? "Text not found";
  }
}
