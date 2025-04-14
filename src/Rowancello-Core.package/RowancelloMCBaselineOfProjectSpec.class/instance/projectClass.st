querying
projectClass
    self className == nil
        ifTrue: [ ^ nil ].
    ^ GsSession currentSession symbolList  objectNamed: self className asSymbol