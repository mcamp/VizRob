"
I am deprecated
"
Class {
	#name : #MVStatusCollection,
	#superclass : #OrderedCollection,
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #accessing }
MVStatusCollection >> logs [

	^ self flatCollect: [ :status| status logs ] as: MVLogCollection. 
 
]
