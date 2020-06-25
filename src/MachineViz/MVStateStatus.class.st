"
I represent a current state status in the machine.
When a state becomes a current state, I am added to the state to represent what is happening in that moment.
A state can be a current state more than one time, so a collection of myself is needed
"
Class {
	#name : #MVStateStatus,
	#superclass : #Object,
	#instVars : [
		'state',
		'logs',
		'startTime',
		'endTime',
		'finished'
	],
	#category : #'MachineViz-Core-StateMachine'
}

{ #category : #adding }
MVStateStatus >> addLog: aMVLog [
	logs add: aMVLog
]

{ #category : #accessing }
MVStateStatus >> endTime [
	^ self ifFinished: [endTime] ifNotFinished: [ DateAndTime now ]
]

{ #category : #accessing }
MVStateStatus >> endTime: anObject [
	endTime := anObject
]

{ #category : #live }
MVStateStatus >> finish [
	finished := true.
	self endTime: DateAndTime now
]

{ #category : #testing }
MVStateStatus >> hasFinished [
	^finished
]

{ #category : #testing }
MVStateStatus >> ifFinished: trueBlock ifNotFinished: falseBlock [
	^ self hasFinished
		ifTrue: trueBlock
		ifFalse: falseBlock
]

{ #category : #initialization }
MVStateStatus >> initialize [
	super initialize.
	finished := false.
	logs := MVLogCollection new.
]

{ #category : #accessing }
MVStateStatus >> logs [
	^ logs
]

{ #category : #live }
MVStateStatus >> start: aMVState [
	self startTime: DateAndTime now.
	self state: aMVState.
]

{ #category : #accessing }
MVStateStatus >> startTime [
	^ startTime
]

{ #category : #accessing }
MVStateStatus >> startTime: anObject [
	startTime := anObject
]

{ #category : #accessing }
MVStateStatus >> state [
	^ state
]

{ #category : #accessing }
MVStateStatus >> state: anObject [
	state := anObject
]

{ #category : #accessing }
MVStateStatus >> totalTime [
	^ self 
		ifFinished: [self endTime - self startTime]
		ifNotFinished: [ DateAndTime now - self startTime ]
]
