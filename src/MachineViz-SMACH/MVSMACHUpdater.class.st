"
I am in charge of connecting a SMACH program with RobViz

SMACH: http://wiki.ros.org/smach
"
Class {
	#name : #MVSMACHUpdater,
	#superclass : #MVUpdater,
	#instVars : [
		'subscriptionStructure',
		'subscriptionUpdate',
		'subscriptionLog',
		'machines',
		'viz'
	],
	#category : #'MachineViz-SMACH'
}

{ #category : #'sample instances' }
MVSMACHUpdater class >> sample01 [
	<sampleInstance>
	
	^self new 
		subscribeStructure: '/task_viz/smach/container_structure';
		subscribeUpdate: '/task_viz/smach/container_status';
		subscribeLog: '/rosout';
		yourself
]

{ #category : #'sample instances' }
MVSMACHUpdater class >> sample02 [
	"example with nested state machines"
	<sampleInstance>
	
	^self new 
		subscribeStructure: '/clean_house/smach/container_structure';
		subscribeUpdate: '/clean_house/smach/container_status';
		subscribeLog: '/rosout';
		yourself
]

{ #category : #'sample instances' }
MVSMACHUpdater class >> sample03 [
	"pepper manipulation"
	<sampleInstance>
	
	^self new 
		subscribeStructure: '/ManipulationObject/smach/container_structure';
		subscribeUpdate: '/ManipulationObject/smach/container_status';
		subscribeLog: '/rosout';
		yourself
]

{ #category : #'sample instances' }
MVSMACHUpdater class >> sample04 [
	"pepper spr"
	<sampleInstance>
	
	^self new 
		subscribeStructure: '/SPR_SM/smach/container_structure';
		subscribeUpdate: '/SPR_SM/smach/container_status';
		subscribeLog: '/rosout';
		yourself
]

{ #category : #'sample instances' }
MVSMACHUpdater class >> sample05 [
	"concurrence"
	<sampleInstance>
	
	^self new 
		subscribeStructure: '/patrol/smach/container_structure';
		subscribeUpdate: '/patrol/smach/container_status';
		subscribeLog: '/rosout';
		yourself
]

{ #category : #private }
MVSMACHUpdater >> addLogFromMsg: aMsg [
	
	| log |
	log := MVLog new.
	log name: aMsg name.
	log message: aMsg msg.
	log functionName: aMsg function.
	log codeLine: aMsg line.
	log levelFromNumber: aMsg level.
	log timestamp: aMsg header stamp timestamp.
	log fileName: aMsg file.
	
	self addLog: log
]

{ #category : #private }
MVSMACHUpdater >> addMachineFromSMACH: rosMsg [

	| machine |
	machine := self createMachineFromSMACH: rosMsg.
	machines at: machine machineName put: machine.
	self restructureMachines
]

{ #category : #private }
MVSMACHUpdater >> connectSubscriptions [
	subscriptionLog connect.
	subscriptionStructure connect.
	subscriptionUpdate connect.
]

{ #category : #private }
MVSMACHUpdater >> createMachineFromSMACH: aMsg [
	|machine|
	machine := MVMachine new fromCSV: (MVSerializationAsCSV new serialize: aMsg) contents.
	^machine
]

{ #category : #private }
MVSMACHUpdater >> createOrDiscardMachineFromSMACH: rosMsg [

	self ifHasNotMachineNamed: rosMsg path do:[
		self addMachineFromSMACH: rosMsg.
	]
	
]

{ #category : #api }
MVSMACHUpdater >> finish [
	super finish.
]

{ #category : #testing }
MVSMACHUpdater >> hasMachineNamed: aString [

	^machines includesKey: aString
]

{ #category : #controlling }
MVSMACHUpdater >> ifHasNotMachineNamed: aString do: aBlock [

	(self hasMachineNamed: aString) ifFalse: aBlock.
]

{ #category : #initialization }
MVSMACHUpdater >> initialize [
	super initialize.
	
	machines := Dictionary new.
]

{ #category : #accessing }
MVSMACHUpdater >> machines [
	^machines
]

{ #category : #private }
MVSMACHUpdater >> restructureMachines [

	| sortedMachines |
	sortedMachines := self sortedMachines.
	
	sortedMachines first isSMACHRoot 
		ifTrue: [self addRootMachine: sortedMachines first]
		ifFalse: [ ^self ].

	sortedMachines allButFirstDo: [ :m | 
		rootMachine addNestedMachine: m
	].
	


	

	
]

{ #category : #private }
MVSMACHUpdater >> setCurrentStateFromMsg: aMsg [

	| machine |
	machine := self machines at: aMsg path ifAbsent:[^self].
	machine setCurrentStatesNamed: aMsg active_states.
	
]

{ #category : #accessing }
MVSMACHUpdater >> sortedMachines [
	"all machines sorted by nested level"
	^machines values sorted: [ :a :b| 
		(a machineName substrings: '/') size < (b machineName substrings: '/') size
	]
]

{ #category : #api }
MVSMACHUpdater >> startCallbacks [
	super startCallbacks.
	self connectSubscriptions.
]

{ #category : #subscriptions }
MVSMACHUpdater >> subscribeLog: aTopicAsString [
	
	subscriptionLog := (PhaROSPackage new controller node buildConnectionFor: aTopicAsString)
		typedAs: 'rosgraph_msgs/Log';
		for: [ :msg|
			self finished ifFalse:[
				self addLogFromMsg: msg	
			]
		];
		yourself
]

{ #category : #subscriptions }
MVSMACHUpdater >> subscribeStructure: aTopicAsString [

	subscriptionStructure := (PhaROSPackage new controller node buildConnectionFor: aTopicAsString)
		typedAs: 'smach_msgs/SmachContainerStructure';
		for: [:msg|
			self finished ifFalse:[
				self createOrDiscardMachineFromSMACH: msg.
			]
		];
		yourself.
]

{ #category : #subscriptions }
MVSMACHUpdater >> subscribeUpdate: aTopicAsString [
	
	subscriptionUpdate := (PhaROSPackage new controller node buildConnectionFor: aTopicAsString)
		typedAs: 'smach_msgs/SmachContainerStatus';
		for: [ :msg|
			self finished ifFalse:[
				rootMachine ifNotNone: [   
					self setCurrentStateFromMsg: msg.
				]
			]
		];
		yourself
]

{ #category : #api }
MVSMACHUpdater >> updateViz [

	viz ifNotNil: [viz update]
]

{ #category : #accessing }
MVSMACHUpdater >> viz [
	^ viz
]

{ #category : #accessing }
MVSMACHUpdater >> viz: anObject [
	viz := anObject
]
