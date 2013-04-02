window.foo = 'bar';
$(function() {
  var $ul = $('ul');
  var $input = $('input[type="text"]');

  $('form').submit(function(e) {
    e.preventDefault();

    var $li = $('<li>');
    var $text = $('<span>');
    var $checkbox = $('<input type="checkbox">');

    $text.text($input.val());
    $input.val('');

    $checkbox.change(function() {
      if ($checkbox.is(':checked')) {
        $li.addClass('complete');
      }
      else {
        $li.removeClass('complete');
      }
    });

    $li.append($checkbox, $text).appendTo($ul);
  });

});
