"
A state can be a current state more than one time,  I represent this with a collection of status of current state
"
Class {
	#name : #MVStateStatusCollection,
	#superclass : #OrderedCollection,
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #accessing }
MVStateStatusCollection >> logs [

^ self flatCollect: [ :status| status logs ] as: MVLogCollection. 
]

{ #category : #accessing }
MVStateStatusCollection >> totalTime [

	self ifEmpty: [ ^Duration new ].
	^(self collect: [ :st| st totalTime ]) sum.
]
