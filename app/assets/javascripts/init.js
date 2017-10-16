$(document).ready(function() {
  window.currentController = $('body').data('controller');
  window.currentAction = $('body').data('action');
});
$(document).on('turbolinks:load', function() {
  window.currentController = $('body').data('controller');
  window.currentAction = $('body').data('action');
});
