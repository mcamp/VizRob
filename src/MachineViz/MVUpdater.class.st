"
I am an abstract class that connects FSM programs with RobViz visualization
"
Class {
	#name : #MVUpdater,
	#superclass : #Object,
	#instVars : [
		'rootMachine',
		'logs',
		'finished',
		'started',
		'stepPosition',
		'startTime',
		'stepDuration',
		'finishTime'
	],
	#category : #'MachineViz-Updater'
}

{ #category : #adding }
MVUpdater >> addLog: aMVLog [

	aMVLog receivedTime: DateAndTime now.
	logs add: aMVLog.
	rootMachine ifNotNil: [ rootMachine addLogInCurrentStates: aMVLog ].
	
	
]

{ #category : #adding }
MVUpdater >> addRootMachine: aMVMachine [
	rootMachine := aMVMachine.
	rootMachine updater: self.
	
	"
	When there are too many logs, this literally freeze everything.
	We need to fix that first before showing all logs prior the building of the machine"
	self flag: #TODO 
	"rootMachine addAllLogs: self logs."
]

{ #category : #'stepping ' }
MVUpdater >> backwardStep [
	(stepPosition > 0 ) ifTrue: [ stepPosition := stepPosition - 1 ]
]

{ #category : #api }
MVUpdater >> currentExecutionTimeFromState: aMVState [

	| executionsFromState stateTime lastExecution |
	executionsFromState := (self currentExecutionsFromState: aMVState).
	executionsFromState ifEmpty:[ ^Duration zero].
	stateTime := executionsFromState sum: [ :aMVStatus| aMVStatus totalTime].
	lastExecution := executionsFromState last.  
	(self currentStepTime < lastExecution endTime) ifTrue:[
		stateTime := stateTime - (lastExecution endTime asDuration - self currentStepTime asDuration)	
	].
	
	^stateTime 
	
]

{ #category : #api }
MVUpdater >> currentExecutionsFromState: aMVState [

	^aMVState statuses select: [ :aMVStatus| aMVStatus startTime asDuration <= self currentStepTime ]
]

{ #category : #api }
MVUpdater >> currentLogsFromContainer: aMVMachineOrState [

	^aMVMachineOrState sortedLogs select: [ :aMVLog| aMVLog receivedTime asDuration <= self currentStepTime ]
]

{ #category : #'stepping ' }
MVUpdater >> currentStep: aNumber [
	(aNumber >= 0 or: [aNumber <= self totalSteps])
		ifTrue:[ stepPosition := aNumber]
]

{ #category : #'stepping ' }
MVUpdater >> currentStepTime [

	^self stepDuration * self stepPosition + self startTime
	
]

{ #category : #api }
MVUpdater >> finish [

	self rootMachine ifNotNil: [self rootMachine finish].
	finished := true.
	finishTime := DateAndTime now.
]

{ #category : #accessing }
MVUpdater >> finishTime [
	self finished ifFalse: [ ^ DateAndTime now ].
	^ finishTime
]

{ #category : #accessing }
MVUpdater >> finishTime: anObject [
	finishTime := anObject
]

{ #category : #accessing }
MVUpdater >> finished [
	^ finished
]

{ #category : #accessing }
MVUpdater >> finished: aBoolean [
	finished := aBoolean
]

{ #category : #initialization }
MVUpdater >> initialize [
	super initialize.
	logs := MVLogCollection new.
	started := false.
	finished := false.
	stepPosition := 0.
	stepDuration := 0.1 seconds.
	rootMachine := MVNoneMachine new.
]

{ #category : #accessing }
MVUpdater >> logs [
	^logs
]

{ #category : #'stepping ' }
MVUpdater >> maxStep [

	self currentStep: self totalSteps.
]

{ #category : #'stepping ' }
MVUpdater >> reset [
	stepPosition := 0
]

{ #category : #accessing }
MVUpdater >> rootMachine [
	^rootMachine
]

{ #category : #accessing }
MVUpdater >> rootMachine: aMVMachine [
	rootMachine := aMVMachine
]

{ #category : #api }
MVUpdater >> start [
	self started ifFalse:[
		startTime := DateAndTime now.
		self startCallbacks.
		started := true.
	]
	
]

{ #category : #callbacks }
MVUpdater >> startCallbacks [
	rootMachine ifNotNil: [rootMachine hasStarted: true].
]

{ #category : #accessing }
MVUpdater >> startTime [
	^ startTime
]

{ #category : #accessing }
MVUpdater >> startTime: anObject [
	startTime := anObject
]

{ #category : #accessing }
MVUpdater >> started [
	^ started
]

{ #category : #accessing }
MVUpdater >> started: anObject [
	started := anObject
]

{ #category : #'stepping ' }
MVUpdater >> step [
	(self finished and:[ (self stepPosition >= self totalSteps) ])
		ifFalse: [ stepPosition := stepPosition + 1 ]
]

{ #category : #accessing }
MVUpdater >> stepDuration [
	^ stepDuration
]

{ #category : #accessing }
MVUpdater >> stepDuration: anObject [
	stepDuration := anObject
]

{ #category : #accessing }
MVUpdater >> stepPosition [
	^ stepPosition
]

{ #category : #accessing }
MVUpdater >> stepPosition: anObject [
	stepPosition := anObject
]

{ #category : #'stepping ' }
MVUpdater >> totalSteps [ 
	
	^((self finishTime - self startTime) / self stepDuration)asInteger + 1
]
