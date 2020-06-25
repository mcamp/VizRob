Class {
	#name : #MVTransition,
	#superclass : #Object,
	#instVars : [
		'fromState',
		'toState',
		'transitionName'
	],
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #accessing }
MVTransition >> from [
	^ fromState
]

{ #category : #accessing }
MVTransition >> from: aState [
	fromState := aState
]

{ #category : #initialization }
MVTransition >> initialize [
	super initialize.
	transitionName := 'Unamed'
]

{ #category : #accessing }
MVTransition >> to [
	^ toState
]

{ #category : #accessing }
MVTransition >> to: aState [
	toState := aState
]

{ #category : #accessing }
MVTransition >> transitionName [
	^ transitionName
]

{ #category : #accessing }
MVTransition >> transitionName: aNameAsString [
	transitionName := aNameAsString
]
