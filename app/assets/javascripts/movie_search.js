$( document ).ready( function() {
  $( '#submitForm' ).on( 'submit', function( event ) {
    event.preventDefault();
    var title = $( '#movieTitle' ).val();
    var form = $( event.currentTarget );

    var getMovie = $.ajax({
      type: 'GET',
      url: form.attr( 'action' ),
      data: { title: title },
      dataType: 'json',
      success: function( result ) {
        var titleMovie = movieInfo( result );

        $( '#movieData' ).empty();
        $( '#movieData' ).append( titleMovie );
      }
    });
  });

  function movieInfo( result ) {
    var movieData = [];
    movieData.push($( '<div>' ).text( result.movie.title ).attr( { class: "titleMovie" } ));
    movieData.push($( '<div>' ).text( result.actors.slice(0, 5).join(", ") ));
    for(var i = 0; i < result.image.length; i++) {
      debugger;
      movieData.push($( '<img>' ).attr( { src: result.image[i], height: 200, width: 200 } ));
    }
    return movieData;
  }
});
