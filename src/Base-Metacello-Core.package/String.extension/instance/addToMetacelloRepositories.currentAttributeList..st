*base-metacello-core
addToMetacelloRepositories: aMetacelloRepositoriesSpec   currentAttributeList: attributeList

	| spec |
	spec := 
		(aMetacelloRepositoriesSpec project repositorySpec)
			description: self;
			yourself.
	spec   currentAttributeList: attributeList.
	aMetacelloRepositoriesSpec addMember: 
		(aMetacelloRepositoriesSpec addMember 
			name: spec name;
			spec: spec;
			yourself)