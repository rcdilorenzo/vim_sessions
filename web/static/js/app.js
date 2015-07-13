import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

let App = {
}


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
      $(".error").html(message);
    }
  });
});

$("form#register").submit(function(e) {
  e.preventDefault();
  var fieldValue = function (type) {
    var value = $('form#register #' + type).val();
    return value == '' ? null : value;
  };
  var params = {
    first_name: fieldValue('first_name'),
    last_name: fieldValue('last_name'),
    email: fieldValue('email'),
    username: fieldValue('username'),
    bio: fieldValue('bio'),
    password: fieldValue('password'),
    _csrf_token: fieldValue('_csrf_token')
  };
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
    $("form .error").html(message.replace(/\n/g,'<br/>'));
  });
});

export default App
