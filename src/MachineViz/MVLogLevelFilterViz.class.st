Class {
	#name : #MVLogLevelFilterViz,
	#superclass : #ComposablePresenter,
	#instVars : [
		'checkDebug',
		'checkError',
		'checkInfo',
		'checkWarning',
		'levels',
		'filterViz',
		'severityLabel'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVLogLevelFilterViz class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col add: #severityLabel.
			col add: #checkDebug.
			col add: #checkInfo.
			col add: #checkWarning.
			col add:	#checkError
		]
		yourself
]

{ #category : #private }
MVLogLevelFilterViz >> addLevelFrom: aCheck [
	aCheck addLevel: levels
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkDebug [
	^ checkDebug
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkDebug: anObject [
	checkDebug := anObject
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkError [
	^ checkError
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkError: anObject [
	checkError := anObject
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkInfo [
	^ checkInfo
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkInfo: anObject [
	checkInfo := anObject
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkWarning [
	^ checkWarning
]

{ #category : #accessing }
MVLogLevelFilterViz >> checkWarning: anObject [
	checkWarning := anObject
]

{ #category : #accessing }
MVLogLevelFilterViz >> filterViz [
	^filterViz
]

{ #category : #accessing }
MVLogLevelFilterViz >> filterViz: aMVFilterViz [
	filterViz := aMVFilterViz 
]

{ #category : #initialization }
MVLogLevelFilterViz >> initialize [

	super initialize.
	levels := (OrderedCollection newFrom: #(debug info warning error)) asValueHolder.
	levels whenAddedDo:[self updateLogs].
	levels whenRemovedDo:[self updateLogs].
]

{ #category : #initialization }
MVLogLevelFilterViz >> initializePresenter [

	checkWarning whenActivatedDo: [self addLevelFrom: checkWarning ].
	checkWarning whenDeactivatedDo: [ self removeLevelFrom: checkWarning  ].
	checkDebug whenActivatedDo: [ self addLevelFrom: checkDebug].
	checkDebug whenDeactivatedDo: [ self removeLevelFrom: checkDebug ].
	checkInfo whenActivatedDo: [ self addLevelFrom: checkInfo].
	checkInfo whenDeactivatedDo: [ self removeLevelFrom: checkInfo ].
	checkError whenActivatedDo: [ self addLevelFrom: checkError].
	checkError whenDeactivatedDo: [ self removeLevelFrom: checkError ].
]

{ #category : #initialization }
MVLogLevelFilterViz >> initializeWidgets [

	checkWarning := self instantiate: MVLogFilterCheckViz.
	checkDebug := self instantiate: MVLogFilterCheckViz.
	checkInfo := self instantiate: MVLogFilterCheckViz.
	checkError := self instantiate: MVLogFilterCheckViz.
	severityLabel := self newLabel.
	
	checkWarning level: #warning.
	checkDebug level: #debug.
	checkInfo level: #info.
	checkError level: #error.
	severityLabel label: 'Severity Filter'
]

{ #category : #accessing }
MVLogLevelFilterViz >> levels [
	^levels
]

{ #category : #private }
MVLogLevelFilterViz >> removeLevelFrom: aCheck [
	aCheck removeLevel: levels
]

{ #category : #accessing }
MVLogLevelFilterViz >> severityLabel [
	^severityLabel 
]

{ #category : #api }
MVLogLevelFilterViz >> updateLogs [
	filterViz updateLogs
]
