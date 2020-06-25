Class {
	#name : #MVNoneState,
	#superclass : #MVState,
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #'private - current state' }
MVNoneState >> finish [
	"do nothing"
]

{ #category : #testing }
MVNoneState >> ifNone: aBlock [
	^aBlock value
]

{ #category : #testing }
MVNoneState >> ifNotNone: aBlock [
	^ self
]

{ #category : #initialization }
MVNoneState >> initialize [

	super initialize.
	stateName := 'None'
]

{ #category : #testing }
MVNoneState >> isNone [
	 ^true
]

{ #category : #'private - current state' }
MVNoneState >> start [
	"do nothing"
]
