handlers
handleNotificationsForAction: actionBlock
  actionBlock
    on:
     Notification
    do: [ :ex | 
      self halt: 'unexpected Notification ', ex printString ]