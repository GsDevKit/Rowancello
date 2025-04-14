handlers
handleNotificationsForAction: actionBlock
  actionBlock
    on:
     Notification
    do: [ :ex | 
      ex halt ]