Class {
	#name : #MVUpdaterTest,
	#superclass : #TestCase,
	#instVars : [
		'updater'
	],
	#category : #'MachineViz-Tests'
}

{ #category : #accessing }
MVUpdaterTest class >> resources [

	^ Array with: MVUpdaterTestResource 
]

{ #category : #initialization }
MVUpdaterTest >> setUp [
	updater := self resources first current updater.
	updater reset.
]

{ #category : #'tests - current state' }
MVUpdaterTest >> testAnotherCurrentState [

	| states |
	states := updater rootMachine allStatesButNone .
	updater step.
	updater step.
	updater step.
	states do:[:state|
		(state stateName = 'simpleState2') 
			ifTrue:[ self assert: state isRunningOnUpdater]
			ifFalse: [ self deny: state isRunningOnUpdater ]
	]
]

{ #category : #'tests - basic' }
MVUpdaterTest >> testBackwardStep [  

	| up |
	up := MVUpdater new.
	up step.
	up backwardStep.
	self assert: up stepPosition equals: 0.
]

{ #category : #'tests - basic' }
MVUpdaterTest >> testBackwardZeroStep [  

	| up |
	up := MVUpdater new.
	up backwardStep.
	self assert: up stepPosition equals: 0.
]

{ #category : #'tests - basic' }
MVUpdaterTest >> testBasicStep [  

	| up |
	up := MVUpdater new.
	up step.
	self assert: up stepPosition equals: 1.
]

{ #category : #'tests - data' }
MVUpdaterTest >> testExecutionTimeComplete [
	
	| state actualExecutionTime |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	1 to: 4 do: [ :i| updater step ].
 	actualExecutionTime := ((updater currentExecutionTimeFromState: state) asMilliSeconds / 10) asInteger.
	
	self assert: actualExecutionTime equals: 25
]

{ #category : #'tests - data' }
MVUpdaterTest >> testExecutionTimeIncomplete [
	
	| state actualExecutionTime |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	1 to: 2 do: [ :i| updater step ].
 	actualExecutionTime := ((updater currentExecutionTimeFromState: state) asMilliSeconds / 10) asInteger.
	
	self assert: actualExecutionTime equals: 19 
]

{ #category : #'tests - data' }
MVUpdaterTest >> testExecutionTimeInitTime [
	
	| state |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	self assert: (updater currentExecutionTimeFromState: state) equals: Duration zero.
]

{ #category : #'tests - data' }
MVUpdaterTest >> testExecutionTimeTwoExecutions [
	
	| state actualExecutionTime |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	1 to: 6 do: [ :i| updater step ].
 	actualExecutionTime := ((updater currentExecutionTimeFromState: state) asMilliSeconds / 10) asInteger.
	
	self assert: actualExecutionTime equals: 39
]

{ #category : #'tests - data' }
MVUpdaterTest >> testExecutionsInitTime [
	
	| state |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	self assert: (updater currentExecutionsFromState: state) size equals: 0.
]

{ #category : #'tests - data' }
MVUpdaterTest >> testExecutionsWithTime [
	
	| state |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	1 to: 7 do: [:i| updater step].
	self assert: (updater currentExecutionsFromState: state) size equals: 2.
]

{ #category : #'tests - time' }
MVUpdaterTest >> testFinishStep [
	
	| up |
	up := MVUpdater new.
	up start.
	1.01 seconds wait.
	up finish.
	1 to: 10 do: [ :i| up step ].
	self assert: up stepPosition equals: 10.
	up step.
	self assert: up stepPosition equals: 11.
	up step.
	self assert: up stepPosition equals: 11.
]

{ #category : #'tests - time' }
MVUpdaterTest >> testInitTime [
	
	| up time |
	up := MVUpdater new.
	time := DateAndTime now.
	up start.
	self assert: up startTime asSeconds equals: time asSeconds 
]

{ #category : #'tests - basic' }
MVUpdaterTest >> testIntegrity [

	| up |
	up := MVUpdater new.
	
	self assert: up stepPosition equals: 0.
]

{ #category : #'tests - data' }
MVUpdaterTest >> testLogsInitTime [
	
	| state |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	self assert: (updater currentLogsFromContainer: state) size equals: 0.
]

{ #category : #'tests - data' }
MVUpdaterTest >> testLogsWithTime [
	
	| state |
	state := updater rootMachine getStateNamed: 'simpleState1'.
	updater step.
	updater step.
	self assert: (updater currentLogsFromContainer: state) size equals: 2.
]

{ #category : #'tests - current state' }
MVUpdaterTest >> testNoCurrentState [

	| state |
	state := updater rootMachine allStatesButNone first.

	self deny: state isRunningOnUpdater.
]

{ #category : #'tests - current state' }
MVUpdaterTest >> testNoCurrentStates [

	| states |
	states := updater rootMachine allStatesButNone .

	self deny: (states anySatisfy: [:st| st isRunningOnUpdater])
]

{ #category : #'tests - time' }
MVUpdaterTest >> testNoStepWithTime [
	
	| up |
	up := MVUpdater new.
	up start.
	
	self assert: up currentStepTime equals: up startTime asDuration
]

{ #category : #'tests - current state' }
MVUpdaterTest >> testOneCurrentState [

	| state |	
	state := updater rootMachine getStateNamed: 'simpleState1'.
	updater step.
	self assert: state isRunningOnUpdater
]

{ #category : #'tests - time' }
MVUpdaterTest >> testOneStepWithTime [
	
	| up |
	up := MVUpdater new.
	up start.
	up step.
	
	self assert: up currentStepTime equals: 0.1 seconds + up startTime
]

{ #category : #'tests - current state' }
MVUpdaterTest >> testOnlyOneCurrentState [

	| states |
	states := updater rootMachine allStatesButNone .
	updater step.
	
	states do:[:state|
		(state stateName = 'simpleState1') 
			ifTrue:[ self assert: state isRunningOnUpdater]
			ifFalse: [ self deny: state isRunningOnUpdater ]
	]
]

{ #category : #'tests - basic' }
MVUpdaterTest >> testReset [ 

	| up |
	up := MVUpdater new.
	up step.
	up reset.
	self assert: up stepPosition equals: 0.
]

{ #category : #'tests - time' }
MVUpdaterTest >> testSeveralStepWithTime [
	
	| up |
	up := MVUpdater new.
	up start.
	up step.
	up step.
	up step.
	
	self assert: up currentStepTime equals: 0.3 seconds + up startTime
]

{ #category : #'tests - time' }
MVUpdaterTest >> testTotalSteps [
	
	| up |
	up := MVUpdater new.
	up start.
	1.01 seconds wait.
	up finish.
	self assert: up totalSteps equals: 11.
]
