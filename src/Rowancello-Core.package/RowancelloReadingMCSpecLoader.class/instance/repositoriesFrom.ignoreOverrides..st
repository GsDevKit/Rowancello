repositories
repositoriesFrom: aMetacelloMVRepositorySpecs ignoreOverrides: ignoreOverrides

	| repos |
	repos := OrderedCollection new.

true ifTrue: [ ^ repos ].
	aMetacelloMVRepositorySpecs do: [:aSpec | 
		repos add: aSpec description ].
	^repos