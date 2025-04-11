accessing
projectSpecLookupBlock
    ^ [ :projectName | 
    {(MetacelloProjectRegistration
        projectSpecForClassNamed: (RowancelloScriptEngine baselineNameFrom: projectName)
        ifAbsent: [  ])} ]