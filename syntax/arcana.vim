" Vim syntax file
" Language: Arcana Templating
" Maintainer: Frankie Baffa

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = "arcana"

" DEFAULT GROUPS

highlight default link ArcanaTag Macro
highlight default link ArcanaKeyword Constant
highlight default link ArcanaIllegal SpellBad
highlight default link ArcanaCondition Conditional

" REGION: Ignore

syntax region ArcanaIgnore start=/!{/ end=/}!/
highlight default link ArcanaIgnore Constant

" REGION: Comment

syntax region ArcanaComment start=/#{/ end=/}#/ keepend
highlight default link ArcanaComment Comment

" REGION: Block

syntax cluster ArcanaBlockMembers contains=ArcanaIgnore
syntax cluster ArcanaBlockMembers add=ArcanaComment
syntax cluster ArcanaBlockMembers add=ArcanaTrim
syntax cluster ArcanaBlockMembers add=ArcanaExtendsTag
syntax cluster ArcanaBlockMembers add=ArcanaIfTag
syntax cluster ArcanaBlockMembers add=ArcanaSourceTag
syntax cluster ArcanaBlockMembers add=ArcanaIncludeFileTag
syntax cluster ArcanaBlockMembers add=ArcanaForEachFileTag
syntax cluster ArcanaBlockMembers add=ArcanaForEachItemTag
syntax cluster ArcanaBlockMembers add=ArcanaIncludeContentTag
syntax cluster ArcanaBlockMembers add=ArcanaUnsetItemTag
syntax cluster ArcanaBlockMembers add=ArcanaSetItemTag
syntax cluster ArcanaBlockMembers add=ArcanaWriteContentTag
syntax cluster ArcanaBlockMembers add=ArcanaCopyPathTag
syntax cluster ArcanaBlockMembers add=ArcanaDeletePathTag

syntax region ArcanaBlock matchgroup=ArcanaTag start=/\%(\\\)\@<!(/ end=/\%(\\\)\@<!)/
			\ contained nextgroup=ArcanaBlock contains=@ArcanaBlockMembers

" TYPE: Trim

syntax region ArcanaTrim start=/\\/ end=/[^\s\t]/me=e-1 nextgroup=ArcanaBlock
highlight default link ArcanaTrim ArcanaTag

" TYPE: Alias

" The negative lookahead is required to not match the 'source-file' tag '.{'
let aliasPat = '[a-zA-Z0-9.\-_]\+\%({\)\@!'

execute 'syntax match ArcanaAlias /' . aliasPat . '/ keepend contained'
highlight default link ArcanaAlias Type

" KEYWORD: Content

let contentKeywordPat = '$content'

execute 'syntax match ArcanaContentKeyword /' . contentKeywordPat . '/ contained'
highlight default link ArcanaContentKeyword ArcanaKeyword

" KEYWORD: Loop

" IMPORTANT: The \%(...\) grouping excludes the result from the captured groups,
" allowing for more than 10.
let loopPat = '\$loop'
let loopIndexKeywordPat = loopPat . '\.index'
let loopPositionKeywordPat = loopPat . '\.position'
let loopLengthKeywordPat = loopPat . '\.length'
let loopMaxKeywordPat = loopPat . '\.max'
let loopFirstKeywordPat = loopPat . '\.first'
let loopLastKeywordPat = loopPat . '\.last'
let loopEntryKeywordPat = loopPat . '\.entry'
let loopEntryPathKeywordPat = loopEntryKeywordPat . '\.path'
let loopEntryExtKeywordPat = loopEntryKeywordPat . '\.ext'
let loopEntryStemKeywordPat = loopEntryKeywordPat . '\.stem'
let loopEntryNameKeywordPat = loopEntryKeywordPat . '\.name'
let loopEntryIsFileKeywordPat = loopEntryKeywordPat . '\.is_file'
let loopEntryIsDirKeywordPat = loopEntryKeywordPat . '\.is_dir'

