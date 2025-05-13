*base-metacello-core
addToMetacelloRepositories: aMetacelloRepositoriesSpec  currentAttributeList: attributeList

	self do: [:each | each addToMetacelloRepositories: aMetacelloRepositoriesSpec currentAttributeList: attributeList ]