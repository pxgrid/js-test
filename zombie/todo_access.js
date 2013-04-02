var zombie = require('zombie');

zombie.visit('http://localhost:8080/', function(err, browser) {
  var window = browser.window;
  var $ = window.$;

  $('input[type="text"]').val('foo');
  $('form').submit();

  console.log( $('ul').html() );
});
