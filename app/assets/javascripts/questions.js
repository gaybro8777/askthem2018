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
});
