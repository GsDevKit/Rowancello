*base-metacello-core
addToMetacelloRepositories: aMetacelloRepositoriesSpec

	self do: [:each | each addToMetacelloRepositories: aMetacelloRepositoriesSpec ]
