Class {
	#name : #SecurityVersion,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'vulnerabilities',
		'parentFile'
	],
	#category : #'MineriaRepo_Prueba2-Model'
}

{ #category : #'as yet unclassified' }
SecurityVersion >> gtVulnerabilitiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Lista de Vulnerabilidades';
		priority: 5;
		items: [ self vulnerabilities ];
		column: 'ID Regla' text: [ :v | v at: 'ruleId' ifAbsent: ['-'] ] width: 200;
		column: 'Mensaje' text: [ :v | (v at: 'message' ifAbsent: [ Dictionary new ]) at: 'text' ifAbsent: ['-'] ] weight: 3;
		column: 'Severidad' text: [ :v | (v at: 'properties' ifAbsent: [ Dictionary new ]) at: 'security_severity' ifAbsent: ['-'] ] width: 80
]

{ #category : #'as yet unclassified' }
SecurityVersion >> numberOfVulnerabilities [
	^ self vulnerabilities size
]

{ #category : #'as yet unclassified' }
SecurityVersion >> parentFile [
	^ parentFile
]

{ #category : #'as yet unclassified' }
SecurityVersion >> parentFile: anObject [
	parentFile := anObject
]

{ #category : #'as yet unclassified' }
SecurityVersion >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self timestamp asDate asString. 
	aStream nextPutAll: ' - Vuln: '.
	aStream print: self numberOfVulnerabilities.
	aStream nextPut: $).
]

{ #category : #'as yet unclassified' }
SecurityVersion >> timestamp [
	^ timestamp
]

{ #category : #'as yet unclassified' }
SecurityVersion >> timestamp: aDateAndTime [
	timestamp := aDateAndTime
]

{ #category : #'as yet unclassified' }
SecurityVersion >> vulnerabilities [
	^ vulnerabilities
]

{ #category : #'as yet unclassified' }
SecurityVersion >> vulnerabilities: aCollection [
	vulnerabilities := aCollection
]
