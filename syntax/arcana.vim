" Vim syntax file
" Language: Arcana Templating
" Maintainer: Frankie Baffa

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = "arcana"

syn match arcanaPath '".\{-}"' contained
hi def link arcanaPath String

syn match arcanaIllegalPath '".\{-}"' contained
hi def link arcanaIllegalPath SpellBad

syn match arcanaUnmatchedStartblock '\(\\\)\@<!{'
hi def link arcanaUnmatchedStartblock SpellBad

syn match arcanaUnmatchedEndblock '\(\\\)\@<!}'
hi def link arcanaUnmatchedEndblock SpellBad

syn match arcanaLoopContext /\$loop/
			\ contained
hi def link arcanaLoopContext Statement

syn match arcanaContentContext /\$content/
			\ contained
hi def link arcanaContentContext Statement

syn match arcanaAlias '[a-zA-Z0-9_\-\.$]\+\({\)\@!'
			\ contained
			\ contains=arcanaLoopContext,arcanaContentContext,arcanaIllegalRootAlias
hi def link arcanaAlias Type

syn match arcanaIllegalRootAlias /\$root/ contained
hi def link arcanaIllegalRootAlias SpellBad

syn match arcanaRootAlias /\$root/
			\ contained
hi def link arcanaRootAlias Statement

syn keyword arcanaInKeyword in
			\ contained
hi def link arcanaInKeyword Statement

syn keyword arcanaExistsKeyword exists
			\ contained
hi def link arcanaExistsKeyword Statement

syn keyword arcanaEmptyKeyword empty
			\ contained
hi def link arcanaEmptyKeyword Statement

syn match arcanaNotCondition '!'
			\ contained
hi def link arcanaNotCondition Character

syn match arcanaNullableOperator '?'
			\ contained
hi def link arcanaNullableOperator Character

syn match arcanaTrimMod /|\s*trim\s*/ms=s+1
			\ contained
hi def link arcanaTrimMod Conditional

syn match arcanaExtensionMod /|\s*ext\s*/ms=s+1
			\ contained
			\ nextgroup=arcanaPath
hi def link arcanaExtensionMod Conditional

syn match arcanaReverseMod /|\s*reverse\s*/ms=s+1
			\ contained
hi def link arcanaReverseMod Conditional

syn match arcanaPathsMod /|\s*paths\s*/ms=s+1
			\ contained
hi def link arcanaPathsMod Conditional

syn match arcanaFilenameMod /|\s*filename\s*/ms=s+1
			\ contained
hi def link arcanaFilenameMod Conditional

syn match arcanaMdMod /|\s*md\s*/ms=s+1
			\ contained
hi def link arcanaMdMod Conditional

syn match arcanaRawMod /|\s*raw\s*/ms=s+1
			\ contained
hi def link arcanaRawMod Conditional

syn match arcanaSealedMod /|\s*sealed\s*/ms=s+1
			\ contained
hi def link arcanaSealedMod Conditional

syn match arcanaAsMod /|\s*as\s*/ms=s+1
			\ contained
hi def link arcanaAsMod Conditional

syn match arcanaReplaceMod /|\s*replace\s*/ms=s+1
			\ nextgroup=arcanaReplaceString
			\ contained
hi def link arcanaReplaceMod Conditional

syn match arcanaReplaceString /\s*".\{-}"\s*/
			\ nextgroup=arcanaReplaceString
			\ contained
hi def link arcanaReplaceString String

syn match arcanaUpperMod /|\s*upper\s*/ms=s+1
			\ contained
hi def link arcanaUpperMod Conditional

syn match arcanaSplitMod /|\s*split\s*/ms=s+1
			\ contained
			\ nextgroup=arcanaSplitNum
hi def link arcanaSplitMod Conditional

syn match arcanaSplitNum /\s*[0-9]\+\s*/
			\ contained
			\ nextgroup=arcanaSplitNum
hi def link arcanaSplitNum Constant

syn match arcanaLowerMod /|\s*lower\s*/ms=s+1
			\ contained
hi def link arcanaLowerMod Conditional

syn match arcanaPathMod /|\s*path\s*/ms=s+1
			\ contained
hi def link arcanaPathMod Conditional

syn match arcanaArrayMod /|\s*array\s*/ms=s+1
			\ contained
hi def link arcanaArrayMod Conditional

syn match arcanaPopMod /|\s*pop\s*/ms=s+1
			\ contained
hi def link arcanaPopMod Conditional

