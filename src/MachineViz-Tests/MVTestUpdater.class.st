Class {
	#name : #MVTestUpdater,
	#superclass : #MVUpdater,
	#category : #'MachineViz-Tests'
}

{ #category : #example }
MVTestUpdater class >> example [
	<sampleInstance>
	| u machine logs startTime currentTime currentState lastState log|
	u := self new.
	machine := MVStateMachineTest new nestedMachine.
	machine updater: u.
	logs := MVLogTest new logs.
	
	u rootMachine: machine.
	machine updater: u.
	u start.
	startTime := u startTime.
	
	currentTime := startTime + 0.01 seconds.
	currentState := machine getStateNamed: 'simpleState1'.
	u rootMachine setCurrentStateNamed: 'simpleState1'.
	currentState lastStatus startTime: currentTime.
	currentTime := currentTime + 0.05 seconds.
	log := logs first.
	u addLog: log.
	log receivedTime: currentTime.
	currentTime := currentTime + 0.1 seconds.
	log := logs second.
	u addLog: log.
	log receivedTime: currentTime.
	
	currentTime := currentTime + 0.1 seconds.
	lastState := currentState.
	
	currentState := machine getStateNamed: 'simpleState2'.
	u rootMachine setCurrentStateNamed: 'simpleState2'.
	lastState lastStatus endTime: currentTime.
	currentState lastStatus startTime: currentTime.
	currentTime :=	currentTime + 0.1 seconds.
	log := logs third.
	u addLog: log.
	log receivedTime: currentTime.
	
	currentTime :=	currentTime + 0.1 seconds.
	lastState := currentState.
	
	currentState := machine getStateNamed: 'simpleState1'.
	u rootMachine setCurrentStateNamed: 'simpleState1'.
	lastState lastStatus endTime: currentTime.
	currentState lastStatus startTime: currentTime.
	currentTime :=	currentTime + 0.1 seconds.
	log := logs fourth.
	u addLog: log.
	log receivedTime: currentTime.
	currentTime :=	currentTime + 0.1 seconds.
	log := logs fifth.
	u addLog: log.
	log receivedTime: currentTime.
	currentTime :=	currentTime + 0.1 seconds.
	u finish.
	currentState lastStatus endTime: currentTime.
	u finishTime: currentTime.
	^u.
]
