Class {
	#name : #MVSerializationTest,
	#superclass : #TestCase,
	#category : #'MachineViz-Core-Serialization'
}

{ #category : #data }
MVSerializationTest >> object1 [

^ (PhaROSMSGMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#container_outcomes->#('preempted' 'invalid' )); add: (#internal_outcomes->#('valid' 'preempted' 'invalid' 'continue' 'valid' 'preempted' 'invalid' 'preempted' 'aborted' 'succeeded' 'valid' 'preempted' 'invalid' 'hasDestination' 'askDestination' 'valid' 'preempted' 'invalid' 'preempted' 'aborted' 'succeeded' 'continue' 'preempted' 'aborted' 'succeeded' 'valid' 'preempted' 'invalid' 'preempted' 'aborted' 'succeeded' 'continue' 'preempted' 'aborted' 'succeeded' 'preempted' 'noReply' 'invalid' 'replyWithObject' 'replyWithoutObject' 'valid' 'preempted' 'invalid' )); add: (#outcomes_from->#('WaitingForCallerRetrieving' 'WaitingForCallerRetrieving' 'WaitingForCallerRetrieving' 'WaitBeforeMovingInit' 'AskObject' 'AskObject' 'AskObject' 'MoveBackWithObject' 'MoveBackWithObject' 'MoveBackWithObject' 'AskDestination' 'AskDestination' 'AskDestination' 'BeforeAskDestination' 'BeforeAskDestination' 'ConfirmFromCaller' 'ConfirmFromCaller' 'ConfirmFromCaller' 'GoToCaller' 'GoToCaller' 'GoToCaller' 'NotifyGoingCaller' 'GoToDestination' 'GoToDestination' 'GoToDestination' 'AskForAnotherObject' 'AskForAnotherObject' 'AskForAnotherObject' 'MoveBackWithoutObject' 'MoveBackWithoutObject' 'MoveBackWithoutObject' 'ResetRobot' 'MoveInit' 'MoveInit' 'MoveInit' 'sm_retrieval' 'sm_retrieval' 'sm_retrieval' 'sm_retrieval' 'sm_retrieval' 'WaitForActivity' 'WaitForActivity' 'WaitForActivity' )); add: (#path->'Task1'); add: (#children->#('WaitingForCallerRetrieving' 'WaitBeforeMovingInit' 'AskObject' 'MoveBackWithObject' 'AskDestination' 'BeforeAskDestination' 'ConfirmFromCaller' 'GoToCaller' 'NotifyGoingCaller' 'GoToDestination' 'AskForAnotherObject' 'MoveBackWithoutObject' 'ResetRobot' 'MoveInit' 'sm_retrieval' 'WaitForActivity' )); add: (#outcomes_to->#('AskForAnotherObject' 'None' 'None' 'MoveInit' 'BeforeAskDestination' 'None' 'None' 'None' 'WaitingForCallerRetrieving' 'WaitingForCallerRetrieving' 'ConfirmFromCaller' 'None' 'None' 'ConfirmFromCaller' 'AskDestination' 'GoToDestination' 'None' 'AskObject' 'None' 'AskObject' 'AskObject' 'GoToCaller' 'None' 'sm_retrieval' 'sm_retrieval' 'ResetRobot' 'None' 'WaitBeforeMovingInit' 'None' 'AskForAnotherObject' 'AskForAnotherObject' 'AskObject' 'None' 'WaitForActivity' 'WaitForActivity' 'None' 'WaitBeforeMovingInit' 'None' 'MoveBackWithObject' 'MoveBackWithoutObject' 'NotifyGoingCaller' 'None' 'None' )); add: (#header->(PhaROSMSGMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->223); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 71289; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457847; instVarAt: 4 put: 765109062; yourself); yourself)); yourself); yourself)); yourself); yourself)
]

{ #category : #data }
MVSerializationTest >> object2 [

^ (PhaROSMSGMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#container_outcomes->#('preempted' 'invalid' )); add: (#internal_outcomes->#('valid' 'preempted' 'invalid' 'continue' 'valid' 'preempted' 'invalid' 'preempted' 'aborted' 'succeeded' 'valid' 'preempted' 'invalid' 'hasDestination' 'askDestination' 'valid' 'preempted' 'invalid' 'preempted' 'aborted' 'succeeded' 'continue' 'preempted' 'aborted' 'succeeded' 'valid' 'preempted' 'invalid' 'preempted' 'aborted' 'succeeded' 'continue' 'preempted' 'aborted' 'succeeded' 'preempted' 'noReply' 'invalid' 'replyWithObject' 'replyWithoutObject' 'valid' 'preempted' 'invalid' )); add: (#outcomes_from->#('WaitingForCallerRetrieving' 'WaitingForCallerRetrieving' 'WaitingForCallerRetrieving' 'WaitBeforeMovingInit' 'AskObject' 'AskObject' 'AskObject' 'MoveBackWithObject' 'MoveBackWithObject' 'MoveBackWithObject' 'AskDestination' 'AskDestination' 'AskDestination' 'BeforeAskDestination' 'BeforeAskDestination' 'ConfirmFromCaller' 'ConfirmFromCaller' 'ConfirmFromCaller' 'GoToCaller' 'GoToCaller' 'GoToCaller' 'NotifyGoingCaller' 'GoToDestination' 'GoToDestination' 'GoToDestination' 'AskForAnotherObject' 'AskForAnotherObject' 'AskForAnotherObject' 'MoveBackWithoutObject' 'MoveBackWithoutObject' 'MoveBackWithoutObject' 'ResetRobot' 'MoveInit' 'MoveInit' 'MoveInit' 'sm_retrieval' 'sm_retrieval' 'sm_retrieval' 'sm_retrieval' 'sm_retrieval' 'WaitForActivity' 'WaitForActivity' 'WaitForActivity' )); add: (#path->'Task1'); add: (#children->#('WaitingForCallerRetrieving' 'WaitBeforeMovingInit' 'AskObject' 'MoveBackWithObject' 'AskDestination' 'BeforeAskDestination' 'ConfirmFromCaller' 'GoToCaller' 'NotifyGoingCaller' 'GoToDestination' 'AskForAnotherObject' 'MoveBackWithoutObject' 'ResetRobot' 'MoveInit' 'sm_retrieval' 'WaitForActivity' )); add: (#outcomes_to->#('AskForAnotherObject' '' '' 'MoveInit' 'BeforeAskDestination' 'None' 'None' 'None' 'WaitingForCallerRetrieving' 'WaitingForCallerRetrieving' 'ConfirmFromCaller' 'None' 'None' 'ConfirmFromCaller' 'AskDestination' 'GoToDestination' 'None' 'AskObject' 'None' 'AskObject' 'AskObject' 'GoToCaller' 'None' 'sm_retrieval' 'sm_retrieval' 'ResetRobot' 'None' 'WaitBeforeMovingInit' 'None' 'AskForAnotherObject' 'AskForAnotherObject' 'AskObject' 'None' 'WaitForActivity' 'WaitForActivity' 'None' 'WaitBeforeMovingInit' 'None' 'MoveBackWithObject' 'MoveBackWithoutObject' 'NotifyGoingCaller' 'None' 'None' )); add: (#header->(PhaROSMSGMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->223); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 71289; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457847; instVarAt: 4 put: 765109062; yourself); yourself)); yourself); yourself)); yourself); yourself)
]

{ #category : #data }
MVSerializationTest >> status1 [

^ OrderedCollection new 
	add: 
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->1); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68400; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('WaitForActivity'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->2); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68402; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('WaitForActivity'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->3); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68404; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('WaitForActivity'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->4); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68406; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('NotifyGoingCaller'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->5); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68408; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('GoToCaller'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->6); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68410; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('GoToCaller'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->7); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68412; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('GoToCaller'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->8); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68414; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('GoToCaller'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->9); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68416; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('AskObject'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->10); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68418; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('AskObject'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	add:
		(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) 
			add: (#header->(PhaROSValueMock basicNew instVarAt: 1 put: ((Dictionary new) add: (#seq->11); add: (#frame_id->''); add: (#stamp->(PhaROSTimestampMock basicNew instVarAt: 1 put: (DateAndTime basicNew instVarAt: 1 put: 68420; instVarAt: 2 put: (Duration seconds: -10800 nanoSeconds: 0); instVarAt: 3 put: 2457854; instVarAt: 4 put: 0; yourself); yourself)); yourself); yourself)); 
			add: (#path->'Task1'); 
			add: (#initial_states->#('WaitForActivity'));
			add: (#active_states->#('AskObject'));
			add: (#local_data->'');
			add: (#info->'HEARTBEAT');
			yourself); yourself);
	yourself.
]

{ #category : #tests }
MVSerializationTest >> testObject [

	| obj |
	obj := self object1.
	self assert: obj class equals: PhaROSMSGMock
]

{ #category : #tests }
MVSerializationTest >> testReification [
	
	| cvs contents |
	cvs := MVSerializationAsCSV new serialize: self object1.
	contents := cvs contents.
	self assert: contents isString.
	self assert: contents notEmpty.
	self assert: contents lines size equals: 7.
	
	self assert: contents equals: 'children	WaitingForCallerRetrieving WaitBeforeMovingInit AskObject MoveBackWithObject AskDestination BeforeAskDestination ConfirmFromCaller GoToCaller NotifyGoingCaller GoToDestination AskForAnotherObject MoveBackWithoutObject ResetRobot MoveInit sm_retrieval WaitForActivity
container_outcomes	preempted invalid
header	223  2017-04-03T16:48:09.765109062-03:00
internal_outcomes	valid preempted invalid continue valid preempted invalid preempted aborted succeeded valid preempted invalid hasDestination askDestination valid preempted invalid preempted aborted succeeded continue preempted aborted succeeded valid preempted invalid preempted aborted succeeded continue preempted aborted succeeded preempted noReply invalid replyWithObject replyWithoutObject valid preempted invalid
outcomes_from	WaitingForCallerRetrieving WaitingForCallerRetrieving WaitingForCallerRetrieving WaitBeforeMovingInit AskObject AskObject AskObject MoveBackWithObject MoveBackWithObject MoveBackWithObject AskDestination AskDestination AskDestination BeforeAskDestination BeforeAskDestination ConfirmFromCaller ConfirmFromCaller ConfirmFromCaller GoToCaller GoToCaller GoToCaller NotifyGoingCaller GoToDestination GoToDestination GoToDestination AskForAnotherObject AskForAnotherObject AskForAnotherObject MoveBackWithoutObject MoveBackWithoutObject MoveBackWithoutObject ResetRobot MoveInit MoveInit MoveInit sm_retrieval sm_retrieval sm_retrieval sm_retrieval sm_retrieval WaitForActivity WaitForActivity WaitForActivity
outcomes_to	AskForAnotherObject None None MoveInit BeforeAskDestination None None None WaitingForCallerRetrieving WaitingForCallerRetrieving ConfirmFromCaller None None ConfirmFromCaller AskDestination GoToDestination None AskObject None AskObject AskObject GoToCaller None sm_retrieval sm_retrieval ResetRobot None WaitBeforeMovingInit None AskForAnotherObject AskForAnotherObject AskObject None WaitForActivity WaitForActivity None WaitBeforeMovingInit None MoveBackWithObject MoveBackWithoutObject NotifyGoingCaller None None
path	Task1
'
]

{ #category : #tests }
MVSerializationTest >> testReificationWithEmptyOutcomes [
	
	| cvs contents |
	cvs := MVSerializationAsCSV new serialize: self object2.
	contents := cvs contents.
	self assert: contents isString.
	self assert: contents notEmpty.
	self assert: contents lines size equals: 7.
	
	self assert: contents equals: 'children	WaitingForCallerRetrieving WaitBeforeMovingInit AskObject MoveBackWithObject AskDestination BeforeAskDestination ConfirmFromCaller GoToCaller NotifyGoingCaller GoToDestination AskForAnotherObject MoveBackWithoutObject ResetRobot MoveInit sm_retrieval WaitForActivity
container_outcomes	preempted invalid
header	223  2017-04-03T16:48:09.765109062-03:00
internal_outcomes	valid preempted invalid continue valid preempted invalid preempted aborted succeeded valid preempted invalid hasDestination askDestination valid preempted invalid preempted aborted succeeded continue preempted aborted succeeded valid preempted invalid preempted aborted succeeded continue preempted aborted succeeded preempted noReply invalid replyWithObject replyWithoutObject valid preempted invalid
outcomes_from	WaitingForCallerRetrieving WaitingForCallerRetrieving WaitingForCallerRetrieving WaitBeforeMovingInit AskObject AskObject AskObject MoveBackWithObject MoveBackWithObject MoveBackWithObject AskDestination AskDestination AskDestination BeforeAskDestination BeforeAskDestination ConfirmFromCaller ConfirmFromCaller ConfirmFromCaller GoToCaller GoToCaller GoToCaller NotifyGoingCaller GoToDestination GoToDestination GoToDestination AskForAnotherObject AskForAnotherObject AskForAnotherObject MoveBackWithoutObject MoveBackWithoutObject MoveBackWithoutObject ResetRobot MoveInit MoveInit MoveInit sm_retrieval sm_retrieval sm_retrieval sm_retrieval sm_retrieval WaitForActivity WaitForActivity WaitForActivity
outcomes_to	AskForAnotherObject None None MoveInit BeforeAskDestination None None None WaitingForCallerRetrieving WaitingForCallerRetrieving ConfirmFromCaller None None ConfirmFromCaller AskDestination GoToDestination None AskObject None AskObject AskObject GoToCaller None sm_retrieval sm_retrieval ResetRobot None WaitBeforeMovingInit None AskForAnotherObject AskForAnotherObject AskObject None WaitForActivity WaitForActivity None WaitBeforeMovingInit None MoveBackWithObject MoveBackWithoutObject NotifyGoingCaller None None
path	Task1
'
]

{ #category : #tests }
MVSerializationTest >> testStatus [

	| obj |
	obj := self status1.
	self assert: obj class equals: OrderedCollection.
	self assert: obj size equals: 11.
]

{ #category : #'tests - status' }
MVSerializationTest >> testStatusReification [
	
	| cvs contents |
	cvs := MVSerializationStatusAsCSV new serialize: self status1.
	contents := cvs contents.
	self assert: contents isString.
	self assert: contents notEmpty.
	self assert: contents lines size equals: 56.
	
	self assert: contents equals: 'rate	2
active_states	WaitForActivity
header	1  2017-04-10T16:00:00-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	WaitForActivity
header	2  2017-04-10T16:00:02-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	WaitForActivity
header	3  2017-04-10T16:00:04-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	NotifyGoingCaller
header	4  2017-04-10T16:00:06-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	GoToCaller
header	5  2017-04-10T16:00:08-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	GoToCaller
header	6  2017-04-10T16:00:10-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	GoToCaller
header	7  2017-04-10T16:00:12-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	GoToCaller
header	8  2017-04-10T16:00:14-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	AskObject
header	9  2017-04-10T16:00:16-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	AskObject
header	10  2017-04-10T16:00:18-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
active_states	AskObject
header	11  2017-04-10T16:00:20-03:00
info	HEARTBEAT
initial_states	WaitForActivity
path	Task1
'
]
