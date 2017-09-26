// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .

$(document).on('submit', '#eventDateForm', function(e){
  e.preventDefault();
  $("#summary").text("Working hard. Please be patient.")
  var date = $( "input:first" ).val()
  $.getJSON( "/api/event-summary?date=" + $( "input:first" ).val(), function( data ) {
    if(data.status === 'cached') {
      renderSummary(data.data)
    };

    if(data.status === 'working') {
      var check = setInterval(function(){
        $.getJSON( "/api/check-jobs?ids=" + data.data.join("+"), function( data ) {
          if(data.status === 'cached') {
            renderSummary(data.data)
            clearInterval(check);
          };
        });
      }, 3000);
    };
  });
  return false;
});

function renderSummary(data){
  $("#summary").empty()
  var items = [];
  $.each( data, function(i, d ) {
    items.push( "<div><img src="+d.img_url+"></img><h3>"+d.title+"</h3><p>"+d.description+"</p><a href="+d.page_url+">original link</a></div>" );
  });
  $( items.join( "<hr>" )).appendTo( "#summary" );

}

