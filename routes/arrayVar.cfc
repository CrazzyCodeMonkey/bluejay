component output="false" implements="bluejay.iRoute" extends="bluejay.baseRoute" {
  /*
    Matches with array data
  */

  variables.route = "array/%";
  variables.name = "Sample Array Endpoint";
  variables.description = "Sample BlueJay enpoint using ordered path parameters";
  variables.version = "0.0.1";

  public function handler( array data ) returnformat="json" {
    return { success: "I matched on an unnamed variable - " & data[1] };
  }

}