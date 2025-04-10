*base-metacello-core
assert: aBlock
  "Throw an assertion error if aBlock does not evaluates to true."

  aBlock value
    ifFalse: [ self halt: 'Assertion failed' ]
