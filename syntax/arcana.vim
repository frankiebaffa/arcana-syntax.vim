" Vim syntax file
" Language: Arcana Templating
" Maintainer: Frankie Baffa

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = "arcana"

" DEFAULT: Groups

highlight default link ArcanaTag Macro
highlight default link ArcanaKeyword Constant
highlight default link ArcanaIllegal SpellBad
highlight default link ArcanaCondition Conditional

" REGION: Comment

syntax region ArcanaComment start=/#{/ end=/}#/ keepend
highlight default link ArcanaComment Comment

" REGION: Block

syntax cluster ArcanaBlockMembers contains=ArcanaComment,ArcanaTrim,
			\ ArcanaExtendsTag,ArcanaIfTag,ArcanaSourceTag,ArcanaIncludeFileTag,
			\ ArcanaForFileTag,ArcanaForItemTag,ArcanaIncludeContentTag,
			\ ArcanaUnsetItemTag,ArcanaSetItemTag,ArcanaWriteContentTag,
			\ ArcanaCopyPathTag,ArcanaDeletePathTag

syntax region ArcanaBlock matchgroup=ArcanaTag start=/\%(\\\)\@<!(/ skip=/\\)/ end=/)/
			\ contained
			\ nextgroup=@ArcanaTrimOrBlockMembers
			\ contains=@ArcanaBlockMembers

" REGION: Trim

syntax region ArcanaTrim start=/\\/ end=/[^\s\t]/me=e-1 nextgroup=ArcanaBlock
highlight default link ArcanaTrim ArcanaTag

syntax cluster ArcanaTrimOrBlockMembers contains=ArcanaBlock
syntax cluster ArcanaTrimOrBlockMembers add=ArcanaTrim

" KEYWORD: Content

syntax keyword ArcanaContentKeyword $content contained
highlight default link ArcanaContentKeyword ArcanaKeyword

" KEYWORD: Loop

syntax cluster ArcanaLoopKeywordMembers contains=ArcanaLoopKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopIndexKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopPositionKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopLengthKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopMaxKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopFirstKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopLastKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryPathKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryExtKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryStemKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryNameKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryIsFileKeyword
syntax cluster ArcanaLoopKeywordMembers add=ArcanaLoopEntryIsDirKeyword

syntax match ArcanaLoopKeyword /\$loop/ contained
highlight default link ArcanaLoopKeyword ArcanaKeyword

syntax match ArcanaLoopIndexKeyword /\$loop\.index/ contained
highlight default link ArcanaLoopIndexKeyword ArcanaKeyword

syntax match ArcanaLoopPositionKeyword /\$loop\.position/ contained
highlight default link ArcanaLoopPositionKeyword ArcanaKeyword

syntax match ArcanaLoopLengthKeyword /\$loop\.length/ contained
highlight default link ArcanaLoopLengthKeyword ArcanaKeyword

syntax match ArcanaLoopMaxKeyword /\$loop\.max/ contained
highlight default link ArcanaLoopMaxKeyword ArcanaKeyword

syntax match ArcanaLoopFirstKeyword /\$loop\.first/ contained
highlight default link ArcanaLoopFirstKeyword ArcanaKeyword

syntax match ArcanaLoopLastKeyword /\$loop\.last/ contained
highlight default link ArcanaLoopLastKeyword ArcanaKeyword

syntax match ArcanaLoopEntryKeyword /\$loop\.entry/ contained
highlight default link ArcanaLoopEntryKeyword ArcanaKeyword

syntax match ArcanaLoopEntryPathKeyword /\$loop\.entry\.path/ contained
highlight default link ArcanaLoopEntryPathKeyword ArcanaKeyword

syntax match ArcanaLoopEntryExtKeyword /\$loop\.entry\.ext/ contained
highlight default link ArcanaLoopEntryExtKeyword ArcanaKeyword

syntax match ArcanaLoopEntryStemKeyword /\$loop\.entry\.stem/ contained
highlight default link ArcanaLoopEntryStemKeyword ArcanaKeyword

