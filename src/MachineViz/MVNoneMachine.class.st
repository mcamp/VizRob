Class {
	#name : #MVNoneMachine,
	#superclass : #MVMachine,
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #testing }
MVNoneMachine >> ifNone: aBlock [
	^ aBlock value
]

{ #category : #testing }
MVNoneMachine >> ifNotNone: aBlock [
	^ self
]
