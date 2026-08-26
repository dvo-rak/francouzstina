# CLAUDE.md — kontext pro budoucí session

Tenhle soubor čti jako první. Je psaný pro Claude (jakýkoli model), který bude
tohle repo udržovat v nové konverzaci bez historie.

## Co to je

Webová appka na procvičování francouzštiny pro jednu konkrétní uživatelku
(úrovně A1–B2, používá hlavně mobil). Běží na GitHub
Pages: https://dvo-rak.github.io/francouzstina/ — statická, bez buildu, bez
backendu, vše v localStorage. UI česky, obsah francouzsky.

## Workflow (důležité!)

1. **Vždy si naklonuj aktuální repo** — nevěř tomu, co máš v kontextu/paměti:
   ```
   git clone https://x-access-token:<TOKEN>@github.com/dvo-rak/francouzstina.git
   ```
   Token pošle uživatel ve zprávě (fine-grained, jen toto repo, Contents RW).
   Pokud ho nedal, řekni si o něj. Nikam si ho neukládej.
2. Udělej změny, **otestuj** (viz Validace níže).
3. **Nasazuj výhradně přes `./deploy.sh "message"`** — razítkuje verzi
   (pořadové číslo commitu + datum) do `APP_VERSION` v index.html, commitne
   a pushne. Nikdy ne holé `git push`, verze by se rozjela s realitou.
4. Git identita: `git config user.name "Claude" && git config user.email "noreply@anthropic.com"`.

Uživatel je senior sysadmin — komunikuj česky, technicky, stručně, bez
vaty. Chyby přiznej rovnou. Cílové uživatelce appky se říká „QA".

## Struktura

- `index.html` — celá appka: CSS + vanilla JS (žádný framework). Obrazovky:
  menu / quiz / done / stats / help. Render = skládání HTML stringů,
  jeden delegovaný click handler přes `data-action` atributy.
- `data.js` — VŠECHNA data, načítá se `<script src>` před appkou:
  - Úrovně: appka má globální přepínač A1/A2/B1/B2 (`state.level`), který
    filtruje obsah přes `lvlOk()`. Datové položky mají volitelné `lvl`;
    default: slovesa B1, podst. jména A2, texty B1. Časy mají úroveň
    v `TENSES` (présent+futur proche A1, PC+imparfait A2, FS+cond B1,
    subjonctif B2); změna úrovně přednastaví `tenseIds`. Režim `mix`
    losuje podrežimy z `mixModes()` (věty `sent` až od A2).
  - `VERBS` — slovesa: `{inf, lvl?, cz, present[6], pp, aux: "avoir"|"etre", grp?: "reg"}`
    (bez `grp` = nepravidelné; bez `lvl` = B1). Présent bez zájmen, pořadí je/tu/il/nous/vous/ils.
  - `FUT_STEMS` — nepravidelné kmeny futur simple/conditionnel (jinak se
    odvozuje z infinitivu; -re slovesa bez koncového e).
  - `SUBJ_FORMS` — úplně nepravidelný subjonctif (être, avoir, faire, pouvoir,
    savoir, aller, vouloir); ostatní se odvozuje z ils-tvaru a nous-tvaru.
  - `NOUNS` — rody: `{n, lvl?, g: "m"|"f", cz}` (bez `lvl` = A2). Vybírej zrádná slova.
  - `GRAMMAR` — doplňování: `{lvl, topic (česky), s (věta s ___), o[], c, why?}`;
    `c` musí být přesný řetězec z `o`. Obecný engine pro libovolná gramatická
    témata — nová témata = jen data.
  - `DICT` — diktáty: `{lvl, s}` (celá věta pro TTS; vyhodnocení po slovech,
    tolerantní k interpunkci/velikosti/apostrofům psaným mezerou; akcenty
    jen varují).
  - `VOCAB` — tematická slovíčka: `{fr, cz, lvl, th (téma česky)}`; `fr` unikátní
    napříč VOCAB (statId je `v|fr`, sdílený se slovesy). Distraktory se berou
    přednostně ze stejného tématu.
  - Režim `aux` (Être/Avoir) nemá vlastní data — čte `aux` z `VERBS`;
    statId `a|<inf>`, poznámky k domu être jsou v `HOUSE_NOTE` v index.html.
    Výběr je vyvážený 50/50, protože sloves s être je jen ~18.
  - `SWISS` — helvétismes: `{ch, fr, cz, cat, note?}`; režim `swiss`, statId
    `sw|i`, bez úrovní (rozdíly jsou praktické, ne úrovňové). POZOR na fakta:
    septante/nonante platí v celé Romandii včetně Ženevy, ale huitante jen
    Vaud/Valais/Fribourg — v Ženevě je pro 80 quatre-vingts. Jídla jsou
    posunutá: CH déjeuner=snídaně, dîner=oběd, souper=večeře.
    Distraktory se dedupují podle zobrazené hodnoty (různé položky mají
    někdy stejný překlad — cornet i poche = „le sac“).
  - `SENTENCES` — věty PC×imparfait: `{s (s ___), inf, p (0–5), t: "imp"|"pc", why}`.
    POZOR: obě varianty (imp i pc tvar) musí gramaticky pasovat do mezery —
    žádné „je ___", kde by tvar začínal samohláskou (elize j').
  - `TEXTS` — DELF čtení: `{title, level: "B1"|"B2", text, qs: [{q, o[], c, why?}]}`.
    `c` musí být PŘESNÝ řetězec z `o`. Vrai/Faux vždy v pořadí ["Vrai","Faux"]
    (appka je nemíchá). Otázky francouzsky, `why` česky u chytáků.
