conditions
createConditionExpressionFrom: conditionArray
	"Create an expression where the elements of conditionArray are ored together ... include only pharo, gemstone, pharo13.x, and gemstone version greater than or equal to 3.7.5"

	| expression ast |
	expression := String new.
	1 to: conditionArray size do: [ :index | 
		| term |
		term := (conditionArray at: index) asString.
		((term = 'pharo13.x' or: [ term = 'gs3.8.x' or: [ term = 'gs3.9.x' ] ])
			or: [ 
				ast := RwCAQParser new parse: term.
				(RwCAQEvaluator context: RowancelloProject conversionContext ast: ast) evaluate ])
			ifTrue: [ 
				expression add: term.
				index < conditionArray size
					ifTrue: [ expression add: ' | ' ] ] ].
	^ expression