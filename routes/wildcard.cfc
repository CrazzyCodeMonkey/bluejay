/*
  This is a test for matching wildcards.
*/
component output="false" {
  public function handler() returnformat="json" {
    return { success: "I matched on a wildcard" };
  }

  public function getRoute(){
    return "cool/*";
  }
}