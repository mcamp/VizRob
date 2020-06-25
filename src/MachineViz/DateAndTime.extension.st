Extension { #name : #DateAndTime }

{ #category : #'*MachineViz' }
DateAndTime >> asStringHMSDMY [
	^ String streamContents: [ :aStream |
		self hour printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPut: $:.
		self minute printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPut: $:.
		self second printOn: aStream base: 10 length: 2 padded: true.

		self nanoSecond ~= 0
			ifTrue: [ | n len |
				n := self nanoSecond.
				len := 9.
				[ n \\ 10 = 0 ]
					whileTrue: [ n := n / 10.
						len := len - 1 ].
				aStream nextPut: $..
				n
					printOn: aStream
					base: 10
					length: len
					padded: true ].
		
		aStream nextPut: Character space.		
		self printDMYOn: aStream.
		]
]

{ #category : #'*MachineViz' }
DateAndTime >> printDMYOn: aStream [
	| year month day |
	self dayMonthYearDo: [ :d :m :y | year := y. month := m. day := d ].
	day printOn: aStream base: 10 length: 2 padded: true.
	aStream nextPut: $-.
	month printOn: aStream base: 10 length: 2 padded: true.
	aStream nextPut: $-.
	year abs printOn: aStream base: 10 length: 4 padded: true.
	
]
