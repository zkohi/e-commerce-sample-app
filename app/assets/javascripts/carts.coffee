ready = ->
  datepickerRoot = $('#order_shipping_date')
  datepickerOptions = datepickerRoot.data('datepickerOptions');
  datepickerRoot.datepicker(
    dateFormat: 'yy-mm-dd',
    beforeShowDay: $.datepicker.noWeekends,
    minDate: datepickerOptions.minDate,
    maxDate: datepickerOptions.maxDate
  ) if datepickerRoot.length
$(document).ready(ready)
$(document).on('turbolinks:load', ready)
