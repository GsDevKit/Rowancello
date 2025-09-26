### The Summary_tode.ston file in this directory was generated from a 3.6.3 tode stone using the following process.

Still need to generate the expected packages for Seaside, Zodiac, RB, Metacello ... and in the long term the full set of projects in the GsDevKit ecosystem.

The following changes were made to the Metacello classes to implement helper methods:
```
____________________ Metacello ____________________
==================== Metacello-MC (-) --> image (+)  ====================
Item was added:
+ ----- Method: MetacelloDirective>>queryDirectivesDo:projectName: (in category 'enumerating') -----queryDirectivesDo: aBlock projectName: aProjectName
+   self error: 'not implemented'!

Item was added:
+ ----- Method: MetacelloPackageLoadDirective>>queryDirectivesDo:projectName: (in category 'enumerating') -----queryDirectivesDo: aBlock projectName: aProjectName
+   "projectName only"
+ 
+   aBlock
+     cull: spec name
+     cull: spec project configuration class printString
+     cull: loader spec!

Item was added:
+ ----- Method: MetacelloVersionLoadDirective>>queryDirectivesDo:projectName: (in category 'enumerating') -----queryDirectivesDo: aBlock projectName: aProjectName
+   self loadDirectives
+     do: [ :directive | directive queryDirectivesDo: aBlock projectName: aProjectName ]!
```
The following st script was used to generate the Summary_tode.ston file:
```
| dict stonStream writer |
  dict := Dictionary new.
  (Metacello new
    baseline: 'GLASS1';
    onConflictUseLoaded;
    record: #('default'))
    queryDirectivesDo: [ :packageName :projectName :loader | 
      | attrDict |
      attrDict := dict at: projectName ifAbsentPut: [ Dictionary new ].
      (attrDict at: 'packageName' ifAbsentPut: [ Array new ]) add: packageName.
      loader
        ifNotNil: [ (attrDict at: 'loads' ifAbsentPut: [ Set new ]) addAll: loader required ] ]
    projectName: nil.
  dict
    keysAndValuesDo: [ :key :projectDict | (projectDict at: 'loads') removeAllPresent: (projectDict at: 'packageName') ].
  stonStream := FileStreamPortable
    write: '/home/dhenrich/junk/Summary_tode.ston'.
  writer := STON writer
    referencePolicy: #'ignore';
    newLine: String lf;
    yourself.
  (writer on: stonStream)
    prettyPrint: true;
    nextPut: dict.
  stonStream close
```
