Class {
	#name : #MVLogCollection,
	#superclass : #OrderedCollection,
	#category : #'MachineViz-Log'
}

{ #category : #levels }
MVLogCollection >> debugs [
	^self level: MVLogLevel debug
]

{ #category : #levels }
MVLogCollection >> errors [
	^self level: MVLogLevel error
]

{ #category : #testing }
MVLogCollection >> hasErrors [
	^self errors isNotEmpty
]

{ #category : #testing }
MVLogCollection >> hasWarnings [
	^self warnings isNotEmpty
]

{ #category : #levels }
MVLogCollection >> level: aMVLogLevel [
	^self select: [ :element| element level = aMVLogLevel ]
]

{ #category : #levels }
MVLogCollection >> warnings [
	^self level: MVLogLevel warning
]
