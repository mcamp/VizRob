Class {
	#name : #MVSerializationAsCSV,
	#superclass : #MVAbstractSerializationAsCSV,
	#category : #'MachineViz-Core-Serialization'
}

{ #category : #public }
MVSerializationAsCSV >> serialize: pharosValue [
	| associations |
	associations := pharosValue associations.
	associations := associations asSortedCollection: [ :a1 :a2 | a1 key < a2 key ].
	associations do: [ :as |
		stream nextPutAll: as key.
		stream tab.
		as key = #header 
			ifTrue: [ self serializeHeader: as value ].
		
		as key = #path
			ifTrue: [ self serializeString: as value ].
			
		(#(#header #path) includes: as key) not 
			ifTrue: [ self serializeValue: as value ].
		stream cr ].

]
