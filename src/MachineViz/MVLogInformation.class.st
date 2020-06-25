Class {
	#name : #MVLogInformation,
	#superclass : #ComposablePresenter,
	#instVars : [
		'mvLog',
		'timeLabel',
		'severityLabel',
		'locationLabel',
		'logLabel',
		'functionName'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVLogInformation class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :col | 
			col add: #functionName height: self toolbarHeight.
			col add: #timeLabel height: self toolbarHeight .
			col add: #severityLabel height: self toolbarHeight .
			col add:	#locationLabel height: self toolbarHeight * 2 .
			col add: #logLabel 
		]
]

{ #category : #update }
MVLogInformation >> cleanInformation [

	functionName label: ''.
	locationLabel text: ''.
	logLabel text: ''.
	severityLabel label: ''.
	timeLabel label: ''
]

{ #category : #accessing }
MVLogInformation >> functionName [
	^ functionName
]

{ #category : #accessing }
MVLogInformation >> functionName: anObject [
	functionName := anObject
]

{ #category : #update }
MVLogInformation >> functionUpdate [

	functionName label: ('Program: ', mvLog name).
]

{ #category : #initialization }
MVLogInformation >> initializePresenter [
	
	logLabel whenBuiltDo: [ logLabel color: Smalltalk ui theme baseColor ].
	locationLabel whenBuiltDo: [ locationLabel color: Smalltalk ui theme baseColor ].
	
	
]

{ #category : #initialization }
MVLogInformation >> initializeWidgets [ 

	functionName := self instantiate: MVOverflowLabelPresenter.
	timeLabel := self newLabel.
	severityLabel := self newLabel.
	locationLabel := self newText.
	logLabel := self newText.

	logLabel disable.

	functionName maxSize: 55.
	functionName overflowText: 'Program: ...'.
	functionName overflowLeft.

	
	
]

{ #category : #accessing }
MVLogInformation >> locationLabel [
	^ locationLabel
]

{ #category : #accessing }
MVLogInformation >> locationLabel: anObject [
	locationLabel := anObject
]

{ #category : #update }
MVLogInformation >> locationUpdate [

	locationLabel text: mvLog location
]

{ #category : #accessing }
MVLogInformation >> logLabel [
	^ logLabel
]

{ #category : #accessing }
MVLogInformation >> logLabel: anObject [
	logLabel := anObject
]

{ #category : #update }
MVLogInformation >> logTextUpdate [

	logLabel text: mvLog message.
]

{ #category : #accessing }
MVLogInformation >> mvLog [
	^ mvLog
]

{ #category : #accessing }
MVLogInformation >> mvLog: aMVLog [

	mvLog := aMVLog.
]

{ #category : #accessing }
MVLogInformation >> severityLabel [
	^ severityLabel
]

{ #category : #accessing }
MVLogInformation >> severityLabel: anObject [
	severityLabel := anObject
]

{ #category : #update }
MVLogInformation >> severityUpdate [
	
	severityLabel label: 'Severity: ' , mvLog level.
]

{ #category : #api }
MVLogInformation >> showLog: aMVLog [

	mvLog := aMVLog.
	mvLog ifNil: [ self cleanInformation  . ^ self].
	
	self functionUpdate.
	self timeUpdate.
	self severityUpdate.
	self logTextUpdate.
	self locationUpdate.
]

{ #category : #accessing }
MVLogInformation >> timeLabel [
	^ timeLabel
]

{ #category : #accessing }
MVLogInformation >> timeLabel: anObject [
	timeLabel := anObject
]

{ #category : #update }
MVLogInformation >> timeUpdate [
	timeLabel label: 'Time: ' , mvLog timestamp asStringHMSDMY.
]