let loopKeywordPat = '\%(' .
			\ loopEntryIsDirKeywordPat . '\|' .
			\ loopEntryIsFileKeywordPat . '\|' .
			\ loopEntryNameKeywordPat . '\|' .
			\ loopEntryStemKeywordPat . '\|' .
			\ loopEntryExtKeywordPat . '\|' .
			\ loopEntryPathKeywordPat . '\|' .
			\ loopEntryKeywordPat . '\|' .
			\ loopLastKeywordPat . '\|' .
			\ loopFirstKeywordPat . '\|' .
			\ loopMaxKeywordPat . '\|' .
			\ loopLengthKeywordPat . '\|' .
			\ loopPositionKeywordPat . '\|' .
			\ loopIndexKeywordPat . '\|' .
			\ loopPat .
			\ '\)'

execute 'syntax match ArcanaLoopKeyword /' . loopKeywordPat . '/ contained'
highlight default link ArcanaLoopKeyword ArcanaKeyword

let aliasLikePat = '\%(' .
			\ aliasPat . '\|' .
			\ contentKeywordPat . '\|' .
			\ loopKeywordPat .
			\ '\)'

syntax cluster ArcanaAliasLikeMembers contains=ArcanaAlias
syntax cluster ArcanaAliasLikeMembers add=ArcanaContentKeyword
syntax cluster ArcanaAliasLikeMembers add=ArcanaLoopKeyword

" TYPE: Path

let pathPat = '"[^"]\{-}"'

execute 'syntax match ArcanaPath /' . pathPat . '/ keepend contained'
highlight default link ArcanaPath String

" TYPE: Alias-Like

let pathLikePat = '\%(' .
			\ pathPat . '\|' .
			\ aliasPat . '\|' .
			\ contentKeywordPat . '\|' .
			\ loopKeywordPat .
			\ '\)'

syntax cluster ArcanaPathLikeMembers contains=ArcanaAlias
syntax cluster ArcanaPathLikeMembers add=ArcanaContentKeyword
syntax cluster ArcanaPathLikeMembers add=ArcanaLoopKeyword
syntax cluster ArcanaPathLikeMembers add=ArcanaPath

" CONDITION: And

let andConditionPat = '&&'

execute 'syntax match ArcanaAndCondition /' . andConditionPat . '/ contained'
highlight default link ArcanaAndCondition ArcanaTag

" CONDITION: Or

let orConditionPat = '||'

execute 'syntax match ArcanaOrCondition /' . orConditionPat . '/ contained'
highlight default link ArcanaOrCondition ArcanaTag

" CONDITION: Not

let notConditionPat = '!'

execute 'syntax match ArcanaNotCondition /' . notConditionPat . '/ contained'
highlight default link ArcanaNotCondition ArcanaCondition

" CONDITION: Empty

let emptyConditionPat = 'empty'

execute 'syntax match ArcanaEmptyCondition /' . emptyConditionPat . '/ contained'
highlight default link ArcanaEmptyCondition ArcanaCondition

" CONDITION: Exists

let existsConditionPat = 'exists'

execute 'syntax match ArcanaExistsCondition /' . existsConditionPat . '/ contained'
highlight default link ArcanaExistsCondition ArcanaCondition

" CONDITION: Eq

let eqConditionPat = '=='

execute 'syntax match ArcanaEqCondition /' . eqConditionPat . '/ contained'
highlight default link ArcanaEqCondition ArcanaCondition

" CONDITION: Ne

let neConditionPat = '!='

execute 'syntax match ArcanaNeCondition /' . neConditionPat . '/ contained'
highlight default link ArcanaNeCondition ArcanaCondition

" CONDITION: Gt

let gtConditionPat = '>'

execute 'syntax match ArcanaGtCondition /' . gtConditionPat . '/ contained'
highlight default link ArcanaGtCondition ArcanaCondition

" CONDITION: Ge

let geConditionPat = '>='

execute 'syntax match ArcanaGeCondition /' . geConditionPat . '/ contained'
highlight default link ArcanaGeCondition ArcanaCondition

" CONDITION: Lt

let ltConditionPat = '<'

