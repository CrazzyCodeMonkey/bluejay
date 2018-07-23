/*
  Matches with array data
*/
component output="false" {
  public function handler( array data ) returnformat="json" {
    return { success: "I matched on an unnamed variable - " & data[1] };
  }

  public function getRoute(){
    return "array/%";
  }
}