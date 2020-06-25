Extension { #name : #MVLog }

{ #category : #'*MachineViz-SMACH' }
MVLog >> levelFromNumber: aNumber [

	self level: (self numberToLevel: aNumber)
]

{ #category : #'*MachineViz-SMACH' }
MVLog >> numberToLevel: aNumber [

	^ self numberToLevelDic at: aNumber
]

{ #category : #'*MachineViz-SMACH' }
MVLog >> numberToLevelDic [

	^ Dictionary newFromPairs: { 
		1 . MVLogLevel debug  .
		2 . MVLogLevel info  .
		4 . MVLogLevel warning  .
		8 . MVLogLevel error } 
]