execute 'syntax match ArcanaLtCondition /' . ltConditionPat . '/ contained'
highlight default link ArcanaLtCondition ArcanaCondition

" CONDITION: Le

let leConditionPat = '<='

execute 'syntax match ArcanaLeCondition /' . leConditionPat . '/ contained'
highlight default link ArcanaLeCondition ArcanaCondition

let tagEscapePat = '\%(\\\)\@<!'
let tagStartPat = '{\s*'
let tagEndPat = '\s*}'

" TAG: Extends

let extendsTagPat = tagEscapePat . '+' . tagStartPat .
			\ '\%(' .
				\ pathLikePat . '\|' .
				\ pathPat .
			\ '\)' . tagEndPat

execute 'syntax match ArcanaExtendsTag /' . extendsTagPat . '/ contains=@ArcanaPathLikeMembers'
highlight default link ArcanaExtendsTag ArcanaTag

" TAG: If

syntax cluster ArcanaIfTagMembers contains=@ArcanaAliasLikeMembers
syntax cluster ArcanaIfTagMembers add=ArcanaAndCondition
syntax cluster ArcanaIfTagMembers add=ArcanaOrCondition
syntax cluster ArcanaIfTagMembers add=ArcanaNotCondition
syntax cluster ArcanaIfTagMembers add=ArcanaEmptyCondition
syntax cluster ArcanaIfTagMembers add=ArcanaExistsCondition
syntax cluster ArcanaIfTagMembers add=ArcanaEqCondition
syntax cluster ArcanaIfTagMembers add=ArcanaNeCondition
syntax cluster ArcanaIfTagMembers add=ArcanaGtCondition
syntax cluster ArcanaIfTagMembers add=ArcanaGeCondition
syntax cluster ArcanaIfTagMembers add=ArcanaLtCondition
syntax cluster ArcanaIfTagMembers add=ArcanaLeCondition

let ifTagTruthyContentPat = '!\{0,1\}\s*' . aliasLikePat

let ifTagConditionalContentPat = '!\{0,1\}\s*' .
			\ aliasLikePat .
			\ '\s*' .
			\ '\%(' .
				\ emptyConditionPat . '\|' .
				\ existsConditionPat . '\|' .
				\ eqConditionPat . '\s*' . aliasLikePat . '\|' .
				\ neConditionPat . '\s*' . aliasLikePat . '\|' .
				\ gtConditionPat . '\s*' . aliasLikePat . '\|' .
				\ geConditionPat . '\s*' . aliasLikePat . '\|' .
				\ ltConditionPat . '\s*' . aliasLikePat . '\|' .
				\ leConditionPat . '\s*' . aliasLikePat .
			\ '\)'

let ifTagSinglePat = '\%(' . ifTagConditionalContentPat . '\|' . ifTagTruthyContentPat . '\)'

let ifTagMultiPat = ifTagSinglePat . '\s*' .
			\ '\%(' .
				\ '\%(' .
					\ andConditionPat . '\|' .
					\ orConditionPat .
				\ '\)\s*' .
				\ ifTagSinglePat .
			\ '\)*'

let ifTagPat = tagEscapePat . '%' . tagStartPat . ifTagMultiPat . tagEndPat

execute 'syntax match ArcanaIfTag /' . ifTagPat . '/ contains=@ArcanaIfTagMembers nextgroup=ArcanaBlock'
highlight default link ArcanaIfTag ArcanaTag

" TYPE: Modifier

let modPat = '\s*|\s*'

execute 'syntax match ArcanaModifier /' . modPat . '/ contained'
highlight default link ArcanaModifier ArcanaCondition

" KEYWORD: As

let asKeywordPat = 'as'

execute 'syntax match ArcanaAsKeyword /' . asKeywordPat . '/ contained'
highlight default link ArcanaAsKeyword ArcanaKeyword

" MODIFIER: As

syntax cluster ArcanaAsModifierMembers contains=ArcanaAlias
syntax cluster ArcanaAsModifierMembers add=ArcanaModifier
syntax cluster ArcanaAsModifierMembers add=ArcanaAsKeyword

