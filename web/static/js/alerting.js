var $ = require('jquery');

var flash_message = (alert_type, content) => {
  $('#alerts p.alert.alert-'+alert_type).html(content + '<b class="fa fa-window-close-o pull-right close-alert"></b>');
};

$(document).ready(() => {
$('#alerts').on('click', '.close-alert', () => { $(this).closest('p').text(''); });
});

let alerting = {
  flash_message: flash_message
};

export default alerting