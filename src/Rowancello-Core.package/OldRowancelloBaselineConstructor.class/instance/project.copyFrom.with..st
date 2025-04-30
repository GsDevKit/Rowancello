api
project: aString copyFrom: oldSpecName with: aBlock

GsFile gciLogServer: 'project:copyFrom:with: ', aString, '	', oldSpecName.
    self root
        project: aString
        copyFrom: oldSpecName
        with: aBlock
        constructor: self