loading
explicitLoadUsing: mcLoader
	"fetch and explicitly read it"

	| fetchingSpecLoader |
	fetchingSpecLoader := mcLoader fetchingSpecLoader.
	fetchingSpecLoader
		explicitLoadPackageSpecs: (Array with: self)
		repositories: (fetchingSpecLoader repositoriesFrom: self repositorySpecs)