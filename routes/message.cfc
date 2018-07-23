component output="false" implements="bluejay.iRoute" extends="bluejay.baseRoute" {
  variables.route = "message/%recipient%/";
  variables.name = "Please update name";
  variables.description = "Please update Description";
  variables.version = "0.0.1";

  public function handler( struct data ) returnformat="json" {
    return { success: data.recipient };
  }

}