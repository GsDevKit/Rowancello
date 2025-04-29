api
project: aString copyFrom: oldSpecName with: aBlock
false ifTrue: [ aString = 'Grease-Tests' ifTrue: [ self halt: 'Grease-Tests -- RowancelloVersionConstructor >> project:copyFrom:with:' ]].
    self root
        project: aString
        copyFrom: oldSpecName
        with: aBlock
        constructor: self