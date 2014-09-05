jQuery(document).ready(function($) {
  $(".clickable_job_row").click(function() {
    window.document.location = $(this).data('url');
  });
});
