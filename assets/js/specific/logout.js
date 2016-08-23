$(document).ready(function(){

  $(document).on('click', '.js-logout', function() {
    sessionStorage.clear();
  });
});