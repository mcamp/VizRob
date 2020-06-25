Class {
	#name : #MVStateMachineTest,
	#superclass : #TestCase,
	#instVars : [
		'm'
	],
	#category : #'MachineViz-Tests'
}

{ #category : #data }
MVStateMachineTest >> machineAsCSV [
	^ 'children	WaitingForCallerRetrieving WaitBeforeMovingInit AskObject MoveBackWithObject AskDestination BeforeAskDestination ConfirmFromCaller GoToCaller NotifyGoingCaller GoToDestination AskForAnotherObject MoveBackWithoutObject ResetRobot MoveInit sm_retrieval WaitForActivity
container_outcomes	preempted invalid
header	223  2017-04-03T16:48:09.765109062-03:00
internal_outcomes	valid preempted invalid continue valid preempted invalid preempted aborted succeeded valid preempted invalid hasDestination askDestination valid preempted invalid preempted aborted succeeded continue preempted aborted succeeded valid preempted invalid preempted aborted succeeded continue preempted aborted succeeded preempted noReply invalid replyWithObject replyWithoutObject valid preempted invalid
outcomes_from	WaitingForCallerRetrieving WaitingForCallerRetrieving WaitingForCallerRetrieving WaitBeforeMovingInit AskObject AskObject AskObject MoveBackWithObject MoveBackWithObject MoveBackWithObject AskDestination AskDestination AskDestination BeforeAskDestination BeforeAskDestination ConfirmFromCaller ConfirmFromCaller ConfirmFromCaller GoToCaller GoToCaller GoToCaller NotifyGoingCaller GoToDestination GoToDestination GoToDestination AskForAnotherObject AskForAnotherObject AskForAnotherObject MoveBackWithoutObject MoveBackWithoutObject MoveBackWithoutObject ResetRobot MoveInit MoveInit MoveInit sm_retrieval sm_retrieval sm_retrieval sm_retrieval sm_retrieval WaitForActivity WaitForActivity WaitForActivity
outcomes_to	AskForAnotherObject None None MoveInit BeforeAskDestination None None None WaitingForCallerRetrieving WaitingForCallerRetrieving ConfirmFromCaller None None ConfirmFromCaller AskDestination GoToDestination None AskObject None AskObject AskObject GoToCaller None sm_retrieval sm_retrieval ResetRobot None WaitBeforeMovingInit None AskForAnotherObject AskForAnotherObject AskObject None WaitForActivity WaitForActivity None WaitBeforeMovingInit None MoveBackWithObject MoveBackWithoutObject NotifyGoingCaller None None
path	Task1
'
]

{ #category : #data }
MVStateMachineTest >> nestedMachine [

	| machine state s1 s2 tx |
	machine := MVMachine new.
	machine machineName: 'first'.
	state := MVState stateName: 'stateWithMachine'.
	machine addState: (MVState stateName: 'simpleState1' ).
	machine addState: (MVState stateName: 'simpleState2' ).
	machine addState: state.
	
	state machine: MVMachine new.
	state machine machineName: 'second'.
	s1 := MVState stateName: 'state1'.
	s2 := MVState stateName: 'state2'.
	state machine addState: s1.
	state machine addState: s2.
	
	tx := MVTransition new.
	s1 addOutgoingTransition: tx.
	s2 addIncomingTransition: tx.

	^machine.
]

{ #category : #initialization }
MVStateMachineTest >> setUp [
	super setUp.
	m := MVMachine new
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testAddingNone [

	| s |
	s := m getOrCreateStateNamed: 'None'.
	self assert: m numberOfStates equals: 1.
	self assert: m numberOfNotNoneStates equals: 0.
	
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testAddingState [

	| s |
	self assert: m numberOfStates equals: 0.
	s := MVState new stateName: 'foo'.
	m addState: s.
	self assert: m numberOfStates equals: 1.
	self assert: m states size equals: 1.
	self assert: m states anyOne equals: s.
	
	self assert: (m getStateNamed: 'foo') equals: s.
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testBasic [
	self assert: m numberOfStates equals: 0.
	self assert: m numberOfTransitions equals: 0.
	self assert: m machineName equals: 'Unamed'.
	
	self deny: m hasStarted.
	self deny: m hasFinished.
	self assert: m currentStates isEmpty.
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testBasicTransition [
	| t |
	t := MVTransition new.
	self assert: t transitionName equals: 'Unamed'.
	self assert: t from isNil.
	self assert: t to isNil.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testCoverage [

	| state |
	m := self nestedMachine.
	state := m states first.
	m setCurrentState: state.
	
	self assert: m allExecutedStates size equals: 1.
	self assert: m allExecutedStates first equals: state
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testExecutedState [

	| state |
	m := self nestedMachine.
	state := m states first.
	m setCurrentState: state.
	
	self assert: state hasExecuted.
	self deny: m states second hasExecuted.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testFrecuency [

	| state1 state2 |
	m := self nestedMachine.
	state1 := m states first.
	state2 := m states second.
	
	self assert: state1 executedTimes equals: 0.

	m setCurrentState: state1.
	
	self assert: state1 executedTimes equals: 1.	
	self assert: state2 executedTimes equals: 0.
	
	m setCurrentState: state2.
	
	self assert: state1 executedTimes equals: 1.	
	self assert: state2 executedTimes equals: 1.
	
	m setCurrentState: state1.
	
	self assert: state1 executedTimes equals: 2.	
	self assert: state2 executedTimes equals: 1.
	
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testFrecuencyTime [

	| state1 state2 |
	m := self nestedMachine.
	state1 := m states first.
	state2 := m states second.
	
	self assert: state1 executedTimes equals: 0.

	m setCurrentState: state1.
	1 second wait.
	m setCurrentState: state2.
	self assert: state1 totalTime seconds equals: 1.
	
	1 second wait.
	m setCurrentState: state1.
	1 second wait.
	
	m finish.

	self assert: state1 totalTime seconds equals: 2.
	
]

{ #category : #'tests - serialization' }
MVStateMachineTest >> testFromCSV [

	m fromCSV: self machineAsCSV.
	self assert: m numberOfStates equals: 17.
	self assert: m numberOfTransitions equals: 43. 
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testGetOrCreateStateNamed [

	| s |
	self assert: m numberOfStates equals: 0.
	s := m getOrCreateStateNamed: 'foo'.
	self assert: m numberOfStates equals: 1.
	self assert: m states size equals: 1.
	self assert: m states anyOne equals: s.
	
	self assert: s stateName equals: 'foo'.
	
	self assert: (m getOrCreateStateNamed: 'foo') == s
]

{ #category : #'tests - nested' }
MVStateMachineTest >> testNestedMachineWithStates [
	
	| machine stateWithMachine  nestedMachine |
	machine := self nestedMachine.
	stateWithMachine := machine getStateNamed: 'stateWithMachine'.
	nestedMachine := stateWithMachine machine.
	
	self assert: nestedMachine numberOfStates equals: 2.
	self assert: nestedMachine numberOfTransitions equals: 1.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testNewStatus [

	| state |
	m := self nestedMachine.
	state := m states first.
	state newStatus.
	
	self assert: m states first statuses size equals: 1
]

{ #category : #'tests - continuous data' }
MVStateMachineTest >> testNoFinishStatusTime [

	| state |
	m := self nestedMachine.
	state := m states first.
	state start.
	1 seconds wait.

	self assert: state totalTime seconds equals: 1
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testNoStatuses [

	m := self nestedMachine.
	
	self assert: m states first statuses size equals: 0
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testNoneState [

	| s |
	s := MVState new stateName: 'None'.
	self assert: s isNone.
	self deny: s isNotNone.
	
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testNoneState02 [

	| s |
	s := MVState new stateName: 'Blah'.
	self deny: s isNone.
	self assert: s isNotNone.
	
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testOrderedLog [

	| state sortedLogs |
	m := self nestedMachine.
	state := m states first.
	state newStatus.
	state addLog:(MVLog new functionName: 'Second'; timestamp: (DateAndTime year: 2019 month: 3 day: 26 hour: 6 minute: 55)).
	state addLog:(MVLog new functionName: 'First'; timestamp: (DateAndTime year: 2019 month: 3 day: 26 hour: 6 minute: 50)).
	
	sortedLogs := m states first sortedLogs asArray.
	self assert: sortedLogs size equals: 2.
	self assertCollection: (sortedLogs collect:[:log| log functionName]) equals: #('First' 'Second')
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testSimpleConstruction [
	| s1 tab s2 |
	s1 := MVState new.
	s1 stateName: 'a'.
	
	tab := MVTransition new.
	tab transitionName: 't'.

	s1 addIncomingTransition: tab.
	
	self assert: s1 incomingTransitions size equals: 1.
	self assert: s1 incomingTransitions asArray equals: { tab }.
	self assert: tab from isNil.
	self assert: tab to equals: s1.
	
	s2 := MVState new.
	s2 stateName: 'b'.
	
	m addState: s1.
	self assert: m numberOfStates equals: 1.
	self assert: m numberOfTransitions equals: 1.

	s2 addOutgoingTransition: tab.
	m addState: s2.
	self assert: m numberOfStates equals: 2.
	self assert: m numberOfTransitions equals: 1.
	
]

{ #category : #'tests - basic' }
MVStateMachineTest >> testSimpleConstruction02 [
	| s1 tab s2 s3 tbc |
	s1 := MVState new.
	s1 stateName: 'a'.
	s2 := MVState new.
	s2 stateName: 'b'.
	s3 := MVState new.
	s3 stateName: 'c'.
	
	tab := MVTransition new.
	tab transitionName: 't1'.
	tbc := MVTransition new.
	tbc transitionName: 't2'.
	s1 addOutgoingTransition: tab.
	s2 addIncomingTransition: tab.
	s2 addOutgoingTransition: tbc.
	s3 addIncomingTransition: tbc.
	
	m addState: s1.
	m addState: s2.
	m addState: s3.

	self assert: m numberOfStates equals: 3.
	self assert: m numberOfTransitions equals: 2.
	
	self assert: s1 outgoingStates asArray equals: { s2 }.
	self assert: s2 outgoingStates asArray equals: { s3 }.	
	self assert: s3 outgoingStates isEmpty.

]

{ #category : #'tests - nested' }
MVStateMachineTest >> testStateWithMachine [
	
	| machine stateWithMachine stateWithoutMachine |
	machine := self nestedMachine.
	stateWithMachine := machine getStateNamed: 'stateWithMachine'.
	stateWithoutMachine := machine getStateNamed: 'simpleState1'.
	
	self assert: stateWithMachine hasMachine.
	self deny: stateWithoutMachine hasMachine.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testStatusLog [

	| state |
	m := self nestedMachine.
	state := m states first.
	state newStatus.

	self assert: m states first logs size equals: 0.
	
	state addLog:(MVLog new message: 'First Log').
	state addLog:(MVLog new message: 'Second Log').
		
	self assert: m states first logs size equals: 2.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testStatusNestedLog [

	| state |
	m := self nestedMachine.
	state := m states first.
	state start.
	state machine setCurrentStateNamed: 'state1'.
	
	self assert: state logs size equals: 0.
	self assert: state machine currentStates first logs size equals: 0.
	
	state addLog:(MVLog new message: 'First Log').
	state addLog:(MVLog new message: 'Second Log').
		
	self assert: state logs size equals: 2.
	self assert: state machine currentStates first logs size equals: 2.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testStatusNestedTime [

	| state |
	m := self nestedMachine.
	state := m states first.
	state start.
	state machine setCurrentStateNamed: 'state1'.
	
	1 seconds wait.
	state finish.

	self assert: state totalTime seconds equals: 1.
	self assert: state machine states first totalTime seconds equals: 1
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testStatusOnCurrentState [

	| state |
	m fromCSV: self machineAsCSV.
	m setCurrentStateNamed: 'WaitForActivity'.
	
	state := (m getStateNamed: 'WaitForActivity').
	self assert: state statuses size equals: 1.
	
	self assert: (m states select: [:st| st statuses isEmpty not]) size equals: 1.
	
	m setCurrentStateNamed: 'WaitForActivity'.
	self assert: state statuses size equals: 1.
]

{ #category : #'tests - static data' }
MVStateMachineTest >> testStatusTime [

	| state |
	m := self nestedMachine.
	state := m states first.
	state start.
	1 seconds wait.
	state finish.

	self assert: state totalTime seconds equals: 1
]
