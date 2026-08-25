# Mon cahier de français 🇫🇷

Aplikace na procvičování francouzštiny (příprava na DELF B1/B2). Běží přímo v prohlížeči:

**https://dvo-rak.github.io/francouzstina/**

Na telefonu si ji přidej na plochu (Safari: sdílet → *Přidat na plochu*, Chrome: ⋮ → *Přidat na plochu*) a chová se pak jako normální appka.

Pokrývá úrovně **A1–B2** — přepínač úrovně řídí obsah celé appky (slovesa, časy, texty, dostupné režimy). Režimy: 🎲 Mix (všechny typy cvičení v jednom kole), časování (7 časů), passé composé × imparfait ve větách, slovíčka oběma směry, porozumění textu ve stylu DELF (A1–B2), čísla 0–100 (i poslechově), rody un/une. K tomu volitelné psaní odpovědí, chytré opakování podle chybovosti, francouzské předčítání a statistiky chyb.

📖 **Kompletní popis všech režimů a nastavení je přímo v aplikaci** — tlačítko **ℹ️ Nápověda** v menu. Tam je jediná udržovaná verze nápovědy (README ji záměrně neduplikuje).

Soukromí: všechna data (historie, statistiky, nastavení) zůstávají jen v prohlížeči (localStorage) — žádný účet, žádný server. Data jsou tím pádem vázaná na konkrétní zařízení a prohlížeč.

## Pro správce

- `index.html` — celá aplikace (vanilla JS, žádný build); obsahuje i text nápovědy (`renderHelp()`)
- `data.js` — veškerá data: slovesa (`VERBS`), nepravidelné kmeny futuru (`FUT_STEMS`), nepravidelný subjonctif (`SUBJ_FORMS`), podstatná jména (`NOUNS`), věty PC×imparfait (`SENTENCES`), texty na čtení (`TEXTS`) — formáty jsou popsané v komentářích přímo v souboru
- `deploy.sh` — nasazení: `./deploy.sh "popis změny"` razítkuje verzi (číslo commitu + datum) do appky, commitne a pushne; nepushovat ručně, verze by se rozjela
- `CLAUDE.md` — kompletní kontext pro údržbu (workflow, formáty dat, validace, známé záludnosti); čti jako první při jakékoli změně
