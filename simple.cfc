component output="false"  implements="bluejay.iRoute" extends="bluejay.baseRoute" {

  variables.route = "simple/";
  variables.name = "Please update name";
  variables.description = "Please update Description";
  variables.version = "0.0.1";

  public function handler() {
    return "Just return simple data";
  }

}