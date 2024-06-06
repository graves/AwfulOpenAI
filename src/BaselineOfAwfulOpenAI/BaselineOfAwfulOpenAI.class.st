Class {
	#name : #BaselineOfAwfulOpenAI,
	#superclass : #BaselineOf,
	#category : #BaselineOfAwfulOpenAI
}

{ #category : #loading }
BaselineOfAwfulOpenAI class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'AwfulClaudeSt' ]
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
BaselineOfAwfulOpenAI >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			" Dependencies "
			self neoJSON: spec.
			self openAIPharo: spec.
			
			"Package"
			spec package: 'AwfulOpenAI'
		]
]

{ #category : #accessing }
BaselineOfAwfulOpenAI >> neoJSON: spec [ [
	spec
		baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON' ] ]
]

{ #category : #accessing }
BaselineOfAwfulOpenAI >> openAIPharo: spec [
	spec
		baseline: 'OpenAI' with: [ spec repository: 'github://brackendev/OpenAI-Pharo/src' ]
]
