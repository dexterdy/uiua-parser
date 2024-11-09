# Experimental!
~Parse {rest tokens ← {}}

# TODO: 
# - Either macro
# - OneOf macro
# - Lookahead
# - Whitespace parser
# - Word parser
# - RegEx parser ??

# saves tokens and initializes a new empty token array
SaveTokens ← ⍜Parse~tokens(⋅{})⟜Parse~tokens
# collects token array and prepends it to saved tokens
CollectTokens ← ⍜Parse~tokens(⊂□/◇⊂)

Char       ← ⍜Parse~rest(↘1) ⍜Parse~tokens (⊂⊙(□¤)) : ⍤"unexpected input"= ⊙(.⊢Parse~rest.)
Sequence!  ← CollectTokens∧(^0) ⊙SaveTokens
ManyInner! ← |1 ⍣(ManyInner!(^0)^0)()
Many!      ← CollectTokens ManyInner!^0 SaveTokens
Map‼       ← ⍜Parse~tokens(⊂^0) ^1 SaveTokens

StringA ← Parse "aab"
StringB ← Parse "aaabc"

Char @a StringA
Char @b Char @a Char @a StringA
Sequence!Char "aaa" StringB
⍣(Char @c)() Char @b Many!(Char @a) StringA
⍣(Char @c)() Char @b Many!(Char @a) StringB
Map‼⋕(Sequence!Char "21") Parse "21"
Many!(Map‼⋕(Char @2)) Parse "2222"
