/*
  Matches with struct data
*/
component output="false" {
  public function handler( struct data ) returnformat="json" {
    return { success: "I matched on a named variable - " & data.theMatch };
  }

  public function getRoute(){
    return "struct/%theMatch%";
  }
}