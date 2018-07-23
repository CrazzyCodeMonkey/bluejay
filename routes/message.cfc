component output="false" {
  public function handler( struct data ) returnformat="json" {
    return { success: data.recipient };
  }

  public function getRoute(){
    return "message/%recipient%/";
  }
}