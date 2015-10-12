import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", chan => {
//   console.log("Success!")
// })

let App = {
}

require('./forms');

if ($('#epiceditor').length) {
  var editor = new EpicEditor({
    textarea: $('#epic-content')[0],
    theme: {
      base: '../../../../css/epiceditor.css',
      preview: '../../../../css/github.css',
      editor: '../../../../css/epic-dark.css'
    },
    autogrow: {
      minHeight: 100
    }
  }).load();
}

export default App
