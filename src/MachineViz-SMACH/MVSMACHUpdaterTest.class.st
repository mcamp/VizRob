Class {
	#name : #MVSMACHUpdaterTest,
	#superclass : #TestCase,
	#category : #'MachineViz-SMACH'
}

{ #category : #tests }
MVSMACHUpdaterTest >> testOrderMachine [

	| updater machines |
	updater := self updaterWithSeveralMachines.
	machines := updater sortedMachines.
	
	self assert: machines first machineName equals: '/root'.
	self assert: ({machines second machineName . machines third machineName} 
		includes: '/root/nested1' ).
	self assert: ({machines second machineName. machines third machineName} 
		includes: '/root/nested2' ).
	self assert: ({machines fourth machineName. machines fifth machineName} 
		includes: '/root/nested1/stateA' ).
	self assert: ({machines fourth machineName. machines fifth machineName} 
		includes: '/root/nested2/stateB' ).

	self assertCollection: machines hasSameElements: updater machines values. 
]

{ #category : #tests }
MVSMACHUpdaterTest >> testRestructureMachines [

	| updater root machine |
	updater := self updaterWithSeveralMachines.
	updater restructureMachines.
	root := updater rootMachine.
	
	self assert: root machineName equals: '/root'.
	
	self assert: (root getStateNamed: 'nested1') hasMachine.
	self assert: (root getStateNamed: 'nested2') hasMachine.	
	
	machine := (root getStateNamed: 'nested1') machine.
	self assert: (machine getStateNamed: 'stateA') hasMachine.
	
	machine := (root getStateNamed: 'nested2') machine.
	self assert: (machine getStateNamed: 'stateB') hasMachine.
]

{ #category : #data }
MVSMACHUpdaterTest >> updaterWithSeveralMachines [

	| updater m |
	updater := MVSMACHUpdater new.
	m := MVMachine new machineName: '/root'.
	updater machines at: '/root' put: m.
	m addState: (MVState stateName: 'nested1').
	m addState: (MVState stateName: 'nested2').
	
	m := MVMachine new machineName: '/root/nested1/stateA'.
	updater machines at: '/root/nested1/stateA' put: m.

	m := MVMachine new machineName: '/root/nested2/stateB'.
	updater machines at: '/root/nested2/stateB' put: m.
		
	m := MVMachine new machineName: '/root/nested1'.
	updater machines at: '/root/nested1' put: m.
	m addState: (MVState stateName: 'stateA').
			
	m := MVMachine new machineName: '/root/nested2'.
	updater machines at: '/root/nested2' put: m.
	m addState: (MVState stateName: 'stateB').
 	^updater
]