- `deploy.sh` — nasazení s verzováním (viz Workflow).
- `README.md` — jen úvod + sekce pro správce. Uživatelská nápověda žije
  VÝHRADNĚ v appce (`renderHelp()` v index.html) — README ji záměrně
  neduplikuje, aby nebylo co zapomenout synchronizovat.

## Čísla (index.html)

`frNumber()` = francouzská forma, `chNumber()` = romandská
(septante/huitante/nonante, jinak deleguje na frNumber). Přepínač
`state.numStyle` ("fr"|"ch") vybírá přes `numWord()`; při psaní
`numAccepted()` uznává obě formy (kvůli ženevskému quatre-vingts).

## SRS, fronty a streak (index.html)

- `recStat` vede Leitner SRS: každá položka `{o, b, box 1–5, due}`;
  intervaly `BOX_DAYS = [_,1,3,7,14,30]` dní. Správně → box+1, chyba → box 1.
- Režimy `due` (📅 K zopakování) a `errs` (🔁 Moje chyby) jedou z fronty
  `state.queue` statId; otázky staví `questionFromStatId()` — pozor, musí
  umět všechny prefixy (c|, v|, n|, g|, s|, gr|, d|); `t|` (čtení) se do
  front nefiltruje. Nerozložitelná id (smazaná data) se tiše přeskakují.
- Denní počítadlo v `fr-cahier-days` (klíč YYYY-MM-DD, prořezává se >120 dní);
  streak = po sobě jdoucí dny se splněným `goal` (dnešek se počítá až po
  splnění).
- Vyřazování z rotace: `fr-cahier-hidden` = pole statId (`t|i`, `s|i`, `gr|i`,
  `d|i`). Filtruje se přes `idxPool()` v režimech sent/gram/dict/čtení
  i ve frontách due/errs; když by po filtru nic nezbylo, vyřazení se ignoruje
  (fallback). DŮSLEDEK: pole SENTENCES/GRAMMAR/DICT/TEXTS jsou APPEND-ONLY —
  nikdy nemazat ani nepřeskupovat položky, indexy jsou uložené v uživatelských
  datech (hidden + statistiky).
