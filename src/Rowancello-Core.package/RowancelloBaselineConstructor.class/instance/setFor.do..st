api callbacks
setFor: attributeList do: aBlock
    | fullAttributeList |
    "conditional version support"
    (fullAttributeList := attributeList asMetacelloAttributeList)
        do: [ :attribute | 
            | blockList |
            blockList := self attributeMap
                at: attribute
                ifAbsent: [ self attributeMap at: attribute put: (blockList := OrderedCollection new) ].
            blockList add: { aBlock . fullAttributeList}.
            self addAttribute: attribute ]