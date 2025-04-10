handlers
handleNotificationsForAction: actionBlock
  actionBlock
    on:
     Notification
    do: [ :ex | 
      self halt ]