syntax match ArcanaLoopEntryNameKeyword /\$loop\.entry\.name/ contained
highlight default link ArcanaLoopEntryNameKeyword ArcanaKeyword

syntax match ArcanaLoopEntryIsFileKeyword /\$loop\.entry\.is_file/ contained
highlight default link ArcanaLoopEntryIsFileKeyword ArcanaKeyword

syntax match ArcanaLoopEntryIsDirKeyword /\$loop\.entry\.is_dir/ contained
highlight default link ArcanaLoopEntryIsDirKeyword ArcanaKeyword

" KEYWORD: In

syntax keyword ArcanaInKeyword in contained
highlight default link ArcanaInKeyword ArcanaKeyword

" CONDITION: Nullable

syntax match ArcanaNullableCondition /?/ contained
highlight default link ArcanaNullableCondition ArcanaCondition

" CONDITION: And

syntax match ArcanaAndCondition /&&/ contained
highlight default link ArcanaAndCondition ArcanaCondition

" CONDITION: Or

syntax match ArcanaOrCondition /||/ contained
highlight default link ArcanaOrCondition ArcanaCondition

" CONDITION: Not

syntax match ArcanaNotCondition /!/ contained
highlight default link ArcanaNotCondition ArcanaCondition

" CONDITION: Empty

syntax keyword ArcanaEmptyCondition empty contained
highlight default link ArcanaEmptyCondition ArcanaCondition

" CONDITION: Exists

syntax keyword ArcanaExistsCondition exists contained
highlight default link ArcanaExistsCondition ArcanaCondition

" CONDITION: Eq

syntax match ArcanaEqCondition /==/ contained
highlight default link ArcanaEqCondition ArcanaCondition

" CONDITION: Ne

syntax match ArcanaNeCondition /!=/ contained
highlight default link ArcanaNeCondition ArcanaCondition

" CONDITION: Gt

syntax match ArcanaGtCondition />/ contained
highlight default link ArcanaGtCondition ArcanaCondition

" CONDITION: Ge

syntax match ArcanaGeCondition />=/ contained
highlight default link ArcanaGeCondition ArcanaCondition

" CONDITION: Lt

syntax match ArcanaLtCondition /</ contained
highlight default link ArcanaLtCondition ArcanaCondition

" CONDITION: Le

syntax match ArcanaLeCondition /<=/ contained
highlight default link ArcanaLeCondition ArcanaCondition

" CORETYPE: Alias

syntax cluster ArcanaAliasMembers contains=ArcanaContentKeyword,
			\ @ArcanaLoopKeywordMembers,ArcanaNullableCondition

syntax cluster ArcanaAfterAliasMembers contains=ArcanaInKeyword,
			\ ArcanaEmptyCondition,ArcanaExistsCondition,ArcanaAlias,ArcanaPath

syntax match ArcanaAlias /\s*[a-zA-Z\$]\%([a-zA-Z0-9.\-_]\)*?\{0,1\}\s*/
			\ contained
			\ contains=@ArcanaAliasMembers
			\ nextgroup=@ArcanaAfterAliasMembers
highlight default link ArcanaAlias Type

" CORETYPE: Path

syntax region ArcanaPath start=/\s*"/ skip=/\\"/ end=/"\s*/ contained
			\ contains=@ArcanaBlockMembers
			\ nextgroup=ArcanaAlias,ArcanaPath
highlight default link ArcanaPath String

" Json Values

syntax cluster ArcanaJsonValues contains=@ArcanaBlockMembers,ArcanaJsonString,
			\ ArcanaJsonNumber,ArcanaJsonBoolean,ArcanaJsonNull,
			\ ArcanaJsonObject,ArcanaJsonArray

" JSONTYPE: JsonString

