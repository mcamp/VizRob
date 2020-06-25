"
I represent a Log of a nested state machine program

name: name of the program
message: logging message
functionName: name of the function
codeLine: line of the log in the source code
level: debug level

debug levels
DEBUG=1 #debug level
INFO=2 #general level
WARN=4 #warning level
ERROR=8 #error level
FATAL=16 #fatal/critical level
"
Class {
	#name : #MVLog,
	#superclass : #Object,
	#instVars : [
		'name',
		'level',
		'message',
		'codeLine',
		'functionName',
		'timestamp',
		'fileName',
		'receivedTime'
	],
	#category : #'MachineViz-Log'
}

{ #category : #icons }
MVLog class >> iconFromLevel: aSymbol [

	^(self iconNamed: (self levelToIconNameDic at: aSymbol))
]

{ #category : #icons }
MVLog class >> levelToIconNameDic [

	^Dictionary newFromPairs: 
		{ #info . #smallInfo .
		#debug . #flag .
		#error. #error .
		#warning. #warning .} 
]

{ #category : #comparing }
MVLog >> <= anotherLog [

	^ self timestamp <= anotherLog timestamp
]

{ #category : #accessing }
MVLog >> codeLine [
	^ codeLine
]

{ #category : #accessing }
MVLog >> codeLine: anObject [
	codeLine := anObject
]

{ #category : #accessing }
MVLog >> fileName [
	^ fileName
]

{ #category : #accessing }
MVLog >> fileName: aText [
	fileName := aText
]

{ #category : #testing }
MVLog >> fromSource: aMVLogSource [ 
	^aMVLogSource hasProduceLog: self.
]

{ #category : #accessing }
MVLog >> functionName [
	^ functionName
]

{ #category : #accessing }
MVLog >> functionName: anObject [
	functionName := anObject
]

{ #category : #accessing }
MVLog >> icon [

	 ^self iconNamed: self levelToIconName
]

{ #category : #initialization }
MVLog >> initialize [

	super initialize.
	name := ''.
	level := MVLogLevel debug.
	message := ''.
	functionName := ''.
	codeLine := 0.	
]

{ #category : #accessing }
MVLog >> level [
	^ level
]

{ #category : #accessing }
MVLog >> level: anObject [
	level := anObject
]

{ #category : #accessing }
MVLog >> levelToIconName [

	 ^self class levelToIconNameDic at: self level
]

{ #category : #printing }
MVLog >> location [ 
	^ self fileName, ':', self functionName, '::' , self codeLine asString.
]

{ #category : #accessing }
MVLog >> message [
	^ message
]

{ #category : #accessing }
MVLog >> message: anObject [
	message := anObject
]

{ #category : #accessing }
MVLog >> name [
 ^name
]

{ #category : #accessing }
MVLog >> name: anObject [
	name := anObject
]

{ #category : #printing }
MVLog >> printOn: aStream [

	aStream nextPutAll: '['.
	aStream nextPutAll: self timestamp asStringHMSDMY.
	aStream nextPutAll: ']  -- '.
	aStream nextPutAll: message.
	
]

{ #category : #accessing }
MVLog >> receivedTime [
	^ receivedTime
]

{ #category : #accessing }
MVLog >> receivedTime: anObject [
	receivedTime := anObject
]

{ #category : #accessing }
MVLog >> timestamp [
	^timestamp
]

{ #category : #accessing }
MVLog >> timestamp: aTimestamp [
	timestamp := aTimestamp
]
