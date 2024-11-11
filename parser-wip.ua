# Experimental!

┌─╴Parse ~ Any Char Either‼ Ignore! Many! Map‼ Sequence! Until‼
  ~{rest tokens ← {}}
  SaveTokens    ← ⍜tokens(⋅{}) ⟜tokens # saves tokens and initializes a new empty token array
  CollectTokens ← ⍜tokens(⍣(⊂/⍚⊂|∘))   # collects token array and prepends it to saved tokens

  Any         ← ⍜rest(↘1) ⍜tokens(⊂⊙(□¤)): ⊢rest.
  Char        ← ⍜rest(↘1) ⍜tokens(⊂⊙(□¤)): ⍤$"Expected: _. Got: _."◠= ⊙(.⊢rest.)
  Sequence!   ← CollectTokens ∧(^0) ⊙SaveTokens
  ManyInner!  ← |1 ⍣(ManyInner!(^0)^0|)
  Many!       ← CollectTokens ManyInner!^0 SaveTokens
  Ignore!     ← CollectTokens ⍜tokens({}◌)^0 SaveTokens
  Map‼       ← ⍜tokens(⊂^0)^1 SaveTokens
  Either‼     ← ⍣(^0|⍣(^1◌:|0⍤:0$"_ | _"◌))
  UntilInner‼ ← |1 ⍣(◌^0.|UntilInner‼(^0|^1)^1)
  Until‼      ← CollectTokens UntilInner‼(^0|^1) SaveTokens
└─╴

StringA ← Parse "aab"
StringB ← Parse "aaabc"

Any StringA
Char @a StringA
Char @b Char @a Char @a StringA
Sequence!Char "aaa" StringB
⍣(Char @c|) Char @b Many!(Char @a) StringA
⍣(Char @c|) Char @b Many!(Char @a) StringB
Map‼⋕(Sequence!Char "21") Parse "21"
# Many!(Map‼⋕(Char@2))Parse"2222" # bug in the interpreter
Either‼(Either‼(Char @a|Char @b)|Char @c) Parse "c"
Ignore!(Char @a) StringA
Until‼(Char @b|Char @a)StringA
Until‼(Char @b|Char @a)StringB
