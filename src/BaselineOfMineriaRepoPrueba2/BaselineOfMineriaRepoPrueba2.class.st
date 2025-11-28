Class {
	#name : #BaselineOfMineriaRepoPrueba2,
	#superclass : #BaselineOf,
	#category : #BaselineOfMineriaRepoPrueba2
}

{ #category : #loading }
BaselineOfMineriaRepoPrueba2 class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'MineriaRepo_Prueba2' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfMineriaRepoPrueba2 >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'MineriaRepo_Prueba2'
		]
]
