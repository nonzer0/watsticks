$(document).ready(function() {
  // turn row grey if no longer in contention for job
  $('.table tr').each(function() {
    $(this).find('.in-consideration').each(function() {
      var title = $(this).html();
      if (title !== 'true') {
        console.log(title);
        $(this).parent('tr').addClass('passed');
      }
    });
  });

  $(".clickable_job_row").click(function() {
    window.document.location = $(this).data('url');
  });
  $(document).on("ajax:success", function(e, data, status, xhr) {
    debugger;
    $('.contact-fields').append(xhr.responseText);
    $('#myModal').modal('hide');
  }).on("ajax:error", function(e, data, status, error) {
    $('.contact-fields').append('Error');
  });
});
