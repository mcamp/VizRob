Class {
	#name : #MVLogSource,
	#superclass : #Object,
	#instVars : [
		'level',
		'codeLine',
		'name',
		'functionName',
		'logs'
	],
	#category : #'MachineViz-Log'
}

{ #category : #'instance creation' }
MVLogSource class >> fromLog: aMVLog [

	^self new
		level: aMVLog level;
		codeLine: aMVLog codeLine;
		functionName: aMVLog functionName;
		name: aMVLog name;
		addLog: aMVLog;
		yourself.
]

{ #category : #adding }
MVLogSource >> addLog: aMVLog [
	logs add: aMVLog
]

{ #category : #accessing }
MVLogSource >> codeLine [
	^ codeLine
]

{ #category : #accessing }
MVLogSource >> codeLine: anObject [
	codeLine := anObject
]

{ #category : #accessing }
MVLogSource >> functionName [
	^ functionName
]

{ #category : #accessing }
MVLogSource >> functionName: anObject [
	functionName := anObject
]

{ #category : #inspector }
MVLogSource >> gtInspectorLogsIn: composite [
"	<gtInspectorPresentationOrder: -15>"
	composite table
		title: 'Logs';
		display: [ self sortedLogs ];
		icon: [ :log| log icon ]
]

{ #category : #inspector }
MVLogSource >> gtInspectorLogsSpecIn: composite [
	<gtInspectorPresentationOrder: -10>
	| presentation |
	presentation := composite spec.
	presentation
		title: 'Logs';
		display: [ (MVLogVisualization new logs: self sortedLogs; presentation: presentation) 
							buildWithSpec; yourself ]
		
]

{ #category : #testing }
MVLogSource >> hasProduceLog: aMVLog [ 
	(aMVLog level = self  level) ifFalse: [^false].
	(aMVLog codeLine = self codeLine) ifFalse: [^false].
	(aMVLog functionName = self functionName) ifFalse: [^false].
	(aMVLog name = self name) ifFalse: [^false].
	
	^true
]

{ #category : #accessing }
MVLogSource >> icon [
	
	^self logs 
		ifEmpty: [ self iconNamed: #empty ]
		ifNotEmpty: [ self logs first icon ]
]

{ #category : #initialization }
MVLogSource >> initialize [
	super initialize.
	logs := MVLogCollection new.
]

{ #category : #accessing }
MVLogSource >> level [
	^ level
]

{ #category : #accessing }
MVLogSource >> level: anObject [
	level := anObject
]

{ #category : #accessing }
MVLogSource >> logs [
	^logs
]

{ #category : #accessing }
MVLogSource >> name [
	^name
]

{ #category : #accessing }
MVLogSource >> name: anObject [
	name := anObject
]

{ #category : #printing }
MVLogSource >> printEmptyOn: aStream [
	
	aStream nextPutAll: '[0]EmptyLogSource()'.
]

{ #category : #printing }
MVLogSource >> printLevelOn: aStream [
	
	aStream nextPutAll: '['.
	aStream nextPutAll: self logs size asString.
	aStream nextPutAll: ']'.
	aStream nextPutAll: self level capitalized.
	aStream nextPutAll: 'LogSource('.
	aStream nextPutAll: self functionName.
	aStream nextPutAll: ')'.
]

{ #category : #printing }
MVLogSource >> printOn: aStream [
	
	logs isEmpty ifTrue:[ ^ self printEmptyOn: aStream].
	self printLevelOn: aStream
	
	
]