syn region arcanaBlock start='\(\\\)\@<!{' end='\(\\\)\@<!}'
			\ contains=arcanaIgnoreTag,arcanaCommentTag,arcanaSourceTag,arcanaIfTag,
				\arcanaForFileTag,arcanaForItemTag,arcanaIncludeContentTag,arcanaIncludeFileTag,
				\arcanaSetItemTag,arcanaUnsetItemTag
			\ nextgroup=arcanaChain,arcanaBlock
			\ contained
			\ fold
hi def link arcanaBlock Text

syn match arcanaIllegalInChain /[^{\-]\|\(\(\\\)\@<!}\)\@<!-/ contained
hi def link arcanaIllegalInChain SpellBad

syn region arcanaChain start=/-/ end=/{/me=s-1
			\ contained
			\ contains=arcanaIllegalInChain
			\ nextgroup=arcanaBlock
hi def link arcanaChain Macro

syn region arcanaIgnoreTag start='\(\\\)\@<!\!{' end='\(\\\)\@<!}\!'
hi def link arcanaIgnoreTag Constant

syn region arcanaSiphonTag start='\(\\\)\@<!<{' end='\(\\\)\@<!}'
			\ contains=arcanaAlias,arcanaIllegalRootAlias,arcanaIllegalPath
			\ contained
hi def link arcanaSiphonTag Macro

syn region arcanaExtendTag start='\(\\\)\@<!+{' end='\(\\\)\@<!}'
			\ contains=arcanaPath,arcanaAlias,arcanaIllegalRootAlias
hi def link arcanaExtendTag Macro

syn region arcanaCommentTag start='\(\\\)\@<!#{' end='\(\\\)\@<!}#'
hi def link arcanaCommentTag Comment

syn region arcanaIncludeFileTag start='\(\\\)\@<!&{' end='\(\\\)\@<!}'
			\ contains=arcanaPath,arcanaAlias,arcanaIllegalRootAlias,arcanaSealedMod,arcanaMdMod,arcanaRawMod
			\ nextgroup=arcanaBlock,arcanaChain
hi def link arcanaIncludeFileTag Macro

syn region arcanaIncludeContentTag start='\(\\\)\@<!\${' end='\(\\\)\@<!}'
			\ contains=arcanaAlias,arcanaIllegalRootAlias,arcanaUpperMod,arcanaReplaceMod,arcanaReplaceString,arcanaLowerMod,
			\arcanaPathMod,arcanaTrimMod,arcanaNullableOperator,arcanaSplitMod,arcanaSplitNum,arcanaFilenameMod
hi def link arcanaIncludeContentTag Macro

syn region arcanaSourceTag start='\(\\\)\@<!\.{' end='\(\\\)\@<!}'
			\ contains=arcanaPath,arcanaAlias,arcanaIllegalRootAlias,arcanaAsMod
hi def link arcanaSourceTag Macro

syn region arcanaIfTag start='\(\\\)\@<!%{' end='\(\\\)\@<!}'
			\ contains=arcanaNotCondition,arcanaExistsKeyword,arcanaEmptyKeyword,arcanaAlias,arcanaIllegalRootAlias,arcanaIllegalPath
			\ nextgroup=arcanaBlock,arcanaChain
hi def link arcanaIfTag Macro

syn region arcanaForItemTag start='\(\\\)\@<!@{' end='\(\\\)\@<!}'
			\ contains=arcanaAlias,arcanaIllegalRootAlias,arcanaInKeyword,arcanaPathsMod,arcanaReverseMod,arcanaNullableOperator,arcanaIllegalPath
			\ nextgroup=arcanaBlock,arcanaChain
hi def link arcanaForItemTag Macro

syn region arcanaForFileTag start='\(\\\)\@<!\*{' end='\(\\\)\@<!}'
			\ contains=arcanaAlias,arcanaIllegalRootAlias,arcanaInKeyword,arcanaPath,arcanaReverseMod,arcanaExtensionMod
			\ nextgroup=arcanaBlock,arcanaChain
hi def link arcanaForFileTag Macro

syn region arcanaSetItemTag start='\(\\\)\@<!={' end='\(\\\)\@<!}'
			\ contains=arcanaAlias,arcanaRootAlias,arcanaPathMod,arcanaArrayMod,arcanaIllegalPath
			\ nextgroup=arcanaBlock,arcanaChain,arcanaSiphonTag
hi def link arcanaSetItemTag Macro

syn region arcanaUnsetItemTag start='\(\\\)\@<!/{' end='\(\\\)\@<!}'
			\ contains=arcanaAlias,arcanaIllegalRootAlias,arcanaPopMod,arcanaIllegalPath
hi def link arcanaUnsetItemTag Macro
