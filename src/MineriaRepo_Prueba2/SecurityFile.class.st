Class {
	#name : #SecurityFile,
	#superclass : #Object,
	#instVars : [
		'filename',
		'versions'
	],
	#category : #'MineriaRepo_Prueba2-Model'
}

{ #category : #'as yet unclassified' }
SecurityFile class >> fromDictionary: aDictionary named: aString [
	| newFile historyDict |
	newFile := self new.
	newFile filename: aString.
	historyDict := aDictionary at: 'history' ifAbsent: [ Dictionary new ].
	
	historyDict keysAndValuesDo: [ :dateString :data |
		| newVersion cleanDateString |
		newVersion := SecurityVersion new.
		newVersion parentFile: newFile. "Conectamos con el padre"
		
		"Limpieza de fecha"
		cleanDateString := dateString copy.
		(cleanDateString includes: $T) ifTrue: [
			| parts |
			parts := cleanDateString splitOn: $T.
			cleanDateString := (parts first), 'T', ((parts second) copyReplaceAll: '-' with: ':')
		].
		
		newVersion timestamp: (DateAndTime fromString: cleanDateString).
		newVersion vulnerabilities: (data at: 'vulnerability_list' ifAbsent: [ #() ]).
		newFile versions add: newVersion.
	].
	^ newFile
]

{ #category : #'as yet unclassified' }
SecurityFile >> currentVulnerabilityCount [
	self versions ifEmpty: [ ^ 0 ].
	^ self versions last numberOfVulnerabilities
]

{ #category : #'as yet unclassified' }
SecurityFile >> filename [
	^ filename
]

{ #category : #'as yet unclassified' }
SecurityFile >> filename: aString [
	filename := aString
]

{ #category : #'as yet unclassified' }
SecurityFile >> gtEvolucionFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Evolución de Vulnerabilidades';
		priority: 1;
		items: [ self versions sorted: [:a :b | a timestamp < b timestamp] ];
		column: 'Fecha Versión' text: [ :version | version timestamp asStringYMDHM ];
		column: 'Cant. Vulnerabilidades' text: [ :version | version numberOfVulnerabilities ];
		column: 'Estado' text: [ :version | version numberOfVulnerabilities = 0 ifTrue: [ 'Seguro' ] ifFalse: [ 'Vulnerable' ] ]
]

{ #category : #'as yet unclassified' }
SecurityFile >> gtVersionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Versiones (Detalle)';
		priority: 2;
		items: [ self versions sorted: [:a :b | a timestamp < b timestamp] ];
		column: 'Fecha' text: [ :v | v timestamp asStringYMDHM ];
		column: 'Cant. Vulnerabilidades' text: [ :v | v numberOfVulnerabilities ];
		column: 'Msg Principal' text: [ :v | v numberOfVulnerabilities > 0 ifTrue: [ v vulnerabilities first at: 'message' ifPresent: [:m | m at: 'text'] ] ifFalse: ['OK'] ] weight: 3
]

{ #category : #'as yet unclassified' }
SecurityFile >> numberOfVersions [
	^ self versions size
]

{ #category : #'as yet unclassified' }
SecurityFile >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: (filename ifNil: ['Sin nombre']).
	aStream nextPutAll: ' - Versiones: '.
	aStream print: self numberOfVersions.
	aStream nextPut: $).
]

{ #category : #'as yet unclassified' }
SecurityFile >> versions [
	^ versions ifNil: [ versions := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
SecurityFile >> versions: aCollection [
	versions := aCollection
]
