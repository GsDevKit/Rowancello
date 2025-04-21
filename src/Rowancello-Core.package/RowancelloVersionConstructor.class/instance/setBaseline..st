api callbacks
setBaseline: aString
    | spec projectSpec |
self halt.
    projectSpec := self project baselineOfProjectSpec
        name: aString;
        className: 'BaselineOf' , aString;
        yourself.
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
        yourself.
    self root packages merge: spec.
    ^ projectSpec