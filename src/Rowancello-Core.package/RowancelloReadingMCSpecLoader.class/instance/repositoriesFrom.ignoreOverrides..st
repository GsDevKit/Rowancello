repositories
repositoriesFrom: aMetacelloMVRepositorySpecs ignoreOverrides: ignoreOverrides

	| repos |
	repos := OrderedCollection new.
	aMetacelloMVRepositorySpecs do: [:aSpec | 
		repos add: aSpec description ].
	^repos