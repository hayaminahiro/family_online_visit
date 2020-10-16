<script type="text/javascript" src="//jpostal-1006.appspot.com/jquery.jpostal.js"></script>
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery.jpostal
//= require_tree .

$(function () {
	$('#btn').on('click', function(){
		$.ajax({
			url: 'http://zipcloud.ibsnet.co.jp/api/search?zipcode=' + $('#zipcode').val(),
			dataType : 'jsonp',
		}).done(function(data) {
			if (data.results) {
			   setAddress(data.results[0]);
			} else {
				alert('該当するデータが見つかりませんでした。');
			}
		}).fail(function(data) {
			alert('通信に失敗しました');
		});
	});
	function setAddress(data) {
		$('#perfecture').val(data.address1);
		$('#city').val(data.address2);
		$('#address').val(data.address3);
	}
 });

//= require dropzone
