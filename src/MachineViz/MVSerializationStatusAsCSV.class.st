Class {
	#name : #MVSerializationStatusAsCSV,
	#superclass : #MVAbstractSerializationAsCSV,
	#category : #'MachineViz-Core-Serialization'
}

{ #category : #public }
MVSerializationStatusAsCSV >> serialize: aCollection [
	"serialize a collection of statuses, with 2 seconds rate"
	stream nextPutAll: 'rate'.
	stream tab.
	stream nextPutAll: 2 asString.
	stream cr.
	aCollection do: [ :status|
		self serializeStatus: status.	
	]
]

{ #category : #private }
MVSerializationStatusAsCSV >> serializeStatus: pharosValue [
	| associations |
	associations := pharosValue associations.
	associations := associations asSortedCollection: [ :a1 :a2 | a1 key < a2 key ].
	associations := associations reject:[:as| as key = #local_data].
	associations do: [ :as |
		stream nextPutAll: as key.
		stream tab.
		as key = #header 
			ifTrue: [ self serializeHeader: as value ].
		
		as key = #path
			ifTrue: [ self serializeString: as value ].
		
		as key = #info
			ifTrue: [ self serializeString: as value ].
			
		(#(#header #path #info) includes: as key) not 
			ifTrue: [ self serializeValue: as value ].
		stream cr ].

]
