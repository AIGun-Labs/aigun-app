enum RequestMethods {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE");

  const RequestMethods(this.value);
  final String value;
}
