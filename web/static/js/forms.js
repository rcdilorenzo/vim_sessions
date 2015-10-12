var setFormError = function (event, error) {
  return $(event.target).parent().children('.error').html(error);
};

var fieldValue = function (event, type) {
  var value = $(event.target).children('#' + type).val();
  return value == '' ? null : value;
};

var formParams = function (event, keys) {
  var object = {};
  for (var i = 0; i < keys.length; i++) {
    var key = keys[i];
    object[key] = fieldValue(event, key);
  }
  return object;
};


$("form#ajax").submit(function(e) {
  e.preventDefault();
  var form = $(this);
  $.ajax({
    type: this.method,
    url: this.action,
    data: $(this).serialize(),
    success: function (data) {
      window.location = form.attr("on-success");
    },
    error: function (data) {
      var message = "unknown error occurred";
      if (data.responseJSON && data.responseJSON.message) {
        message = data.responseJSON.message;
      } else {
        console.error(data.responseText);
      }
      setFormError(e, message);
    }
  });
});

$("form#register").submit(function(e) {
  e.preventDefault();
  var params = formParams(e, ['first_name', 'last_name', 'email', 'username', 'bio', 'password', '_csrf_token']);
  $.post('/register', params).then(function (data) {
      console.log(data);
      window.location = "/";
  }).fail(function (data) {
    var message = "unknown error occurred";
    if (data.responseJSON && data.responseJSON.error) {
      message = "Errors:\n" + data.responseJSON.error;
    } else {
      console.log(data.responseText);
    }
    setFormError(e, message.replace(/\n/g,'<br/>'));
  });
});
