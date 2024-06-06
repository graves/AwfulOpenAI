Class {
	#name : #AwfulClaudeChatSession,
	#superclass : #OpenAIChatSession,
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulClaudeChatSession >> createMessageWithModel: modelString messages: messagesArray maxTokens: maxTokens system: systemString metadata: metadataDict [
    | payload response |
    payload := Dictionary new.
    payload at: 'model' put: modelString.
    payload at: 'messages' put: messagesArray.
    payload at: 'max_tokens' put: maxTokens.
    systemString ifNotNil: [ payload at: 'system' put: systemString ].
    metadataDict ifNotNil: [ payload at: 'metadata' put: metadataDict ].
    response := sdk postMessage: payload.
    ^ NeoJSONReader fromString: response content asString.
]

{ #category : #accessing }
AwfulClaudeChatSession >> initializeWithSDK: aClaudeSDK [
    sdk := aClaudeSDK.
    model := 'claude-3-opus-20240229'.
]

{ #category : #accessing }
AwfulClaudeChatSession >> submitSystemPrompt: aPromptString [

	self systemPrompt: aPromptString.
]

{ #category : #accessing }
AwfulClaudeChatSession >> systemPrompt: anObject [
	sdk systemPrompt: anObject
]
