/**
  Bluejay example
*/
component output="false" {
  this.name = "BluejayApi";

  function onApplicationStart() {
    application.bluejay = new bluejay.bluejay();
  }


  function onRequestStart(targetPage){
    // Manual registration
    application.bluejay.registerRoute("simple");

    application.bluejay.handleRoute();

    
  }
}