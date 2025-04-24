api spec callbacks
removePackageForVersion: aString
    | spec |
    spec := self project packageSpec
        name: aString;
        yourself.
   spec currentAttributeList: self currentAttributeList.
   self root packages remove: spec