// jQuery(function($) {

//   var locationId = $('#venue-profile').data('instagram');

//   $('.instagram').on('didLoadInstagram', function(event, response) {
//     // console.log(response);
//     loadLocationImages(response);
//   });
  
//   $('.instagram').instagram({
//     accessToken: '974282.1677ed0.cc1dfd3bac6f463898c30e65fffe7e76',
//     location: {
//       id: locationId
//     },
//     count: 20,
//     clientId: 'b9e858540bab493b9de7dd6ca65d3ac5'
//   });
// });

// function loadLocationImages(data) {
//   var template = $('#instagramTemplate').html();
//   Mustache.parse(template);   // optional, speeds up future uses
//   var rendered = Mustache.render(template, data);
//   $('#instagramTarget').html(rendered);
// }