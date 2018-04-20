// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function() {
  $('.select2').select2({
    ajax: {
      url: '/search',
      dataType: 'json'
    },
    minimumInputLength: 3,
    width: '200px'
  });

  $('.select2').on('select2:select', function (e) {
    var data = e.params.data;
    window.location.pathname = 'contest/' + data['id'] + '/questions'
  });
});
