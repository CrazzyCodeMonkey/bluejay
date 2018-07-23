/**
  Core Bluejay component.
  Currently does all the work.
*/
component output="false" {
  function init( array routes = [] ) {
    console("Initializing Bluejay v." & this.getVersion());
    this.routes = [];

    // Automatically register components in the /routes folder.
    if( directoryExists( expandPath("/routes") ) ) {
      var routes = directoryList( expandPath("/routes") );
      var basePath = GetDirectoryfrompath(getBasetemplatepath());
      
      for( var route in routes ) {
        var cleanPath = replace( route, basePath, "" );
        cleanPath = listFirst( cleanPath, "." );
        this.registerRoute(cleanPath);
      }
    }

    return this;
  }


  private function getVersion(){
    return 0.1;
  }


  public boolean function registerRoute( required string pathToRoute ){
    var tmp = createObject("component", "#pathToRoute#");
    var route = {path: pathToRoute, route: tmp.getRoute(), comp: tmp};
    
    route.hasWildcard = (findOneOf(tmp.getRoute(), "*") != 0);
    route.hasVariable = (findOneOf(tmp.getRoute(), "%") != 0);
    
    arrayAppend( this.routes, route );

    return true;
  }


  public boolean function handleRoute(){
    var toMatch = listFirst( cgi.query_string, "?" );

    // Fix url.
    // Not the prettiest, but works for now.
    for( thing in url ) {
      if( toMatch == listFirst( thing, "?" ) ){
        structDelete(url, thing);
      }
    }

    var dataArray = [];
    var dataStruct = {};

    pc = getpagecontext();

    for( var route in this.routes ) {
      // Match with wildcard
      if( route.hasWildcard || route.hasVariable ) {
        var matchArray = listToArray(toMatch, "/");
        var routeArray = listToArray(route.route, "/");

        var mismatch = false;

        // Make sure they're the same length
        if( arrayLen(matchArray) == arrayLen(routeArray) ){

          // Loop each item
          for( var i = 1; i <= arrayLen(routeArray); i++ ) {

            // Because wildcard will match anything, no need to even check
            if( routeArray[i] != "*" ) {
              if( routeArray[i] == "%" ) {
                // Essentially wildcard and save the data to an array
                arrayAppend( dataArray, matchArray[i] );

              } else {
                if( left(routeArray[i], 1) == "%" && right(routeArray[i], 1) == "%" ) {
                  // Save with struct name
                  var tmpKey = replace(routeArray[i], "%", "", "ALL");
                  dataStruct[tmpKey] = matchArray[i];

                } else {
                  if( routeArray[i] != matchArray[i] ) {
                    mismatch = true;
                    break;
                  }
                }
              }
            }
          }

          if( !mismatch ) {
            if( structCount(dataStruct) > 0 ) {
              var data = route.comp.handler(dataStruct);
            } else {
              var data = route.comp.handler(dataArray);
            }

            if( isSimpleValue(data) ) {
              writeOutput(data);
              
            } else {
              writeOutput(serializeJson(data));
            }
            
            // Set returnformat if it's set
            if( structKeyExists( getMetaData(route.comp.handler), "returnformat" ) ){
              pc.getresponse().setcontenttype('application/' & getMetaData(route.comp.handler).returnformat);
            }

            return true;
          }

        }

      } else {
        if( toMatch == route.route ) {
          
          var data = route.comp.handler();

          if( isSimpleValue(data) ) {
            writeOutput(data);
            
          } else {
            writeOutput(serializeJson(data));
          }
          
          // Set returnformat if it's set
          if( structKeyExists( getMetaData(route.comp.handler), "returnformat" ) ){
            pc.getresponse().setcontenttype('application/' & getMetaData(route.comp.handler).returnformat);
          }

          return true;
        }
      }
    }

    // We didn't find a matching route, show 404
    writeOutput(
      serializeJson( this.fourOhFour() )
    );

    pc.getresponse().setcontenttype('application/json');
    pc.getresponse().setStatus(404);

    return false;
  }


  private function fourOhFour(){
    return { sucess: false, reason: "No matching route found", code: 404 };
  }
}