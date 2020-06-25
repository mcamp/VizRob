Class {
	#name : #MVUpdaterTestResource,
	#superclass : #TestResource,
	#instVars : [
		'updater'
	],
	#category : #'MachineViz-Tests'
}

{ #category : #initialization }
MVUpdaterTestResource >> setUp [
	updater := self simUpdater
]

{ #category : #data }
MVUpdaterTestResource >> simUpdater [

	^MVTestUpdater example.
]

{ #category : #accessing }
MVUpdaterTestResource >> updater [
	^ updater
]

{ #category : #accessing }
MVUpdaterTestResource >> updater: anObject [
	updater := anObject
]