syntax region ArcanaJsonString start=/\s*\%(\\"\)\@<!"/ skip=/\\"/ end=/"\s*/
			\ contained
			\ contains=@ArcanaBlockMembers
highlight default link ArcanaJsonString String

" JSONTYPE: JsonNumber

syntax match ArcanaJsonNumber /[0-9]\+\%(\.[0-9]\+\)\{0,1\}/ contained
highlight default link ArcanaJsonNumber ArcanaNumber

" JSONTYPE: JsonTrue

syntax keyword ArcanaJsonTrue true contained
highlight default link ArcanaJsonTrue Boolean

" JSONTYPE: JsonFalse

syntax keyword ArcanaJsonFalse false contained
highlight default link ArcanaJsonFalse Boolean

" JSONTYPE: JsonBoolean

syntax cluster ArcanaJsonBoolean contains=ArcanaJsonTrue,ArcanaJsonFalse

" JSONTYPE: JsonNull

syntax keyword ArcanaJsonNull null contained
highlight default link ArcanaJsonNull Comment

" JSONTYPE: JsonComma

syntax match ArcanaJsonComma /\s*,\s*/ contained
highlight default link ArcanaJsonComma ArcanaTag

" JSONTYPE: JsonKeyDelimiter

syntax match ArcanaJsonObjectKeyDelimiter /\s*:\s*/ contained
			\ nextgroup=@ArcanaJsonValues
highlight default link ArcanaJsonObjectKeyDelimiter ArcanaTag

" JSONTYPE: JsonKey

syntax region ArcanaJsonObjectKey start=/\s*\%(\\"\)\@<!"/ skip=/\\"/ end=/"\s*/ contained
			\ contains=@ArcanaBlockMembers
			\ nextgroup=ArcanaJsonObjectKeyDelimiter
highlight default link ArcanaJsonObjectKey ArcanaAlias

" JSONREGION: JsonObject

syntax cluster ArcanaJsonObjectMembers contains=ArcanaJsonObjectKey,
			\ ArcanaJsonComma

syntax region ArcanaJsonObject matchgroup=Statement
			\ start=/\s*\%(\\\)\@<!{/ skip=/\\}/ end=/}\s*/
			\ contained
			\ contains=@ArcanaJsonObjectMembers

" JSONREGION: JsonArray

syntax cluster ArcanaJsonArrayMembers contains=@ArcanaJsonValues,ArcanaJsonComma

syntax region ArcanaJsonArray matchgroup=Conditional
			\ start=/\s*\%(\\\)\@<!\[/ skip=/\\\]/ end=/\]\s*/
			\ contained
			\ contains=@ArcanaJsonArrayMembers

syntax cluster ArcanaJsonBlockMembers contains=@ArcanaBlockMembers,@ArcanaJsonValues

" REGION: Json Block

syntax region ArcanaJsonBlock matchgroup=ArcanaTag start=/\%(\\\)\@<!(/ skip=/\\)/ end=/)/
			\ contained
			\ contains=@ArcanaJsonBlockMembers

" CORETYPE: Path-Like

syntax cluster ArcanaPathLikeMembers contains=ArcanaAlias,ArcanaPath

" MODIFIER: Lower

syntax keyword ArcanaLowerKeyword lower contained
highlight default link ArcanaLowerKeyword ArcanaKeyword

" MODIFIER: Upper

syntax keyword ArcanaUpperKeyword upper contained
highlight default link ArcanaUpperKeyword ArcanaKeyword

" MODIFIER: Path

syntax keyword ArcanaPathKeyword path contained
highlight default link ArcanaPathKeyword ArcanaKeyword

" MODIFIER: Filename

syntax keyword ArcanaFilenameKeyword filename contained
highlight default link ArcanaFilenameKeyword ArcanaKeyword

" MODIFIER: Trim

syntax keyword ArcanaTrimKeyword trim contained
highlight default link ArcanaTrimKeyword ArcanaKeyword

" MODIFIER: Json

syntax keyword ArcanaJsonKeyword json contained
highlight default link ArcanaJsonKeyword ArcanaKeyword

" MODIFIER: Replace

syntax keyword ArcanaReplaceKeyword replace contained nextgroup=ArcanaPath
highlight default link ArcanaReplaceKeyword ArcanaKeyword

