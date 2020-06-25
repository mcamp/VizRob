Class {
	#name : #MVSMACHUserInterface,
	#superclass : #ComposablePresenter,
	#instVars : [
		'structureLabel',
		'statusLabel',
		'logLabel',
		'structureText',
		'statusText',
		'logText',
		'startButton',
		'stopButton',
		'updater',
		'infoLabel',
		'infoDisplay',
		'unsubscribeProcess',
		'vizrob'
	],
	#category : #'MachineViz-SMACH'
}

{ #category : #specs }
MVSMACHUserInterface class >> defaultSpec [

	^ SpecColumnLayout composed 
		newRow: [ :row| 
			row add: #structureLabel; add: #structureText width: 300
		] height:  self toolbarHeight;
		newRow: [ :row| 
			row add: #statusLabel; add: #statusText	 width: 300
		] height:  self toolbarHeight;
		newRow: [ :row| 
			row add: #logLabel; add: #logText	 width: 300
		] height:  self toolbarHeight;
		addSplitter;
		newRow:  [ :row|
			row add: #startButton; add: #stopButton.	 
		] height: self toolbarHeight; 
		addSplitter;
		newRow:  [ :row|
			row add: #infoDisplay width: self iconDiameter * 2; add: #infoLabel
		] height: self toolbarHeight.
		
]

{ #category : #accessing }
MVSMACHUserInterface class >> iconDiameter [
	^16
]

{ #category : #'world menu' }
MVSMACHUserInterface class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'VizRob SMACH UI')
		order: 0.1; 
		icon: (Smalltalk ui icons iconNamed: #windowIcon);
		label: 'VizRob SMACH UI';
		action:[ self new openWithSpec].
		
	aBuilder withSeparatorAfter.
]

{ #category : #accessing }
MVSMACHUserInterface >> aboutText [
	^aboutText value: 'This is the version of VizRob to use it with SMACH.

For more information, issues and comments, please visit:
github.com/mcamp/VizRob
	
You can also contact me directly to:
mcampusa@dcc.uchile.cl	
	
Any comment, feedback, complain, etc, is welcome ;)
'
]

{ #category : #private }
MVSMACHUserInterface >> checkFinish: time [

	| infoStringOfTopic |
	
	unsubscribeProcess := [
		[ true ] doWhileTrue:[  
			Transcript crLog: 'Checking finish recording from VizRob'.
			infoStringOfTopic := (PhaROSSystemInfo instance infoOfTopic: statusText getText).
			((infoStringOfTopic findString: 'Publishers: None') == 0 ) 
				ifFalse: [ 
					Transcript crLog: 'Automatic finish recording from VizRob'.
					self stopRecording.
					unsubscribeProcess terminate.
				].
			time milliSeconds wait.
			true.
			]
		] fork
]

{ #category : #testing }
MVSMACHUserInterface >> checkTopics [
	
	structureText getText ifEmpty: [^ false].
	statusText getText ifEmpty: [^ false].
	logText getText ifEmpty: [^ false].
	^true.
]

{ #category : #errors }
MVSMACHUserInterface >> errorWhenStart [

	
]

{ #category : #api }
MVSMACHUserInterface >> extent [
	^450@190
]

{ #category : #accessing }
MVSMACHUserInterface >> iconDiameter [
	^self class iconDiameter
]

{ #category : #accessing }
MVSMACHUserInterface >> infoDisplay [
	^ infoDisplay
]

{ #category : #accessing }
MVSMACHUserInterface >> infoDisplay: anObject [
	infoDisplay := anObject
]

{ #category : #accessing }
MVSMACHUserInterface >> infoLabel [
	^ infoLabel
]

{ #category : #accessing }
MVSMACHUserInterface >> infoLabel: anObject [
	infoLabel := anObject
]

{ #category : #'private - status' }
MVSMACHUserInterface >> initState [

	| blackdot |
	blackdot := ColorForm dotOfSize: self iconDiameter.
	infoDisplay image: (ColorForm mappingWhiteToTransparentFrom: blackdot).	
		
	infoLabel label: 'Ready to Connect'.
	stopButton disable.
]

{ #category : #initialization }
MVSMACHUserInterface >> initialize [

	super initialize.
	updater := MVSMACHUpdater new.
	updater viz: self.
]

{ #category : #initialization }
MVSMACHUserInterface >> initializeButtons [
	
	startButton := self newButton.
	startButton label: 'Start'.
	
	stopButton := self newButton.
	stopButton label: 'Stop'.

]

{ #category : #initialization }
MVSMACHUserInterface >> initializePresenter [

	startButton whenActionPerformedDo: [ self startRecording. self openUpdater ].
	stopButton whenActionPerformedDo: [ self stopRecordingAndProcess ].
	
	self whenWindowClosedDo: [ self stopRecordingAndProcess.]
]

{ #category : #initialization }
MVSMACHUserInterface >> initializeStatus [

	infoLabel  := self newLabel.
	infoDisplay := self newImage.	
	
	self initState.
]

{ #category : #initialization }
MVSMACHUserInterface >> initializeTopics [
	structureText := self newTextInput.
	structureText ghostText: '/example/smach/container_structure'.
	structureText autoAccept: true.
	structureLabel := self newLabel.
	structureLabel label: 'Structure Topic'.
	statusText := self newTextInput.
	statusText ghostText: '/example/smach/container_status'.
	statusText autoAccept: true.
	statusLabel := self newLabel.
	statusLabel label: 'Status Update Topic'.
	logText := self newTextInput.
	logText ghostText: '/rosout'.
	logText text: '/rosout'.
	logText autoAccept: true.
	logLabel := self newLabel.
	logLabel label: 'Log Topic'.
	
	structureText text: '/ManipulationObject/smach/container_structure'.
	statusText text: '/ManipulationObject/smach/container_status'
]

{ #category : #initialization }
MVSMACHUserInterface >> initializeWidgets [

	self initializeTopics.
	self initializeButtons.
	self initializeStatus.

]

{ #category : #accessing }
MVSMACHUserInterface >> logLabel [
	^ logLabel
]

{ #category : #accessing }
MVSMACHUserInterface >> logLabel: anObject [
	logLabel := anObject
]

{ #category : #accessing }
MVSMACHUserInterface >> logText [
	^ logText
]

{ #category : #accessing }
MVSMACHUserInterface >> logText: anObject [
	logText := anObject
]

{ #category : #open }
MVSMACHUserInterface >> openUpdater [
	vizrob := MVVizRob new.
	vizrob updater: updater.
	vizrob automaticUpdate: 2.
	vizrob openWithSpec.
]

{ #category : #'private - status' }
MVSMACHUserInterface >> recordingState [
	self stopButton enable.
	self startButton disable.
	
	self updateDisplay: Color yellow.
	self infoLabel label: 'Recording Information'
]

{ #category : #accessing }
MVSMACHUserInterface >> startButton [
	^ startButton
]

{ #category : #accessing }
MVSMACHUserInterface >> startButton: anObject [
	startButton := anObject
]

{ #category : #recording }
MVSMACHUserInterface >> startRecording [
	self checkTopics
		ifFalse: [ ^ self errorWhenStart ].
	self subscribe.
	self checkFinish: 100.
	self recordingState
]

{ #category : #accessing }
MVSMACHUserInterface >> statusLabel [
	^ statusLabel
]

{ #category : #accessing }
MVSMACHUserInterface >> statusLabel: anObject [
	statusLabel := anObject
]

{ #category : #accessing }
MVSMACHUserInterface >> statusText [
	^ statusText
]

{ #category : #accessing }
MVSMACHUserInterface >> statusText: anObject [
	statusText := anObject
]

{ #category : #accessing }
MVSMACHUserInterface >> stopButton [
	^ stopButton
]

{ #category : #accessing }
MVSMACHUserInterface >> stopButton: anObject [
	stopButton := anObject
]

{ #category : #recording }
MVSMACHUserInterface >> stopRecording [
	
	updater ifNotNil: [updater finish].
	self visualizationState.
]

{ #category : #recording }
MVSMACHUserInterface >> stopRecordingAndProcess [
	
	
	self stopRecording.
	unsubscribeProcess ifNotNil:[ unsubscribeProcess  terminate].
]

{ #category : #accessing }
MVSMACHUserInterface >> structureLabel [
	^ structureLabel
]

{ #category : #accessing }
MVSMACHUserInterface >> structureLabel: anObject [
	structureLabel := anObject
]

{ #category : #accessing }
MVSMACHUserInterface >> structureText [
	^ structureText
]

{ #category : #accessing }
MVSMACHUserInterface >> structureText: anObject [
	structureText := anObject
]

{ #category : #recording }
MVSMACHUserInterface >> subscribe [

	updater 
		subscribeStructure: structureText getText;
		subscribeUpdate: statusText getText;
		subscribeLog: logText getText;
		start.
]

{ #category : #api }
MVSMACHUserInterface >> title [
	 ^'VizRob SMACH UI'
]

{ #category : #api }
MVSMACHUserInterface >> update [

	vizrob update
]

{ #category : #'private - status' }
MVSMACHUserInterface >> updateDisplay: aColor [
	| r |
	r := self iconDiameter/2.	
	infoDisplay image replaceColorAt: r@r with: aColor.
	infoDisplay changed: #getImage
]

{ #category : #'private - status' }
MVSMACHUserInterface >> visualizationState [
	
	self stopButton disable.
	self startButton disable.
	
	self updateDisplay: Color green.
	self infoLabel label: 'Ready to Open Visualization'
]

{ #category : #events }
MVSMACHUserInterface >> whenWindowClosedDo: aBlock [
	self whenWindowChanged: [  
		self window whenClosedDo: [
			aBlock value
		].	
	].
]
