# Experimental!
~Parse {rest tokens ← {}}

# TODO:
# - Whitespace parser
# - Word parser

SaveTokens    ← ⍜Parse~tokens(⋅{})⟜Parse~tokens # saves tokens and initializes a new empty token array
CollectTokens ← ⍜Parse~tokens(⍣(⊂/⍚⊂|∘))        # collects token array and prepends it to saved tokens

Char       ← ⍜Parse~rest(↘1) ⍜Parse~tokens (⊂⊙(□¤)) : ⍤$"Expected: _. Got: _."◠= ⊙(.⊢Parse~rest.)
Sequence!  ← CollectTokens∧(^0) ⊙SaveTokens
ManyInner! ← |1 ⍣(ManyInner!(^0)^0)()
Many!      ← CollectTokens ManyInner!^0 SaveTokens
Lookahead! ← ◌^0.
Ignore!    ← CollectTokens ⍜Parse~tokens({}◌)^0SaveTokens
Map‼       ← ⍜Parse~tokens(⊂^0) ^1 SaveTokens
Either‼    ← ⍣(^0|⍣(^1◌:|0⍤:0$"_ | _"◌))

StringA ← Parse "aab"
StringB ← Parse "aaabc"

# Char @a StringA
# Char @b Char @a Char @a StringA
# Sequence!Char "aaa" StringB
# ⍣(Char @c|) Char @b Many!(Char @a) StringA
# ⍣(Char @c|) Char @b Many!(Char @a) StringB
# Map‼⋕(Sequence!Char "21") Parse "21"
# Many!(Map‼⋕(Char @2)) Parse "2222"
# Either‼(Either‼(Char @a|Char @b)|Char @d) Parse"c"
# Lookahead‼(Char @a|Char @a) StringA
# Lookahead‼(Char @a|Char @b) StringA
# Ignore!(Char @a) StringA
