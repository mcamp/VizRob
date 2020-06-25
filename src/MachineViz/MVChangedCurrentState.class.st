Class {
	#name : #MVChangedCurrentState,
	#superclass : #Announcement,
	#instVars : [
		'currentState'
	],
	#category : #'MachineViz-Announcements'
}

{ #category : #accessing }
MVChangedCurrentState >> currentState [
	^ currentState
]

{ #category : #accessing }
MVChangedCurrentState >> currentState: anObject [
	currentState := anObject
]
