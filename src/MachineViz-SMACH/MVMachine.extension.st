Extension { #name : #MVMachine }

{ #category : #'*MachineViz-SMACH' }
MVMachine >> addNestedMachine: aMVMachine [

	| path |
	path := aMVMachine machineName substrings: '/'.
	self addNestedMachine: aMVMachine withPath: path allButFirst.
]

{ #category : #'*MachineViz-SMACH' }
MVMachine >> addNestedMachine: aMVMachine withPath: aPathAsCollection [
	
	|state|
	
	state := self getStateNamed: aPathAsCollection first.
	
	(aPathAsCollection size = 1) ifTrue: [ 		
		state machine: aMVMachine.
		^self.
	].

	state hasMachine ifTrue: [ 
		state machine addNestedMachine: aMVMachine withPath: aPathAsCollection allButFirst
	]

]

{ #category : #'*MachineViz-SMACH' }
MVMachine >> isSMACHRoot [

	^(self machineName substrings: '/') size = 1.
]
