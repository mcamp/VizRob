Class {
	#name : #MVLogTest,
	#superclass : #TestCase,
	#category : #'MachineViz-Tests'
}

{ #category : #data }
MVLogTest >> logs [

	| logs t|
	t := DateAndTime now.
	logs := MVLogCollection new.
	logs add: (
		MVLog new
			level: MVLogLevel debug;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel warning;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel error;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel debug;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel warning;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel error;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel debug;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel warning;
			timestamp: t
	).
	t := t + 10.
	logs add: (
		MVLog new
			level: MVLogLevel error;
			timestamp: t
	).
	t := t + 10.
	
	^logs.
]

{ #category : #data }
MVLogTest >> logs2 [

	| logs |
	logs := MVLogCollection new.
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel debug;
			functionName: 'fun1';
			message: 'This is similar';
			name: 'program1'
	).
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel warning;
			functionName: 'fun2';
			message: 'This is different';
			name: 'program1'
	).
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel debug;
			functionName: 'fun1';
			message: 'This is similar';
			name: 'program1'
	).
	
	^logs.
]

{ #category : #data }
MVLogTest >> logsNoOrder [

	| logs |
	logs := MVLogCollection new.
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel debug;
			functionName: 'fun2';
			timestamp: (DateAndTime year: 2019 month: 3 day: 26 hour: 6 minute: 55)
	).
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel warning;
			functionName: 'fun1';
			timestamp: (DateAndTime year: 2019 month: 3 day: 26 hour: 6 minute: 50)
	).
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel debug;
			functionName: 'fun3';
			timestamp: (DateAndTime year: 2019 month: 3 day: 26 hour: 7 minute: 10)
	).
	
	^logs.
]

{ #category : #data }
MVLogTest >> logsVar [

	| logs |
	logs := MVLogCollection new.
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel info;
			functionName: 'fun1';
			message: 'Value of x is 1';
			name: 'program1'
	).
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel warning;
			functionName: 'fun2';
			message: 'This is different';
			name: 'program1'
	).
	logs add: (
		MVLog new
			codeLine: 10;
			level: MVLogLevel info;
			functionName: 'fun1';
			message: 'Value of x is 2';
			name: 'program1'
	).
	
	^logs.
]

{ #category : #aggregation }
MVLogTest >> testAggregateLogs [

	| logAgg group |
	logAgg := MVLogAggregation fromLogCollection: self logs2.
	self assert: logAgg groups size equals: 2.
	
	self assert: logAgg groups first logs size equals: 2.
	self assert: logAgg groups second logs size equals: 1.
	
	group := logAgg groups first.
	self assert: (group logs first fromSource: group).
	self assert: group logs first message equals: 'This is similar'.
	self assert: group logs second message equals: 'This is similar'.
	self deny: (group logs first = group logs second).
	
	group := logAgg groups second.
	self assert: (group logs first fromSource: group).
	self assert: group logs first message equals: 'This is different'.
]

{ #category : #aggregation }
MVLogTest >> testAggregateWithVarLogs [

	| logAgg group |
	logAgg := MVLogAggregation fromLogCollection: self logsVar.
	self assert: logAgg groups size equals: 2.
	
	self assert: logAgg groups first logs size equals: 2.
	self assert: logAgg groups second logs size equals: 1.
	
	group := logAgg groups first.
	self assert: (group logs first fromSource: group ).
	self assert: group logs first message equals: 'Value of x is 1'.
	self assert: group logs second message equals: 'Value of x is 2'.
	
	group := logAgg groups second.
	self assert: (group logs first fromSource: group ).
	self assert: group logs first message equals: 'This is different'.
]

{ #category : #tests }
MVLogTest >> testBasic [
	|log|
	
	log := MVLog new.
	self assert: log name equals: ''.
	self assert: log level equals: MVLogLevel debug.
	self assert: log message equals: ''.
	self assert: log functionName equals: ''.
	self assert: log codeLine equals: 0.
]

{ #category : #tests }
MVLogTest >> testDebugLevel [
	|logs debugs|
	
	logs := self logs.
	debugs := logs debugs.
	
	self assert: debugs size equals: 3.
	self assert: (debugs allSatisfy: [:log| log level = MVLogLevel debug]).
]

{ #category : #tests }
MVLogTest >> testErrorLevel [
	|logs errors|
	
	logs := self logs.
	errors := logs errors.
	
	self assert: errors size equals: 3.
	self assert: (errors allSatisfy: [:log| log level = MVLogLevel error]).
]

{ #category : #tests }
MVLogTest >> testHasError [

	self assert: self logs hasErrors.
	self assert: self logs errors hasErrors.
	self deny: self logs warnings hasErrors.
]

{ #category : #tests }
MVLogTest >> testHasWarning [
	
	self assert: self logs hasWarnings.
	self assert: self logs warnings hasWarnings.
	self deny: self logs errors hasWarnings.
]

{ #category : #source }
MVLogTest >> testLogFromSource [

	| log source |
	log := self logs2 first.
	source := MVLogSource fromLog: self logs2 first.
	
	self assert: (log fromSource: source)
]

{ #category : #aggregation }
MVLogTest >> testNoLogAggregation [

	| logAgg |
	logAgg := MVLogAggregation fromLogCollection: MVLogCollection new.
	self assert: logAgg groups size equals: 0.
]

{ #category : #collection }
MVLogTest >> testSort [

	| logs |
	logs := self logsNoOrder sort asArray.
	self assertCollection: (logs collect:[:log| log functionName]) equals: #('fun1' 'fun2' 'fun3')
]

{ #category : #source }
MVLogTest >> testSourceFromLog [

	| log source |
	log := self logs2 first.
	source := MVLogSource fromLog: log.
	self assert: source level equals: log level.
	self assert: source codeLine equals: log codeLine.
	self assert: source functionName equals: log functionName.
	self assert: source name equals: log name.
	self assert: source logs first equals: log
]

{ #category : #tests }
MVLogTest >> testWarningLevel [
	|logs warnings|
	
	logs := self logs.
	warnings := logs warnings.
	
	self assert: warnings size equals: 3.
	self assert: (warnings allSatisfy: [:log| log level = MVLogLevel warning]).
]
