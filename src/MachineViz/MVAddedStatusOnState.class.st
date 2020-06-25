Class {
	#name : #MVAddedStatusOnState,
	#superclass : #Announcement,
	#instVars : [
		'addedStatus',
		'state'
	],
	#category : #'MachineViz-Announcements'
}

{ #category : #accessing }
MVAddedStatusOnState >> addedStatus [
	^ addedStatus
]

{ #category : #accessing }
MVAddedStatusOnState >> addedStatus: anObject [
	addedStatus := anObject
]

{ #category : #accessing }
MVAddedStatusOnState >> state [
	^ state
]

{ #category : #accessing }
MVAddedStatusOnState >> state: anObject [
	state := anObject
]
