actions
copy: specNamed to: spec
self halt: spec name, ' copy:to:'.
	self addMember: 
		(self copyMember 
			name: spec name;
			sourceName: specNamed;
			spec: spec;
			yourself)