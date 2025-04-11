repositories
repositoriesFrom: aMetacelloMVRepositorySpecs ignoreOverrides: ignoreOverrides

	| repos |
	(ignoreOverrides not and: [self hasRepositoryOverrides]) ifTrue: [ ^self loaderPolicy overrideRepositories ].
	repos := OrderedCollection new.
	aMetacelloMVRepositorySpecs do: [:aSpec | | description repo |
		description := aSpec description.
		(repo := aSpec halt createRepository) ~~ nil
			ifTrue: [ repos add: repo ]].
	^repos