let asModPat = modPat . asKeywordPat . '\s*' . aliasPat

execute 'syntax match ArcanaAsModifier /' . asModPat . '/ contained contains=@ArcanaAsModifierMembers'

" TAG: Source

syntax cluster ArcanaSourceTagMembers contains=@ArcanaPathLikeMembers
syntax cluster ArcanaSourceTagMembers add=ArcanaAsModifier

let sourceTagPat = tagEscapePat . '\.' . tagStartPat .
			\ pathLikePat .
			\ '\%(' . asModPat . '\)\{0,1\}' .
			\ tagEndPat

execute 'syntax match ArcanaSourceTag /' . sourceTagPat . '/ contains=@ArcanaSourceTagMembers'
highlight default link ArcanaSourceTag ArcanaTag

" KEYWORD: Raw

let rawKeywordPat = 'raw'

execute 'syntax match ArcanaRawKeyword /' . rawKeywordPat . '/ contained'
highlight default link ArcanaRawKeyword ArcanaKeyword

" MODIFIER: Raw

syntax cluster ArcanaRawModifierMembers contains=ArcanaModifier
syntax cluster ArcanaRawModifierMembers add=ArcanaRawKeyword

let rawModPat = modPat . rawKeywordPat

execute 'syntax match ArcanaRawModifier /' . rawModPat . '/ contained contains=@ArcanaRawModifierMembers'

" KEYWORD: Md

let mdKeywordPat = 'md'

execute 'syntax match ArcanaMdKeyword /' . mdKeywordPat . '/ contained'
highlight default link ArcanaMdKeyword ArcanaKeyword

" MODIFIER: Md

syntax cluster ArcanaMdModifierMembers contains=ArcanaModifier
syntax cluster ArcanaMdModifierMembers add=ArcanaMdKeyword

let mdModPat = modPat . mdKeywordPat

execute 'syntax match ArcanaMdModifier /' . mdModPat . '/ contained contains=@ArcanaMdModifierMembers'

" TAG: Include-File

syntax cluster ArcanaIncludeFileTagMembers contains=@ArcanaPathLikeMembers
syntax cluster ArcanaIncludeFileTagMembers add=ArcanaRawModifier
syntax cluster ArcanaIncludeFileTagMembers add=ArcanaMdModifier

let includeFileTagPat = tagEscapePat . '&' . tagStartPat .
			\ pathLikePat .
			\ '\%(' . rawModPat . '\|' . mdModPat . '\)\{0,1\}' .
			\ '\%(' . rawModPat . '\|' . mdModPat . '\)\{0,1\}' .
			\ tagEndPat

execute 'syntax match ArcanaIncludeFileTag /' . includeFileTagPat . '/ ' .
			\ 'contains=@ArcanaIncludeFileTagMembers ' .
			\ 'nextgroup=ArcanaBlock'
highlight default link ArcanaIncludeFileTag ArcanaTag

" TAG: Copy Path

let copyPathTagPat = tagEscapePat . '\~' . tagStartPat . tagEndPat
execute 'syntax match ArcanaCopyPathTag /' . copyPathTagPat . '/ ' .
			\ 'nextgroup=ArcanaBlock'
highlight default link ArcanaCopyPathTag ArcanaTag

" TAG: Delete Path

let deletePathTagPat = tagEscapePat . '-' . tagStartPat . tagEndPat
execute 'syntax match ArcanaDeletePathTag /' . deletePathTagPat . '/ ' .
			\ 'nextgroup=ArcanaBlock'
highlight default link ArcanaDeletePathTag ArcanaTag

" TAG: Write Content

let writeContentTagPat = tagEscapePat . '\^' . tagStartPat . tagEndPat
execute 'syntax match ArcanaWriteContentTag /' . writeContentTagPat . '/ ' .
			\ 'nextgroup=ArcanaBlock'
highlight default link ArcanaWriteContentTag ArcanaTag

" KEYWORD: Ext

let extKeywordPat = 'ext'

