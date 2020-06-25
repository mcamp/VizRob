Class {
	#name : #PhaROSTimestampMock,
	#superclass : #Object,
	#instVars : [
		'timestamp'
	],
	#category : #'MachineViz-PhaROSMock'
}

{ #category : #'as yet unclassified' }
PhaROSTimestampMock class >> fromUnixTime: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	^ super new timestamp: ((DateAndTime fromUnixTime: anAmountOfSeconds)  + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ));
				  yourself.
]

{ #category : #'as yet unclassified' }
PhaROSTimestampMock class >> new [
	^ super new timestamp:( DateAndTime fromUnixTime: 0) ; yourself .
]

{ #category : #'as yet unclassified' }
PhaROSTimestampMock class >> now [
	^ super new timestamp: DateAndTime now ; yourself .
]

{ #category : #operations }
PhaROSTimestampMock >> + aDuration [
	^ PhaROSTimestamp new timestamp: timestamp + aDuration ; yourself.
]

{ #category : #operations }
PhaROSTimestampMock >> - aDateAndTime [
	^ timestamp - aDateAndTime asDateAndTime.
]

{ #category : #operations }
PhaROSTimestampMock >> < aDateAndTime [
	^ timestamp < aDateAndTime asDateAndTime.
]

{ #category : #comparing }
PhaROSTimestampMock >> = anObject [ 
	self species = anObject species ifFalse: [^false].
	
	^self valuesToCompareForEquality = anObject valuesToCompareForEquality
]

{ #category : #operations }
PhaROSTimestampMock >> > aDateAndTime [
	^ timestamp > aDateAndTime asDateAndTime.
]

{ #category : #converting }
PhaROSTimestampMock >> asDateAndTime [
	^ timestamp
]

{ #category : #comparing }
PhaROSTimestampMock >> closeTo: anOtherPhaROSTimeStamp [
	^ timestamp = anOtherPhaROSTimeStamp timestamp.
	
]

{ #category : #comparing }
PhaROSTimestampMock >> hash [
	^self valuesToCompareForEquality inject: self species hash into: [:hash :comparisonValue|
		(hash bitXor: comparisonValue hash) hashMultiply]

]

{ #category : #converting }
PhaROSTimestampMock >> nanoSeconds [
	^ timestamp nanoSecond.
]

{ #category : #'simple instance creation' }
PhaROSTimestampMock >> nanoSeconds: anAmountOfNSeconds [ 
	timestamp nanoSeconds: anAmountOfNSeconds 
]

{ #category : #accessing }
PhaROSTimestampMock >> seconds [
	^ timestamp asUnixTime .
]

{ #category : #private }
PhaROSTimestampMock >> seconds: anAmountOfSeconds [
	timestamp seconds: anAmountOfSeconds.
]

{ #category : #private }
PhaROSTimestampMock >> seconds: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	timestamp := (DateAndTime fromUnixTime: anAmountOfSeconds) + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ).
	^ timestamp.
]

{ #category : #converting }
PhaROSTimestampMock >> secondsUTC [
	^ timestamp asUnixTime
]

{ #category : #accessing }
PhaROSTimestampMock >> timestamp [ 
	^ timestamp.
]

{ #category : #accessing }
PhaROSTimestampMock >> timestamp: aDateAndTime [
	timestamp := aDateAndTime.
	
]
