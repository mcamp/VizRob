Class {
	#name : #MVVizRob,
	#superclass : #ComposablePresenter,
	#instVars : [
		'machineViz',
		'logsViz',
		'updater',
		'selectedContainer',
		'updateTask'
	],
	#category : #'MachineViz-Visualization'
}

{ #category : #specs }
MVVizRob class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed 
		newRow: [ :trow|
			trow add: #machineViz left: 0 right: 0.45.
			trow addSplitter.
			trow add: #logsViz left: 0.55 right: 0.	
		]
]

{ #category : #updater }
MVVizRob >> automaticUpdate: secondAsNumber [

	updateTask ifNil: [ 
		updateTask:= [  
			[ self updater finished] whileFalse:[
				self update.
				secondAsNumber seconds wait.
			].
			self update.
		] fork.
	].
]

{ #category : #api }
MVVizRob >> extent [
	 ^1200@600
]

{ #category : #testing }
MVVizRob >> followedExecution [

	^self machineViz followedExecution
]

{ #category : #initialization }
MVVizRob >> initializeWidgets [ 

	machineViz := self instantiate: MVVizRobMachine.
	logsViz := self instantiate: MVLogVisualization.
	
]

{ #category : #accessing }
MVVizRob >> logsViz [
	^ logsViz
]

{ #category : #accessing }
MVVizRob >> logsViz: anObject [
	logsViz := anObject
]

{ #category : #api }
MVVizRob >> logsVizUpdate: updateAllBoolean [

	updateAllBoolean ifFalse:[^ self].
	
	self logsViz logContainer: selectedContainer.
	self updateLogs.
]

{ #category : #accessing }
MVVizRob >> machineViz [
	^ machineViz
]

{ #category : #accessing }
MVVizRob >> machineViz: anObject [
	machineViz := anObject
]

{ #category : #api }
MVVizRob >> machineVizUpdate: updateAllBoolean [

	machineViz update: updateAllBoolean.
]

{ #category : #accessing }
MVVizRob >> selectedContainer [
	^ selectedContainer
]

{ #category : #accessing }
MVVizRob >> selectedContainer: anObject [
	selectedContainer := anObject.
	self logsViz logContainer: anObject.
	self updaterSignal.
]

{ #category : #api }
MVVizRob >> title [ 
	^'VizRob'
]

{ #category : #api }
MVVizRob >> update [
	| firstUpdate updateAll |
	firstUpdate := false.
	selectedContainer
		ifNone: [ updater rootMachine ifNone: [ ^ self ].
			selectedContainer := updater rootMachine.
			firstUpdate := true 
		].
		
	updateAll := firstUpdate or: [ self followedExecution ].

	self machineVizUpdate: updateAll.
	self logsVizUpdate: updateAll.
]

{ #category : #updater }
MVVizRob >> updateLogs [

	logsViz logs: (updater currentLogsFromContainer: self selectedContainer).
]

{ #category : #accessing }
MVVizRob >> updater [
	^ updater
]

{ #category : #accessing }
MVVizRob >> updater: anObject [
	updater := anObject.
	self selectedContainer: updater rootMachine.
	machineViz updater: updater.

]

{ #category : #updater }
MVVizRob >> updaterSignal [

	self updateLogs.
]
