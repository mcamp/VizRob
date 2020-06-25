Class {
	#name : #MVUpdateAnimation,
	#superclass : #RTAnimation,
	#instVars : [
		'view',
		'action'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #'instance creation' }
MVUpdateAnimation class >> action: aBlock on: aView [
	aView addAnimation: (self new on: aView; action: aBlock)
]

{ #category : #'instance creation' }
MVUpdateAnimation class >> on: aView [
	self action: [ :v| ] on: aView 
]

{ #category : #accessing }
MVUpdateAnimation >> action [
	^ action
]

{ #category : #accessing }
MVUpdateAnimation >> action: anObject [
	action := anObject
]

{ #category : #actions }
MVUpdateAnimation >> executeAction [

	action value: view
]

{ #category : #testing }
MVUpdateAnimation >> hasCompleted [
	^ true
]

{ #category : #'instance creation' }
MVUpdateAnimation >> on: aView [ 
	view := aView.
]

{ #category : #refreshing }
MVUpdateAnimation >> refresh [

	self executeAction.
	view signalUpdate.
]

{ #category : #actions }
MVUpdateAnimation >> start [
	self executeAction.
	view signalUpdate.
]