execute 'syntax match ArcanaExtKeyword /' . extKeywordPat . '/ contained'
highlight default link ArcanaExtKeyword ArcanaKeyword

" MODIFIER: Ext

syntax cluster ArcanaExtModifierMembers contains=ArcanaPath
syntax cluster ArcanaExtModifierMembers add=ArcanaModifier
syntax cluster ArcanaExtModifierMembers add=ArcanaExtKeyword

let extModPat = modPat . extKeywordPat . '\s*' . pathPat

execute 'syntax match ArcanaExtModifier /' . extModPat . '/ contained contains=@ArcanaExtModifierMembers'

" KEYWORD: Reverse

let reverseKeywordPat = 'reverse'

execute 'syntax match ArcanaReverseKeyword /' . reverseKeywordPat . '/ contained'
highlight default link ArcanaReverseKeyword ArcanaKeyword

" MODIFIER: Reverse

syntax cluster ArcanaReverseModifierMembers contains=ArcanaModifier
syntax cluster ArcanaReverseModifierMembers add=ArcanaReverseKeyword

let reverseModPat = modPat . reverseKeywordPat

execute 'syntax match ArcanaReverseModifier /' . reverseModPat . '/ contained contains=@ArcanaReverseModifierMembers'

" KEYWORD: Files

let filesKeywordPat = 'files'

execute 'syntax match ArcanaFilesKeyword /' . filesKeywordPat . '/ contained'
highlight default link ArcanaFilesKeyword ArcanaKeyword

" MODIFIER: Files

syntax cluster ArcanaFilesModifierMembers contains=ArcanaModifier
syntax cluster ArcanaFilesModifierMembers add=ArcanaFilesKeyword

let filesModPat = modPat . filesKeywordPat

execute 'syntax match ArcanaFilesModifier /' . filesModPat . '/ contained contains=@ArcanaFilesModifierMembers'

" KEYWORD: Dirs

let dirsKeywordPat = 'dirs'

execute 'syntax match ArcanaDirsKeyword /' . dirsKeywordPat . '/ contained'
highlight default link ArcanaDirsKeyword ArcanaKeyword

" MODIFIER: Dirs

syntax cluster ArcanaDirsModifierMembers contains=ArcanaModifier
syntax cluster ArcanaDirsModifierMembers add=ArcanaDirsKeyword

let dirsModPat = modPat . dirsKeywordPat

execute 'syntax match ArcanaDirsModifier /' . dirsModPat . '/ contained contains=@ArcanaDirsModifierMembers'

" KEYWORD: In

let inKeywordPat = "in"

execute 'syntax match ArcanaInKeyword /' . inKeywordPat . '/ contained'
highlight default link ArcanaInKeyword ArcanaKeyword

" Type: In Statement

let inStatementStartPat = aliasPat . '\s\+' . inKeywordPat . '\s\+'

execute 'syntax match ArcanaInStatement /' . inStatementStartPat . '/ contained contains=ArcanaInKeyword,ArcanaAlias'

" TAG: For-Each File

let forEachFileTagModsPat = '\%(' . extModPat . '\|' . reverseModPat . '\|' . dirsModPat . '\|' . filesModPat . '\)\{0,1\}'

let forEachFileTagPat = tagEscapePat . '\*' . tagStartPat .
			\ inStatementStartPat . pathLikePat .
			\ forEachFileTagModsPat .
			\ forEachFileTagModsPat .
			\ forEachFileTagModsPat .
			\ forEachFileTagModsPat .
			\ tagEndPat

execute 'syntax match ArcanaForEachFileTag /' . forEachFileTagPat . '/ '
			\ 'contains=ArcanaInStatement,@ArcanaPathLikeMembers,ArcanaExtModifier,ArcanaReverseModifier,ArcanaFilesModifier,ArcanaDirsModifier ' .
			\ 'nextgroup=ArcanaBlock'
highlight default link ArcanaForEachFileTag ArcanaTag

" KEYWORD: Paths

let pathsKeywordPat = 'paths'

