api
project: aString copyFrom: oldSpecName with: aBlock
aString = 'Grease-Tests' ifTrue: [ self halt ].
    self root
        project: aString
        copyFrom: oldSpecName
        with: aBlock
        constructor: self