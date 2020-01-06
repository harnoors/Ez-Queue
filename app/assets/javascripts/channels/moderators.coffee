App.queue = App.cable.subscriptions.create "ModeratorsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    docSection = document.getElementById('guest-position')
    pos = parseInt(docSection.innerHTML)
    if pos > 0
        docSection.innerHTML = 'The Queue by  ' + data.modName + '  has been shut down '
      
    
