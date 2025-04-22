api spec callbacks
configurationForVersion: aString with: aBlock


self halt: 'skipping ', aString, ' for now'.
true ifTrue: [ ^self ].
    aBlock setConfiguration: aString withInMetacelloConfig: self