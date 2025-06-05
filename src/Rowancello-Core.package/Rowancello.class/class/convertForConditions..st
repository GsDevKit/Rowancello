conditions
convertForConditions: conditionArray
	"Answer true  for pharo or gemstone or version greater than or equal to  pharo13.x or gemstone 3.7.5"

	| expression ast evaluator includeForPharo13 includeForGemStone38  includeForGemStone39 |
	includeForGemStone38 := includeForGemStone39 := includeForPharo13 := false. 
	expression := String new.
	1 to: conditionArray size do: [ :index | 
		expression add: (conditionArray at: index) asString.
		includeForPharo13 ifFalse: [ includeForPharo13 := (conditionArray at: index) = 'pharo13.x'].
		includeForGemStone38 ifFalse: [ includeForGemStone38 := (conditionArray at: index) = 'gs3.8.x'].
		includeForGemStone39 ifFalse: [ includeForGemStone39 := (conditionArray at: index) = 'gs3.9.x'].
		index < conditionArray size
			ifTrue: [ expression add: ' | ' ] ].
	ast := RwCAQParser new parse: expression.
	evaluator := RwCAQEvaluator context: self conversionContext ast: ast.
	^ evaluator evaluate |  includeForPharo13 | includeForGemStone38 | includeForGemStone39