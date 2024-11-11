# Experimental!

┌─╴Parse ~ Any Char Either‼ Ignore! Many! Map‼ OneOf Sequence! Until‼
  ~{Rest Tokens ← {}}

  SaveTokens    ← ⍜Tokens(⋅{}) ⟜Tokens # saves tokens and initializes a new empty token array
  CollectTokens ← ⍜Tokens(⍣(⊂/⍚⊂|∘))   # collects token array and prepends it to saved tokens
  NewToken      ← ⍜Rest(↘1) ⍜Tokens(⊂⊙(□¤)):
  Next          ← ⊙(.⊢Rest.)

  Any         ← NewToken ⊢Rest.
  Char        ← NewToken ⍤$"Expected: _. Got: _."◠= Next
  OneOf       ← NewToken ⍤$"Expected one of: _. Got: _."◠∈ Next
  Sequence!   ← CollectTokens ∧(^0) ⊙SaveTokens
  ManyInner!  ← |1 ⍣(ManyInner!(^0)^0|)
  Many!       ← CollectTokens ManyInner!^0 SaveTokens
  Ignore!     ← CollectTokens ⍜Tokens({}◌)^0 SaveTokens
  Map‼        ← ⍜Tokens(⊂^0)^1 SaveTokens
  Either‼     ← ⍣(^0|⍣(^1◌:|0⍤:0$"_ | _"◌)) # TODO: write as code macro to enable arbitrary function packs
  UntilInner‼ ← |1 ⍣(◌^0.|UntilInner‼(^0|^1)^1)
  Until‼      ← CollectTokens UntilInner‼(^0|^1) SaveTokens
└─╴

StringA ← Parse "aab"
StringB ← Parse "aaabc"

Any StringA
Char @a StringA
Char @b Char @a Char @a StringA
OneOf "ab" StringA
Sequence!Char "aaa" StringB
⍣(Char @c|) Char @b Many!(Char @a) StringA
⍣(Char @c|) Char @b Many!(Char @a) StringB
Map‼⋕(Sequence!Char "21") Parse "21"
Many!(Map‼⋕(Char@2)) Parse"2222" # bug in the interpreter
Either‼(Either‼(Char @a|Char @b)|Char @c) Parse "c"
Ignore!(Char @a) StringA
Until‼(Char @b|Char @a)StringA
Until‼(Char @b|Char @a)StringB
