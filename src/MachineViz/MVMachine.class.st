Class {
	#name : #MVMachine,
	#superclass : #MVContainer,
	#instVars : [
		'machineName',
		'stateDict',
		'transitions',
		'hasStarted',
		'hasFinished',
		'currentStates',
		'announcer',
		'isDrawn',
		'logs'
	],
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #'instance creation' }
MVMachine class >> create: aName [
	^self new machineName: aName
]

{ #category : #'sample instances' }
MVMachine class >> sample01 [
	< sampleInstance >
	
	^self new fromCSV: MVStateMachineTest new machineAsCSV
]

{ #category : #adding }
MVMachine >> addAllLogs: aMVLogCollection [
	logs addAll: aMVLogCollection
]

{ #category : #private }
MVMachine >> addCurrentState: aMVState [

	(currentStates includes: aMVState) ifTrue: [ ^self ].
	(aMVState ifNone: [^self]).
	
	announcer
		announce:
			(MVChangedCurrentState new
				currentState: aMVState;
				yourself).
	
	aMVState start.
	currentStates add: aMVState
]

{ #category : #adding }
MVMachine >> addLog: aMVLog [
	logs add: aMVLog
]

{ #category : #public }
MVMachine >> addLogInCurrentStates: aMVLog [

	currentStates
		"ifEmpty: [ self addLog: aMVLog ]"
		ifNotEmpty: [ currentStates do: [:st| st addLog: aMVLog ]]
]

{ #category : #'private - rendering' }
MVMachine >> addMenuOnView: aView [

	aView
		addMenu: 'Toggle Nested Machine Border'
		callback: [ self toggleNSMBorderOnView: aView ].
		
	aView
		addMenu: 'Toggle Coverage'
		callback: [ self toggleCoverageOnView: aView]
]

{ #category : #public }
MVMachine >> addState: aMVState [
	stateDict at: aMVState stateName put: aMVState.
	aMVState parent: self.
]

{ #category : #public }
MVMachine >> addStates: aMVStateCollection [
	aMVStateCollection do:[:aState| stateDict at: aState stateName put: aState]
]

{ #category : #public }
MVMachine >> allExecutedStates [
	^ self allStatesButNone select: [ :st | st hasExecuted ]
]

{ #category : #public }
MVMachine >> allLogs [
	
	| allLogs |
	allLogs := self stateLogs.
	allLogs addAll: logs.
	^ allLogs
]

{ #category : #public }
MVMachine >> allNonExecutedStates [
	^ self allStatesButNone select: [ :st | st hasExecuted not]
]

{ #category : #accessing }
MVMachine >> allStatesButNone [
	^ self states select: #isNotNone
]

{ #category : #accessing }
MVMachine >> announcer [
	^announcer
]

{ #category : #'private - rendering' }
MVMachine >> arrowedLineOn: aRTMondrian [

	| arrowedLine |
	arrowedLine := RTArrowedLine new.
	arrowedLine 	head size: 8.
	arrowedLine 	
		headOffset: 0.9;
		withShorterDistanceAttachPoint.
	aRTMondrian shape: arrowedLine.
	aRTMondrian shape color: Color blue trans.
	aRTMondrian edges source: self transitions connectFrom: #from to: #to.
]

{ #category : #accessing }
MVMachine >> currentStates [
	^currentStates
]

{ #category : #example }
MVMachine >> example01 [
	<script: 'self new example01 inspect'>

	^ MVMachine new fromCSV: MVStateMachineTest new machineAsCSV
]

{ #category : #'private - callback' }
MVMachine >> finish [
	currentStates do: [:st| st finish ]
]

{ #category : #serialization }
MVMachine >> fromCSV: aString [
	| lines d transitionNames outgoingStateNames incomingStateNames tName outgoing incoming oState iState t |
	lines := aString lines.
	d := (lines collect: [ :l | | ss | ss := l substrings: String tab. ss first -> ((ss size = 1) ifTrue: [nil] ifFalse: [ss second]) ]) asDictionary.
	self machineName: (d at: #path).
	
	(d at: #children) ifNil: [ ^self ].
	(d at: #children) substrings do: [:st| self getOrCreateStateNamed: st  ].
	(d at: #internal_outcomes) ifNil: [ ^self ].
	
	transitionNames := (d at: #internal_outcomes) substrings.
	outgoingStateNames := (d at: #outcomes_from) substrings.
	incomingStateNames := (d at: #outcomes_to) substrings.

	self assert: [ transitionNames size = outgoingStateNames size ].
	self assert: [ transitionNames size = incomingStateNames size ].
	
	1 to: transitionNames size do: [ :index |
		tName := transitionNames at: index.
		outgoing := outgoingStateNames at: index.
		incoming := incomingStateNames at: index.
		oState := self getOrCreateStateNamed: outgoing.
		iState := self getOrCreateStateNamed: incoming.
		t := MVTransition new.
		t transitionName: tName.
		oState addOutgoingTransition: t.
		iState addIncomingTransition: t
	]
]

{ #category : #accessing }
MVMachine >> getOrCreateStateNamed: aName [
	"Return a state named aName. If the state is not in the machine, then it is created"
	^ (stateDict includesKey: aName)
		ifTrue: [ self getStateNamed: aName ]
		ifFalse: [ | s | s := MVState new stateName: aName. self addState: s. s ]
]

{ #category : #accessing }
MVMachine >> getStateNamed: aName [
	(aName = 'None') ifTrue: [^MVNoneState new ].
	^ stateDict at: aName
]

{ #category : #accessing }
MVMachine >> hasFinished [
	^ hasFinished
]

{ #category : #accessing }
MVMachine >> hasFinished: aBoolean [
	hasFinished := aBoolean
]

{ #category : #accessing }
MVMachine >> hasStarted [
	^ hasStarted
]

{ #category : #accessing }
MVMachine >> hasStarted: aBoolean [
	hasStarted := aBoolean
]

{ #category : #initialization }
MVMachine >> initialize [
	super initialize.
	machineName := 'Unamed'.
	stateDict := Dictionary new.
	hasStarted := false.
	hasFinished := false.
	currentStates := OrderedCollection new.
	logs := MVLogCollection new.
	announcer := Announcer new.
	isDrawn := false.
	
]

{ #category : #accessing }
MVMachine >> isDrawn [
	^isDrawn
]

{ #category : #accessing }
MVMachine >> isDrawn: aBoolean [
	isDrawn := aBoolean
]

{ #category : #'private - rendering' }
MVMachine >> layoutOn: aRTMondrian [

	aRTMondrian layout force charge: -2000.
]

{ #category : #accessing }
MVMachine >> machineName [
	^ machineName
]

{ #category : #accessing }
MVMachine >> machineName: nameAsString [
	machineName := nameAsString
]

{ #category : #'private - rendering' }
MVMachine >> normalizeHeight: aBlock on: aRTMondrian [

	aRTMondrian normalizer normalizeHeight: aBlock min: 10 max: 40.
]

{ #category : #'private - rendering' }
MVMachine >> normalizeLogs: aRTMondrian [

	self normalizeWidth: [ :n| n stepLogs size] on: aRTMondrian.
]

{ #category : #'private - rendering' }
MVMachine >> normalizeTime: aRTMondrian [

	self normalizeHeight: [ :n | n stepTotalTime ]  on: aRTMondrian.
]

{ #category : #'private - rendering' }
MVMachine >> normalizeWidth: aBlock on: aRTMondrian [

	aRTMondrian normalizer normalizeWidth: aBlock min: 10 max: 40.
]

{ #category : #'public - metrics' }
MVMachine >> numberOfNotNoneStates [
	^ self allStatesButNone size
]

{ #category : #'public - metrics' }
MVMachine >> numberOfStates [
	^ self states size
]

{ #category : #'public - metrics' }
MVMachine >> numberOfTransitions [
	^ self transitions size
]

{ #category : #'private - rendering' }
MVMachine >> paintNSMBordersOnView: aView [

	(aView elements 
		select: [:e| e model class = MVState and: [e model hasMachine]])
			select: [ :e| |coverage|
				coverage := aView attributeAt: #vizRobCoverage ifAbsent:[false].
				coverage
					ifTrue:[(self allNonExecutedStates includes: e model) not]
					ifFalse: [ true ]]
			thenDo:[:e| e trachelShape strokePaint: Color green].
	aView signalUpdate
]

{ #category : #'private - rendering' }
MVMachine >> removeNSMBordersOnView: aView [

	aView elements select: [:e| e model class = MVState] thenDo: [:e| e trachelShape noBorder]. 
]

{ #category : #private }
MVMachine >> resetCurrentStates [

	currentStates do: [ :st| st finish ].
	currentStates removeAll.
]

{ #category : #private }
MVMachine >> resetCurrentStates: states [

	states do: [ :st| st finish ].
	currentStates removeAll: states.
]

{ #category : #public }
MVMachine >> setCurrentState: aMVState [

	(currentStates includes: aMVState) ifTrue: [ ^self ].
	self resetCurrentStates.
	self addCurrentState: aMVState.
	
]

{ #category : #public }
MVMachine >> setCurrentStateNamed: aString [
	self setCurrentState: (self getStateNamed: aString)
]

{ #category : #public }
MVMachine >> setCurrentStates: aMVStateCollection [
	
	| states |
	states := currentStates select: [:st| (aMVStateCollection includes: st) not].
	
	self resetCurrentStates: states.
	
	aMVStateCollection do: [:st| self addCurrentState: st].
]

{ #category : #public }
MVMachine >> setCurrentStatesNamed: aStringCollection [
	self setCurrentStates: (aStringCollection collect: [:s| self getStateNamed: s])
]

{ #category : #'public  - visualization' }
MVMachine >> shortName [
	^ (self machineName substrings: '/') last
]

{ #category : #'private - rendering' }
MVMachine >> showAllStatesOnView: aView [

	| nonExecutedStates  |
	nonExecutedStates := self allNonExecutedStates.
	aView elements 
		select: [ :e| 
			e model class = MVState and:[
				nonExecutedStates includes: e model
			]
		]
		thenDo:[:e| 
			e color: (e color alpha: 1).
			e trachelShape strokePaint ifNotNil:[
				e trachelShape strokePaint: (e trachelShape strokePaint alpha: 1)
			]
		].

	aView edges 
		select:[:e| |out in|
			out := e model key class = MVState and:[nonExecutedStates includes: e model key].
			in := e model value class = MVState and:[nonExecutedStates includes: e model value].
			out or: [in]] 
		thenDo:[:e| 
			e trachelShape allColor: (e trachelShape color alpha: 0.4)].
]

{ #category : #'private - rendering' }
MVMachine >> showExecutedStatesOnView: aView [

	| nonExecutedStates |
	nonExecutedStates := self allNonExecutedStates.
	aView elements 
		select: [ :e| 
			e model class = MVState and:[nonExecutedStates includes: e model]]
	 	thenDo:[:e| 
			e color: (e color alpha: 0.05).
			e trachelShape strokePaint ifNotNil:[
				e trachelShape strokePaint: (e trachelShape strokePaint alpha: 0.05)
			]
		].

	aView edges 
		select:[:e| |out in|
			out := e model key class = MVState and:[nonExecutedStates includes: e model key].
			in := e model value class = MVState and:[nonExecutedStates includes: e model value].
			out or: [in]] 
		thenDo:[:e| 
			e trachelShape allColor: (e trachelShape color alpha: 0.05)].
]

{ #category : #'private - rendering' }
MVMachine >> showOrRemoveNSMBorderOnView: aView [ 
	|showBorders|
	
	aView attributeAt: #vizRobShowBorders ifAbsentPut: true.
	showBorders := aView attributeAt: #vizRobShowBorders.
	
	showBorders 
		ifTrue:[ 
			self paintNSMBordersOnView: aView.			
		]
		ifFalse: [ 
			self removeNSMBordersOnView: aView. 
		]
]

{ #category : #'private - rendering' }
MVMachine >> showOrRemoveNSMBorderOnView: aView showBorders: showBorders [
	
	showBorders 
		ifTrue:[ 
			self paintNSMBordersOnView: aView.			
		]
		ifFalse: [ 
			self removeNSMBordersOnView: aView. 
		]
]

{ #category : #public }
MVMachine >> sortedLogs [
	^self stateLogs sort
]

{ #category : #public }
MVMachine >> stateLogs [
	| allLogs |
	allLogs :=  MVLogCollection new.
	allLogs addAll: (self states flatCollect: [ :state| state logs ] as: MVLogCollection). 
	^ allLogs.
]

{ #category : #accessing }
MVMachine >> states [
	"Return the list of states contained in the machine"
	^ stateDict values
]

{ #category : #'private - rendering' }
MVMachine >> toggleCoverageOnView: aView [ 
	|coverage|
	
	aView attributeAt: #vizRobCoverage ifAbsentPut: false.
	coverage := aView attributeAt: #vizRobCoverage.

	coverage 
		ifTrue:[ 
			aView attributeAt: #vizRobCoverage put: false.			
			self showAllStatesOnView: aView. 
		]
		ifFalse: [ 
			aView attributeAt: #vizRobCoverage put: true.
			self showExecutedStatesOnView: aView.			
		].
	
	aView signalUpdate.
]

{ #category : #'private - rendering' }
MVMachine >> toggleCoverageOnView: aView coverage: coverageBoolean [

	coverageBoolean 
		ifTrue:[ 		
			self showAllStatesOnView: aView. 
		]
		ifFalse: [ 
			self showExecutedStatesOnView: aView.			
		].
	aView signalUpdate.
]

{ #category : #'private - rendering' }
MVMachine >> toggleNSMBorderOnView: aView [ 
	|showBorders|
	
	aView attributeAt: #vizRobShowBorders ifAbsentPut: false.
	showBorders := aView attributeAt: #vizRobShowBorders.
	
	showBorders 
		ifTrue:[ 
			self removeNSMBordersOnView: aView. 
			aView attributeAt: #vizRobShowBorders put: false.
		]
		ifFalse: [ 
			self paintNSMBordersOnView: aView.
			aView attributeAt: #vizRobShowBorders put: true.
		]
]

{ #category : #accessing }
MVMachine >> transitions [
	"Return the collection of transition indirectly contained in the machine"
	^ self states flatCollectAsSet: #connectedTransitions
]

{ #category : #'public  - visualization' }
MVMachine >> typeLabel [
	^ 'Machine'
]

{ #category : #'public  - visualization' }
MVMachine >> vizLabel [
	^ self shortName
]
