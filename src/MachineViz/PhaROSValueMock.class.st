Class {
	#name : #PhaROSValueMock,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'MachineViz-PhaROSMock'
}

{ #category : #converting }
PhaROSValueMock >> asString [ 
	| string  |	
		
	
	string := self class name, '>>', String crlf, String tab.
	values keysAndValuesDo:[
		:key :val |
		string := string , key asString, ':', val asString, ' | '.
	].
	string := string, String crlf.
	
	
		
	^ string.
]

{ #category : #accessing }
PhaROSValueMock >> associations [
	^values associations
]

{ #category : #accessing }
PhaROSValueMock >> at:aName put: aValue [
	values at:aName put: aValue.
]

{ #category : #accessing }
PhaROSValueMock >> closeTo: anOtherValue [

	^ (self class = anOtherValue class) and:[
		| allSatisfy|
		
		allSatisfy := true. 
		values keysAndValuesDo: [ :key : val | allSatisfy := allSatisfy and: [val closeTo: (anOtherValue getAt: key)]. ].
		allSatisfy.
	].
]

{ #category : #accessing }
PhaROSValueMock >> getAt:aName [ 
	^ values at: aName.
]

{ #category : #'gt-inspector-extension' }
PhaROSValueMock >> gtInspectorItemsIn: composite [
        <gtInspectorPresentationOrder: 0>
        ^ (composite table)
                title: 'Values';
                display: [ self associations ];
                children: [ :each |
                        (each value isKindOf: PhaROSValue)
                                ifTrue: [ each value associations ]
                                ifFalse: [ #() ] ];
                column: 'Key'
                        evaluated: [:each | each key ];
                column: 'Value'
                        evaluated: [:each | each value ]

]

{ #category : #testing }
PhaROSValueMock >> hasAttribute: aName [ 
	^ values includesKey: aName.
]

{ #category : #initialization }
PhaROSValueMock >> initialize [ 
	values := Dictionary new.
	
]

{ #category : #testing }
PhaROSValueMock >> isBasic [
	^ false. 
]

{ #category : #printing }
PhaROSValueMock >> printOn: aStream [
	aStream nextPutAll: self asString.
	
]
