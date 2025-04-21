private
calculate: aConfig project: aProject
    | pragma versionMap versionSpec |
    self configuration: aConfig.
    pragma := self extractBaselinePragmaFor: aConfig class.
    self
        setProject:
            (aProject
                ifNil: [ 
                    [ aConfig class project ]
                        on: MessageNotUnderstood
                        do: [ :ex | ex return: nil ] ]).
    versionSpec := self project versionSpec.
    self root: versionSpec.
    self evaluatePragma: pragma.
    versionMap := Dictionary new.
    self project attributes
        do: [ :attribute | 
            | blockList |
            (blockList := self attributeMap at: attribute ifAbsent: [  ]) ~~ nil
                ifTrue: [ blockList do: [ :ar | 
		|  block  fullAttributeList |
		block := ar at: 1.
		fullAttributeList := ar at: 2.
		self with: versionSpec attributes: fullAttributeList during:block ] ] ].
    versionSpec versionString: self project singletonVersionName.
    versionMap at: versionSpec versionString put: versionSpec createVersion.
    self project map: versionMap.
    self project configuration: aConfig