" TYPE: Number

syntax match ArcanaNumber /\s*[0-9]\+\%(\.[0-9]\)*\s*/ contained nextgroup=ArcanaNumber
highlight default link ArcanaNumber Title

" KEYWORD: Split

syntax keyword ArcanaSplitKeyword split contained nextgroup=ArcanaNumber
highlight default link ArcanaSplitKeyword ArcanaKeyword

" MODIFIER: As

syntax keyword ArcanaAsKeyword as contained nextgroup=ArcanaAlias
highlight default link ArcanaAsKeyword ArcanaKeyword

" MODIFIER: Raw

syntax keyword ArcanaRawKeyword raw contained
highlight default link ArcanaRawKeyword ArcanaKeyword

" MODIFIER: Md

syntax keyword ArcanaMdKeyword md contained
highlight default link ArcanaMdKeyword ArcanaKeyword

" MODIFIER: Ext

syntax keyword ArcanaExtKeyword ext contained
highlight default link ArcanaExtKeyword ArcanaKeyword

" MODIFIER: Reverse

syntax keyword ArcanaReverseKeyword reverse contained
highlight default link ArcanaReverseKeyword ArcanaKeyword

" MODIFIER: Files

syntax keyword ArcanaFilesKeyword files contained
highlight default link ArcanaFilesKeyword ArcanaKeyword

" MODIFIER: Dirs

syntax keyword ArcanaDirsKeyword dirs contained
highlight default link ArcanaDirsKeyword ArcanaKeyword

" MODIFIER: Paths

syntax keyword ArcanaPathsKeyword paths contained
highlight default link ArcanaPathsKeyword ArcanaKeyword

" TAG: If

syntax cluster ArcanaIfTagMembers contains=ArcanaAndCondition,
			\ ArcanaOrCondition,ArcanaNotCondition,ArcanaEmptyCondition,
			\ ArcanaExistsCondition,ArcanaEqCondition,ArcanaNeCondition,
			\ ArcanaGtCondition,ArcanaGeCondition,ArcanaLtCondition,
			\ ArcanaLeCondition,@ArcanaPathLikeMembers

syntax region ArcanaIfTag matchgroup=ArcanaTag start=/\%(\\\)\@<!%{/ end=/}/
			\ contains=@ArcanaIfTagMembers
			\ nextgroup=@ArcanaTrimOrBlockMembers

" TAG: Extends

syntax region ArcanaExtendsTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!+{/ end=/}/
			\ contains=@ArcanaPathLikeMembers

" MODIFIER: Source Modifier

syntax cluster ArcanaSourceTagModifierMembers contains=ArcanaAsKeyword

syntax match ArcanaSourceTagModifier /\s*|\s*/ contained
			\ nextgroup=@ArcanaSourceTagModifierMembers
highlight default link ArcanaSourceTagModifier ArcanaTag

" TAG: Source

syntax cluster ArcanaSourceTagMembers contains=@ArcanaPathLikeMembers