- Záloha/obnova (Statistiky): JSON s `{app:"francouzstina", history, stats,
  days, hidden, settings}`.
- Stavitelé otázek (`buildConj`, `buildVocab`, `buildGram`, `buildDict`…)
  jsou sdílení mezi režimy, mixem i frontami — novou funkcionalitu věš na ně,
  ne na kopie logiky.

## Odvozování tvarů (index.html)

Imparfait, futur simple, conditionnel a subjonctif se počítají programově
(`conjBare`), včetně pravopisu (mangions, commençais — `iAdjust`) a elize
(`joinPronoun`: je+samohláska → j'). U nového slovesa stačí vyplnit pole jako
u ostatních; jen ověř `aux` (venir/devenir/revenir/mourir/naître/sortir/
partir/aller + arriver/rester/tomber/entrer/monter/rentrer/descendre/
apparaître = être; tenir/paraître/disparaître = avoir!) a případný kmen
do `FUT_STEMS`.

## Validace (spouštěj po každé změně dat/logiky)

```bash
# syntax obou souborů (inline skript vytáhni sedem)
node --check data.js
sed -n '/^<script>$/,/^<\/script>$/p' index.html | sed '1d;$d' > /tmp/app.js && node --check /tmp/app.js

# konzistence dat (duplicitní infinitivy/tituly, c ∈ o, present má 6 tvarů…)
# a jednotkové testy časování — viz git log, testy se psaly ad hoc v node -e;
# minimálně ověř: j'étais, nous mangions, je commençais, nous voyions,
# j'irai, je deviendrai, que j'aie, qu'il aille, que nous buvions,
# soixante et onze, quatre-vingts, quatre-vingt-dix-neuf
```

Merge do polí v data.js: pozor na `},` + `,` → `,,` = undefined prvek v poli
(už se to jednou stalo).

## Známé záludnosti

- **Náhled v chatu**: index.html v náhledu Claude neumí načíst relativní
  data.js → „VERBS is not defined". Pro testování v chatu slep jednosouborovou
  verzi (nahraď `<script src="data.js"></script>` inline obsahem). Do repa
  slepenec NEpatří.
- **TTS**: `u.lang` nestačí, musí se explicitně vybrat fr hlas z `getVoices()`
  (jinak čte anglicky). Řeší `pickFrVoice()` + diagnostika v menu (ukazuje
  použitý hlas). Chybějící fr hlas v OS kód nevyřeší — návod v Nápovědě
  (iOS/Android/Windows).
- **Cache**: ikona na ploše drží starou verzi; proto je v menu vidět verze
  (vN + datum). Při „nefunguje to" nejdřív ověř verzi.
- **iOS**: zvuk až po interakci uživatele (proto tlačítko 🔊, ne autoplay);
  getVoices() se někdy naplní až po prvním přehrání.
- Čeština v datech: uvozovky „…“ (U+201E/U+201C), nikdy ASCII " uvnitř
  JS stringů.
- Generátory distraktorů s `while (set.size < N)` musí mít pojistku proti
  vyčerpání kandidátů (číslo 0 mělo jen 2 → zamrzlý tab; opraveno guardem
  + náhodným doplněním).

## Čeho se držet

- Žádný build, žádné dependencies, žádný backend — to je záměr, ne dluh.
  Data zůstávají v data.js, soukromá data v localStorage.
- Málo formátování, mobilní ergonomie (velká tlačítka, klikání > psaní
  defaultně), vizuál „francouzský sešit" (Seyès linky, Caveat na razítka).
- Nové věci dělej konfigurovatelné (chip v nastavení) a napoj na statistiky
  (`statId`) — chytré opakování z nich čerpá.
- Historii konverzací nemáš; pravda je v repu. Když si nejsi jistý, proč něco
  je, jak je, koukni do `git log` — commit messages jsou popisné.
