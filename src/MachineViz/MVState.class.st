Class {
	#name : #MVState,
	#superclass : #MVContainer,
	#instVars : [
		'stateName',
		'incomingTransitions',
		'outgoingTransitions',
		'announcer',
		'machine',
		'statuses',
		'position'
	],
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #'initialize-release' }
MVState class >> stateName: aString [

	^self new 
		stateName: aString;
		yourself.
]

{ #category : #'public - adding' }
MVState >> addIncomingTransition: t [
	incomingTransitions add: t.
	t to: self
]

{ #category : #'public - live' }
MVState >> addLog: aMVLog [
	self lastStatus addLog: aMVLog.
	self hasMachine ifTrue:[
		machine addLogInCurrentStates: aMVLog
	]
	
	
]

{ #category : #'public - adding' }
MVState >> addOutgoingTransition: t [
	outgoingTransitions add: t.
	t from: self
]

{ #category : #accessing }
MVState >> announcer [
	^announcer
]

{ #category : #accessing }
MVState >> connectedTransitions [
	^ self incomingTransitions, self outgoingTransitions
]

{ #category : #'public - live' }
MVState >> executedTimes [
	^self statuses size
]

{ #category : #'private - current state' }
MVState >> finish [
	self lastStatus finish.
	self hasMachine ifTrue: [ 
		machine finish 
	]
]

{ #category : #'public - testing' }
MVState >> hasExecuted [
	^ self statuses isNotEmpty 
]

{ #category : #'public - testing' }
MVState >> hasMachine [
	^machine isNotNil.
]

{ #category : #'public - testing' }
MVState >> ifNone: aBlock [
	self isNone ifTrue: [ aBlock value ]
]

{ #category : #accessing }
MVState >> incomingTransitions [
	^ incomingTransitions
]

{ #category : #initialization }
MVState >> initialize [
	super initialize.
	incomingTransitions := OrderedCollection new.
	outgoingTransitions := OrderedCollection new.
	statuses := MVStateStatusCollection new.
	announcer := Announcer new.
]

{ #category : #'public - testing' }
MVState >> isNone [
	^ self stateName = 'None'
]

{ #category : #'public - testing' }
MVState >> isNotNone [
	^ self isNone not
]

{ #category : #'public - testing' }
MVState >> isRunningOnUpdater [

	| executedStatuses lastStatus |
	executedStatuses := self updater currentExecutionsFromState: self.
	executedStatuses ifEmpty: [ ^false ].
	
	lastStatus := executedStatuses last.
	lastStatus hasFinished ifFalse: [ ^true ].
	^ lastStatus endTime asDuration >= self updater currentStepTime
]

{ #category : #accessing }
MVState >> lastStatus [
	^statuses last.
]

{ #category : #'public - live' }
MVState >> logs [
	^statuses logs
]

{ #category : #accessing }
MVState >> machine [ 
	^machine
]

{ #category : #accessing }
MVState >> machine: aMVMachine [
	machine := aMVMachine.
	machine parent: self.
]

{ #category : #'private - current state' }
MVState >> newStatus [
	| st |
	st := MVStateStatus new.
	st start: self.
	statuses add: st.
]

{ #category : #accessing }
MVState >> outgoingStates [
	"Return the list of states that are referenced by me"
	^ self outgoingTransitions collect: #to
]

{ #category : #accessing }
MVState >> outgoingTransitions [
	^ outgoingTransitions
]

{ #category : #'private - rendering' }
MVState >> popUpInteraction [

	| popup |
	popup := RTPopup new.
	popup
		named: [:model| model stateName ]
		background: Color black
		group: [ :group :el |  
			el model status ifNotNil:[
					group addAll: (RTEllipse elementsOn: (1 to: 10)).
		RTWeightedCircleLayout new
			initialRadius: 50;
			on: group.
			]
 		].		
	
	^popup
	
]

{ #category : #accessing }
MVState >> position [ 
	^position
]

{ #category : #accessing }
MVState >> position: aPoint [
	position := aPoint
]

{ #category : #printing }
MVState >> printOn: aStream [

	aStream nextPutAll: self stateName
]

{ #category : #'public - live' }
MVState >> sortedLogs [
	^self logs sort.
]

{ #category : #'private - current state' }
MVState >> start [
	self newStatus
]

{ #category : #accessing }
MVState >> stateName [
	^ stateName ifNil: [ 'No Name' ]
]

{ #category : #accessing }
MVState >> stateName: anObject [
	stateName := anObject
]

{ #category : #accessing }
MVState >> statuses [
	^statuses.
]

{ #category : #'accessing - updater' }
MVState >> stepExecutedTimes [

	^(self updater currentExecutionsFromState: self) size.
]

{ #category : #'accessing - updater' }
MVState >> stepLogs [

	^self updater currentLogsFromContainer: self.
]

{ #category : #'accessing - updater' }
MVState >> stepTotalTime [

	^self updater currentExecutionTimeFromState: self.
]

{ #category : #'public - live' }
MVState >> totalTime [
	^statuses totalTime
]

{ #category : #'public - visualization' }
MVState >> typeLabel [
	^ 'State'
]

{ #category : #'public - visualization' }
MVState >> vizLabel [
	^self stateName
]
