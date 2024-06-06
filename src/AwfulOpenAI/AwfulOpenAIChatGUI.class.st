Class {
	#name : #AwfulOpenAIChatGUI,
	#superclass : #OpenAIChatGUI,
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulOpenAIChatGUI class >> openWithSDK: anOpenAISDK [

	| gui |
	gui := self new chatSession:
		       (OpenAIChatSession startWithSDK: anOpenAISDK).
	gui open.
	gui fieldInput takeKeyboardFocus
]
