component output="false" implements="bluejay.iRoute" extends="bluejay.baseRoute" {
/*
  This is a test for matching wildcards.
*/

  variables.route = "struct/%theMatch%";
  variables.name = "Please update name";
  variables.description = "Please update Description";
  variables.version = "0.0.1";

  public function handler() returnformat="json" {
    return { success: "I matched on a wildcard" };
  }

}