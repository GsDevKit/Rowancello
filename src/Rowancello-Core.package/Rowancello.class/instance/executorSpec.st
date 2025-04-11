accessing
executorSpec
    executorSpec ifNil: [ executorSpec := #'RowancelloScriptApiExecutor' -> 'batch' ].
    ^ executorSpec