syntax region ArcanaSourceTag matchgroup=ArcanaTag
			\ start=/\(\\\.\)\@<!\.{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaSourceTagMembers

" MODIFIER: Include-File Modifier

syntax cluster ArcanaIncludeFileModifierMembers
			\ contains=ArcanaRawKeyword,ArcanaMdKeyword

syntax match ArcanaIncludeFileModifier /\s*|\s*/ contained
			\ nextgroup=@ArcanaIncludeFileModifierMembers
highlight default link ArcanaIncludeFileModifier ArcanaTag

" TAG: Include-File

syntax cluster ArcanaIncludeFileTagMembers
			\ contains=@ArcanaPathLikeMembers,ArcanaIncludeFileModifier

syntax region ArcanaIncludeFileTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!&{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaIncludeFileTagMembers
			\ nextgroup=@ArcanaTrimOrBlockMembers

" TAG: Copy-Path

syntax cluster ArcanaCopyPathTagMembers contains=@ArcanaPathLikeMembers

syntax region ArcanaCopyPathTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!\~{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaCopyPathTagMembers

" TAG: Delete-Path

syntax cluster ArcanaDeletePathTagMembers contains=@ArcanaPathLikeMembers

syntax region ArcanaDeletePathTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!-{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaDeletePathTagMembers

" TAG: Write-Content

syntax cluster ArcanaWriteContentTagMembers contains=@ArcanaPathLikeMembers

syntax region ArcanaWriteContentTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!\^{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaWriteContentTagMembers
			\ nextgroup=@ArcanaTrimOrBlockMembers

" MODIFIER: For-File Modifier

syntax cluster ArcanaForFileTagModifierMembers contains=ArcanaExtKeyword
syntax cluster ArcanaForFileTagModifierMembers add=ArcanaReverseKeyword
syntax cluster ArcanaForFileTagModifierMembers add=ArcanaFilesKeyword
syntax cluster ArcanaForFileTagModifierMembers add=ArcanaDirsKeyword

syntax match ArcanaForFileTagModifier /\s*|\s*/ contained
			\ nextgroup=@ArcanaForFileTagModifierMembers
highlight default link ArcanaForFileTagModifier ArcanaTag

" TAG: For-File

syntax cluster ArcanaForFileTagMembers contains=ArcanaAlias
syntax cluster ArcanaForFileTagMembers add=@ArcanaPathLikeMembers
syntax cluster ArcanaForFileTagMembers add=ArcanaInKeyword
syntax cluster ArcanaForFileTagMembers add=ArcanaForFileTagModifier

syntax region ArcanaForFileTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!\*{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaForFileTagMembers
			\ nextgroup=@ArcanaTrimOrBlockMembers

" MODIFIER: For-Item Modifier

syntax cluster ArcanaForItemTagModifierMembers contains=ArcanaPathsKeyword
syntax cluster ArcanaForItemTagModifierMembers add=ArcanaReverseKeyword

syntax match ArcanaForItemTagModifier /\s*|\s*/ contained
			\ nextgroup=@ArcanaForItemTagModifierMembers
highlight default link ArcanaForItemTagModifier ArcanaTag

" TAG: For-Item

syntax cluster ArcanaForItemTagMembers contains=ArcanaAlias
syntax cluster ArcanaForItemTagMembers add=ArcanaInKeyword
syntax cluster ArcanaForItemTagMembers add=ArcanaForItemTagModifier

syntax region ArcanaForItemTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!@{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaForItemTagMembers
			\ nextgroup=@ArcanaTrimOrBlockMembers

" MODIFIER: Include-Content Modifier

syntax cluster ArcanaIncludeContentTagModifierMembers contains=ArcanaLowerKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaUpperKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaPathKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaFilenameKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaTrimKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaJsonKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaReplaceKeyword
syntax cluster ArcanaIncludeContentTagModifierMembers add=ArcanaSplitKeyword

syntax match ArcanaIncludeContentTagModifier /\s*|\s*/ contained
			\ nextgroup=@ArcanaIncludeContentTagModifierMembers
highlight default link ArcanaIncludeContentTagModifier ArcanaTag

" TAG: Include-Content

syntax cluster ArcanaIncludeContentTagMembers contains=ArcanaAlias
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaIncludeContentTagModifier

syntax region ArcanaIncludeContentTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!\${/ skip=/\\}/ end=/}/
			\ contains=@ArcanaIncludeContentTagMembers

" TAG: Unset-Item

syntax cluster ArcanaUnsetItemTagMembers contains=ArcanaAlias

syntax region ArcanaUnsetItemTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!\/{/ skip=/\\}/ end=/}/
			\ contains=@ArcanaUnsetItemTagMembers

" TAG: Set-Item

syntax cluster ArcanaSetItemTagMembers contains=ArcanaAlias

syntax region ArcanaSetItemTag matchgroup=ArcanaTag
			\ start=/\%(\\\)\@<!={/ skip=/\\}/ end=/}/
			\ contains=@ArcanaSetItemTagMembers
			\ nextgroup=ArcanaJsonBlock
