Class {
	#name : #MVContainer,
	#superclass : #Object,
	#instVars : [
		'parent',
		'updater'
	],
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #testing }
MVContainer >> ifNone: aBlock [
	^ self
]

{ #category : #testing }
MVContainer >> ifNotNone: aBlock [
	^ aBlock value
]

{ #category : #testing }
MVContainer >> ifRoot: aBlock [

	self isRoot ifTrue: aBlock
]

{ #category : #testing }
MVContainer >> isRoot [
	^self parent isNil
]

{ #category : #accessing }
MVContainer >> parent [
	^ parent
]

{ #category : #accessing }
MVContainer >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
MVContainer >> updater [
	self ifRoot: [ ^updater ].
	^ self parent updater.
]

{ #category : #accessing }
MVContainer >> updater: anObject [
	updater := anObject
]
