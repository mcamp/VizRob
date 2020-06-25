"
I am deprecated or I should be in machine viz smach
"
Class {
	#name : #MVAbstractSerializationAsCSV,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'MachineViz-Core-Serialization'
}

{ #category : #initialization }
MVAbstractSerializationAsCSV >> contents [
	^ stream contents
]

{ #category : #initialization }
MVAbstractSerializationAsCSV >> initialize [
	super initialize.
	stream := WriteStream on: String new
]

{ #category : #public }
MVAbstractSerializationAsCSV >> serialize: pharosValue [
	self subclassResponsibility
]

{ #category : #private }
MVAbstractSerializationAsCSV >> serializeHeader: anHeader [
	| s |
	s := ' ' join: { (anHeader getAt: #seq) asString . anHeader getAt: #frame_id . (anHeader getAt: #stamp) timestamp asString }.
	stream nextPutAll: s.

]

{ #category : #private }
MVAbstractSerializationAsCSV >> serializeString: aValue [
	stream nextPutAll: aValue asString.

]

{ #category : #private }
MVAbstractSerializationAsCSV >> serializeValue: aValue [
	"A value is here a collection of string"
	| s values|
	
	values := aValue collect: [ :val| val ifEmpty: [ 'None' ] ifNotEmpty: [ val ] ].
	s := ' ' join: values.
	stream nextPutAll: s
]
