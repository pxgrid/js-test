var zombie = require('zombie');
var expect = require('expect.js');

describe('Todo', function() {
  var window, $;

  before(function(done) {
    // urlを開く
    zombie.visit('http://localhost:8080/', function(err, browser) {
      $ = browser.window.$;

      // フォームをサブミットしてチェックボックスをクリック
      $('input[type="text"]').val('foo');
      $('form').submit();
      $('li input[type="checkbox"]').click();

      done();
    });
  });

  it('リストに要素が追加されていること', function() {
    expect($('li').length).to.be(1);
  });

  it('サブミットした内容がリストのテキストになっていること', function() {
    expect($('li').eq(0).text()).to.be('foo');
  });

  it('complete classが付加されていること', function() {
    expect($('li').attr('class')).to.be('complete');
  });
});
