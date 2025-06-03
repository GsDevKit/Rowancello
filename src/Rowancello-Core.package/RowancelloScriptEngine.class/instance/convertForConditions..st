private
convertForConditions: conditionArray
	"Create an expression where the elements of conditionArray are ored together"

	| expression ast context evaluator |
	expression := String new.
	1 to: conditionArray size do: [ :index | 
		expression add: (conditionArray at: index) asString.
		index < conditionArray size
			ifTrue: [ expression add: ' | ' ] ].
	context := RwCAQContext new.
	context set: 'common'.
	context set: 'gemstone'.
	context set: 'gemstone.version' to: '3.7.5' asRwGemStoneVersionNumber.
	ast := RwCAQParser new parse: expression.
	evaluator := RwCAQEvaluator context: context ast: ast.
	^ evaluator evaluate