execute 'syntax match ArcanaPathsKeyword /' . pathsKeywordPat . '/ contained'
highlight default link ArcanaPathsKeyword ArcanaKeyword

" MODIFIER: Paths

syntax cluster ArcanaPathsModifierMembers contains=ArcanaModifier
syntax cluster ArcanaPathsModifierMembers add=ArcanaPathsKeyword

let pathsModPat = modPat . pathsKeywordPat

execute 'syntax match ArcanaPathsModifier /' . pathsModPat . '/ contained contains=@ArcanaPathsModifierMembers'

" CONDITION: Nullable

let nullableConditionPat = '?'

execute 'syntax match ArcanaNullableCondition /' . nullableConditionPat . '/ contained'
highlight default link ArcanaNullableCondition ArcanaCondition

" TAG: For-Each Item

let forEachItemTagModsPat = '\%(' . pathsModPat . '\|' . reverseModPat . '\)\{0,1\}'

let forEachItemTagPat = tagEscapePat . '@' . tagStartPat .
			\ inStatementStartPat . aliasPat . nullableConditionPat . '\{0,1}' .
			\ forEachItemTagModsPat .
			\ forEachItemTagModsPat .
			\ tagEndPat

execute 'syntax match ArcanaForEachItemTag /' . forEachItemTagPat . '/ '
			\ 'contains=ArcanaInStatement,ArcanaAlias,ArcanaNullableCondition,ArcanaPathsModifier,ArcanaReverseModifier ' .
			\ 'nextgroup=ArcanaBlock'
highlight default link ArcanaForEachItemTag ArcanaTag

" KEYWORD: Lower

let lowerKeywordPat = 'lower'

execute 'syntax match ArcanaLowerKeyword /' . lowerKeywordPat . '/ contained'
highlight default link ArcanaLowerKeyword ArcanaKeyword

" MODIFIER: Lower

syntax cluster ArcanaLowerModifierMembers contains=ArcanaModifier
syntax cluster ArcanaLowerModifierMembers add=ArcanaLowerKeyword

let lowerModPat = modPat . lowerKeywordPat

execute 'syntax match ArcanaLowerModifier /' . lowerModPat . '/ contained contains=@ArcanaLowerModifierMembers'

" KEYWORD: Upper

let upperKeywordPat = 'upper'

execute 'syntax match ArcanaUpperKeyword /' . upperKeywordPat . '/ contained'
highlight default link ArcanaUpperKeyword ArcanaKeyword

" MODIFIER: Upper

syntax cluster ArcanaUpperModifierMembers contains=ArcanaModifier
syntax cluster ArcanaUpperModifierMembers add=ArcanaUpperKeyword

let upperModPat = modPat . upperKeywordPat

execute 'syntax match ArcanaUpperModifier /' . upperModPat . '/ contained contains=@ArcanaUpperModifierMembers'

" KEYWORD: Path

let pathKeywordPat = 'path'

execute 'syntax match ArcanaPathKeyword /' . pathKeywordPat . '/ contained'
highlight default link ArcanaPathKeyword ArcanaKeyword

" MODIFIER: Path

syntax cluster ArcanaPathModifierMembers contains=ArcanaModifier
syntax cluster ArcanaPathModifierMembers add=ArcanaPathKeyword

let pathModPat = modPat . pathKeywordPat

execute 'syntax match ArcanaPathModifier /' . pathModPat . '/ contained contains=@ArcanaPathModifierMembers'

" KEYWORD: Filename

let filenameKeywordPat = 'filename'

execute 'syntax match ArcanaFilenameKeyword /' . filenameKeywordPat . '/ contained'
highlight default link ArcanaFilenameKeyword ArcanaKeyword

" MODIFIER: Filename

syntax cluster ArcanaFilenameModifierMembers contains=ArcanaModifier
syntax cluster ArcanaFilenameModifierMembers add=ArcanaFilenameKeyword

let filenameModPat = modPat . filenameKeywordPat

execute 'syntax match ArcanaFilenameModifier /' . filenameModPat . '/ contained contains=@ArcanaFilenameModifierMembers'

