App.queue = App.cable.subscriptions.create "QueueChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    docSection = document.getElementById('guest-position')
    pos = parseInt(docSection.innerHTML)
    if pos > 0
      if pos == 1
        docSection.innerHTML = 'Being helped by ' + data.modName
      else
        pos--
        docSection.innerHTML = pos
    
