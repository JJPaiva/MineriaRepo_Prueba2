Class {
	#name : #SecurityKnowledgeBase,
	#superclass : #Object,
	#instVars : [
		'files'
	],
	#category : #'MineriaRepo_Prueba2-Model'
}

{ #category : #'as yet unclassified' }
SecurityKnowledgeBase >> files [
	^ files ifNil: [ files := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
SecurityKnowledgeBase >> files: aCollection [
	files := aCollection
]

{ #category : #'as yet unclassified' }
SecurityKnowledgeBase >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items';
		priority: 0;
		items: [ self files ];
		column: 'Index' text: [ :eachItem :index | index asString ] width: 40;
		column: 'Item' text: [ :eachItem | eachItem printString ]
]

{ #category : #'as yet unclassified' }
SecurityKnowledgeBase >> gtVulnerabilityMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Mapa de Riesgo';
		priority: 1;
		painting: [ :view | 
			view nodes
				shape: [ :eachFile |
					| dimension color |
					dimension := (eachFile currentVulnerabilityCount * 10) + 20.
					color := eachFile numberOfVersions < 5 
						ifTrue: [ Color red alpha: 0.6 ] 
						ifFalse: [ Color green alpha: 0.6 ].
					BlElement new
						geometry: BlRectangleGeometry new;
						size: dimension asPoint;
						background: color;
						border: (BlBorder paint: Color black width: 1);
						margin: (BlInsets all: 5); "ESTA ES LA CORRECCIÓN CLAVE"
						aptitude: (BrGlamorousLabelAptitude new text: eachFile filename);
						when: BlClickEvent do: [ :e | eachFile inspect ]
				];
				with: self files.
			view layout grid.
		]
]