" KEYWORD: Trim

let trimKeywordPat = 'trim'

execute 'syntax match ArcanaTrimKeyword /' . trimKeywordPat . '/ contained'
highlight default link ArcanaTrimKeyword ArcanaKeyword

" MODIFIER: Trim

syntax cluster ArcanaTrimModifierMembers contains=ArcanaModifier
syntax cluster ArcanaTrimModifierMembers add=ArcanaTrimKeyword

let trimModPat = modPat . trimKeywordPat

execute 'syntax match ArcanaTrimModifier /' . trimModPat . '/ contained contains=@ArcanaTrimModifierMembers'

" KEYWORD: Json

let jsonKeywordPat = 'json'

execute 'syntax match ArcanaJsonKeyword /' . jsonKeywordPat . '/ contained'
highlight default link ArcanaJsonKeyword ArcanaKeyword

" MODIFIER: Json

syntax cluster ArcanaJsonModifierMembers contains=ArcanaModifier
syntax cluster ArcanaJsonModifierMembers add=ArcanaJsonKeyword

let jsonModPat = modPat . jsonKeywordPat

execute 'syntax match ArcanaJsonModifier /' . jsonModPat . '/ contained contains=@ArcanaJsonModifierMembers'

" KEYWORD: Replace

let replaceKeywordPat = 'replace'

execute 'syntax match ArcanaReplaceKeyword /' . replaceKeywordPat . '/ contained'
highlight default link ArcanaReplaceKeyword ArcanaKeyword

" MODIFIER: Replace

syntax cluster ArcanaReplaceModifierMembers contains=ArcanaPath
syntax cluster ArcanaReplaceModifierMembers add=ArcanaModifier
syntax cluster ArcanaReplaceModifierMembers add=ArcanaReplaceKeyword

let replaceModPat = modPat . replaceKeywordPat . '\s*' . pathPat . '\s*' . pathPat

execute 'syntax match ArcanaReplaceModifier /' . replaceModPat . '/ contained contains=@ArcanaReplaceModifierMembers'

" KEYWORD: Split

let splitKeywordPat = 'split'

execute 'syntax match ArcanaSplitKeyword /' . splitKeywordPat . '/ contained'
highlight default link ArcanaSplitKeyword ArcanaKeyword

" TYPE: Number

let numPat = '[0-9]\+'

execute 'syntax match ArcanaNumber /' . numPat . '/ contained'
highlight default link ArcanaNumber Title

" MODIFIER: Split

syntax cluster ArcanaSplitModifierMembers contains=ArcanaModifier
syntax cluster ArcanaSplitModifierMembers add=ArcanaSplitKeyword
syntax cluster ArcanaSplitModifierMembers add=ArcanaNumber

let splitModPat = modPat . splitKeywordPat . '\s*' . numPat . '\s*' . numPat

execute 'syntax match ArcanaSplitModifier /' . splitModPat . '/ contained contains=@ArcanaSplitModifierMembers'

" TAG: Include-Content

syntax cluster ArcanaIncludeContentTagMembers contains=@ArcanaAliasLikeMembers
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaNullableCondition
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaLowerModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaUpperModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaPathModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaReplaceModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaFilenameModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaTrimModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaSplitModifier
syntax cluster ArcanaIncludeContentTagMembers add=ArcanaJsonModifier

let includeContentModsPat =
			\ '\%(' .
				\ lowerModPat . '\|' . upperModPat . '\|' . pathModPat . '\|' .
				\ filenameModPat . '\|' . trimModPat . '\|' .
				\ splitModPat . '\|' . replaceModPat . '\|' . jsonModPat .
			\ '\)\{0,1\}'

let includeContentTagPat = tagEscapePat . '\$' . tagStartPat .
			\ aliasLikePat . nullableConditionPat . '\{0,1\}' .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ includeContentModsPat .
			\ tagEndPat

execute 'syntax match ArcanaIncludeContentTag /' . includeContentTagPat . '/ contains=@ArcanaIncludeContentTagMembers'
highlight default link ArcanaIncludeContentTag ArcanaTag

