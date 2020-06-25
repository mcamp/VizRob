Class {
	#name : #MVLogAggregation,
	#superclass : #Object,
	#instVars : [
		'logCollection',
		'groups'
	],
	#category : #'MachineViz-Log'
}

{ #category : #'instance creation' }
MVLogAggregation class >> fromLogCollection: aLogCollection [

	^self new 
		logCollection: aLogCollection;
		aggregate;
		yourself.
]

{ #category : #aggregation }
MVLogAggregation >> aggregate [

	groups := OrderedCollection new.
	logCollection do: [ :log| 
		groups 
			detect: [ :source| log fromSource: source ]  
			ifFound: [ :source| source addLog: log]
			ifNone: [groups add: (MVLogSource fromLog: log)]
	]
]

{ #category : #accessing }
MVLogAggregation >> groups [
	^groups
]

{ #category : #accessing }
MVLogAggregation >> logCollection [
	^ logCollection
]

{ #category : #accessing }
MVLogAggregation >> logCollection: anObject [
	logCollection := anObject
]

{ #category : #accessing }
MVLogAggregation >> sources [
	groups collect: [ :g| g key ]
]
