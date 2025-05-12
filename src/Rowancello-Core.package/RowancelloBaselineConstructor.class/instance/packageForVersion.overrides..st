api spec callbacks
packageForVersion: aString overrides: aBlock
    | spec |
    spec := self project packageSpec
        name: aString;
        yourself.
    spec currentAttributeList: self currentAttributeList.
    self commonVersionSpec packages add: spec.
    self with: spec during: aBlock