" TAG: Unset Item

syntax cluster ArcanaUnsetItemTagMembers contains=@ArcanaAliasLikeMembers

let unsetItemTagPat = tagEscapePat . '\/' . tagStartPat . aliasLikePat . tagEndPat

execute 'syntax match ArcanaUnsetItemTag /' . unsetItemTagPat . '/ contains=@ArcanaUnsetItemTagMembers'
highlight default link ArcanaUnsetItemTag ArcanaTag

syntax cluster ArcanaJsonTypesMembers contains=ArcanaJsonString
syntax cluster ArcanaJsonTypesMembers add=ArcanaJsonNumber
syntax cluster ArcanaJsonTypesMembers add=ArcanaJsonBoolean
syntax cluster ArcanaJsonTypesMembers add=ArcanaJsonNull
syntax cluster ArcanaJsonTypesMembers add=ArcanaJsonObject
syntax cluster ArcanaJsonTypesMembers add=ArcanaJsonArray
syntax cluster ArcanaJsonTypesMembers add=@ArcanaBlockMembers

" TYPE: Json Key

execute 'syntax match ArcanaJsonKey /' . pathPat . '/ contained'
highlight default link ArcanaJsonKey ArcanaAlias

execute 'syntax match ArcanaJsonKeyDlim /' . pathPat . ':\s*/ contains=ArcanaJsonKey '
			\ 'contained nextgroup=@ArcanaJsonTypesMembers'
highlight default link ArcanaJsonKeyDlim ArcanaTag

" TYPE: Json Comma

syntax match ArcanaJsonComma /,/ contained nextgroup=@ArcanaJsonTypesMembers
highlight default link ArcanaJsonComma ArcanaTag

" TYPE: Json String

execute 'syntax match ArcanaJsonString /' . pathPat . '/ contained ' .
			\ 'nextgroup=ArcanaJsonComma ' .
			\ 'contains=@ArcanaBlockMembers'
highlight default link ArcanaJsonString ArcanaPath

" TYPE: Json Number
syntax match ArcanaJsonNumber /[0-9.]\+/ contained nextgroup=ArcanaJsonComma
highlight default link ArcanaJsonNumber ArcanaNumber

" TYPE: Json Boolean
syntax match ArcanaJsonBoolean /true\|false/ contained nextgroup=ArcanaJsonComma
highlight default link ArcanaJsonBoolean ArcanaCondition

" TYPE: Json Null
syntax match ArcanaJsonNull /null/ contained nextgroup=ArcanaJsonComma
highlight default link ArcanaJsonNull ArcanaComment

" REGION: Json Object

syntax region ArcanaJsonObject start=/{/ end=/}/ contained nextgroup=ArcanaJsonComma
			\ contains=ArcanaJsonKeyDlim,@ArcanaBlockMembers
highlight default link ArcanaJsonObject Statement

" REGION: Json Array

syntax region ArcanaJsonArray start=/\[/ end=/\]/ contained nextgroup=ArcanaJsonComma
			\ contains=@ArcanaJsonTypesMembers
highlight default link ArcanaJsonArray Conditional

syntax cluster ArcanaNextJsonBlockMembers contains=ArcanaJsonBlock

" REGION: Json Block

syntax region ArcanaJsonBlock matchgroup=ArcanaTag start=/(/ end=/)/
			\ contained contains=@ArcanaJsonTypesMembers

" TAG: Set-Item

syntax cluster ArcanaSetItemTagMembers contains=@ArcanaAliasLikeMembers

let setItemTagPat = tagEscapePat . '=' . tagStartPat . '\%(' . aliasLikePat . '\)\{0,1\}' . tagEndPat

execute 'syntax match ArcanaSetItemTag /' . setItemTagPat . '/ '
			\ 'contains=@ArcanaSetItemTagMembers '
			\ 'nextgroup=ArcanaJsonBlock'
highlight default link ArcanaSetItemTag ArcanaTag

syntax sync fromstart
