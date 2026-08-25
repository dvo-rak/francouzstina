# Mon cahier de français 🇫🇷

Aplikace na procvičování francouzštiny (příprava na DELF B1/B2). Běží přímo v prohlížeči: https://dvo-rak.github.io/francouzstina/

Na telefonu si ji můžeš přidat na plochu (Safari: sdílet → *Přidat na plochu*, Chrome: ⋮ → *Přidat na plochu*) a chová se pak jako normální appka.

## Režimy

**Časování** — zobrazí se sloveso, osoba a čas, ty vybereš (nebo napíšeš) správný tvar. Které časy se procvičují, si zvolíš v nastavení.

**Passé composé × imparfait** — věta s mezerou, vybíráš mezi dvěma tvary. Po odpovědi se ukáže vysvětlení, proč je správně zrovna tenhle čas (signální slova jako *tous les étés*, *soudain*, *d'habitude*…).

**Slovíčka** — překlad sloves oběma směry (FR → ČJ, ČJ → FR).

**Porozumění textu (DELF)** — přečteš krátký text (e-mail, inzerát, oznámení, článek) a odpovíš na 5 otázek ve francouzštině, přesně jako u zkoušky. Text zůstává během otázek viditelný nahoře. V nastavení jde filtrovat úroveň B1 / B2.

**Čísla 0–100** — zobrazí se číslo, vybereš/napíšeš ho francouzsky. Se zapnutým zvukem je půlka otázek poslechová: uslyšíš číslo francouzsky a píšeš číslice (ano, i *quatre-vingt-dix-neuf* 🙂).

**Rody: un / une** — u podstatného jména tipuješ rod. Vybraná jsou hlavně zrádná slova (*le problème, le musée, l'eau — f!, la plage, le bonheur…*).

## Nastavení (řádek „chipů" nahoře v menu)

**Slovesa: Všechna / Nepravidelná / Pravidelná** — omezí, ze kterých sloves se losuje (platí pro časování i slovíčka).

**Časy** — zapni/vypni jednotlivé časy pro režim časování. Défaut jsou présent, passé composé a futur proche; imparfait, futur simple, conditionnel a subjonctif si přidáš, až na ně dojde v kurzu.

**Počet otázek: 10 / 25 / 50 / ∞** — délka jednoho kola. U ∞ cvičíš, dokud nedáš „← ukončit". (U čtení se tohle nepoužívá — jedno kolo = jeden text s 5 otázkami.)

**✍ psaní odpovědí** — místo výběru ze 4 možností píšeš odpověď do políčka. Je to těžší, ale mnohem blíž tomu, co chce zkouška. Kontrola je tolerantní: chybějící čárky a háčky (*etais* místo *étais*) se počítají jako správně, jen s upozorněním „pozor na akcenty"; u čísel je jedno, jestli píšeš pomlčky nebo mezery.

**🧠 chytré opakování** — appka si (jen v tomhle prohlížeči) počítá, kde děláš chyby, a tyhle věci ti pak **nabízí častěji**. Konkrétně: při výběru další otázky se vylosuje několik kandidátů a přednost dostane ten s horší úspěšností. Nic víc v tom není — žádné plánování na dny dopředu jako Anki, prostě „co ti nejde, chodí častěji". Když to vypneš, losuje se čistě náhodně.

**🔊 zvuk** — francouzské předčítání vestavěným hlasem prohlížeče: slovíčka, čísla (včetně poslechových otázek), po odpovědi celé věty a *un/une + slovo*, u textů tlačítko „přečíst". Pokud slyšíš angličtinu, chybí v zařízení francouzský hlas — na iPhonu: Nastavení → Zpřístupnění → Předčítání obsahu → Hlasy → Francouzština; na Androidu: nastavení Google TTS.

## 📊 Statistiky chyb

Obrazovka „Statistiky chyb" ukazuje, co ti jde nejhůř: nejtěžší slovesa, rozpad podle časů, slovíčka, čísla po desítkách, rody, věty a texty. Přesně z těchhle dat čerpá chytré opakování.

U každé položky je tlačítko **„✓ umím"**: vynuluje počítadlo té konkrétní věci — zmizí ze seznamu a přestane se ti podsouvat častěji. Není to ale napořád: když v ní zase uděláš chybu, objeví se tu znovu. Takže klidně mačkej, nic si tím nerozbiješ.

## Soukromí a data

Všechno (historie výsledků, statistiky, nastavení) se ukládá **jen v prohlížeči** (localStorage) — nikam se nic neposílá, žádný účet, žádný server. Z toho plyne i druhá strana mince: data jsou vázaná na konkrétní zařízení a prohlížeč. Telefon a notebook mají každý svoje statistiky a smazání dat prohlížeče je smaže taky.

## Pro správce 🙂

- `index.html` — celá aplikace (vanilla JS, žádný build)
- `data.js` — veškerá data: slovesa (`VERBS`), nepravidelné kmeny futuru (`FUT_STEMS`), nepravidelný subjonctif (`SUBJ_FORMS`), podstatná jména (`NOUNS`), věty PC×imparfait (`SENTENCES`), texty na čtení (`TEXTS`)

Přidání obsahu = úprava `data.js` + push; Pages se přegenerují samy. Formáty dat jsou popsané v komentářích přímo v souboru. Nové tvary sloves (imparfait, subjonctif…) se odvozují programově z présentu, takže u nového slovesa stačí vyplnit stejná pole jako u ostatních.
