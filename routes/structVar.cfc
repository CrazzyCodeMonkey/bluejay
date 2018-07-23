component output="false" implements="bluejay.iRoute" extends="bluejay.baseRoute" {
/*
  Matches with struct data
*/
  variables.route = "struct/%theMatch%";
  variables.name = "Please update name";
  variables.description = "Please update Description";
  variables.version = "0.0.1";

  public function handler( struct data ) returnformat="json" {
    return { success: "I matched on a named variable - " & data.theMatch };
  }

}