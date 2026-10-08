# Mon cahier de français 🇫🇷

Aplikace na procvičování francouzštiny, úrovně A1–B2. Běží přímo v prohlížeči:

**https://dvo-rak.github.io/francouzstina/**

Na telefonu si ji přidej na plochu (Safari: sdílet → *Přidat na plochu*, Chrome: ⋮ → *Přidat na plochu*) a chová se pak jako normální appka.

Pokrývá úrovně **A1–B2** — přepínač úrovně řídí obsah celé appky. Režimy: 🎲 Mix, 📅 plánované opakování (Leitner: krabičky 1–5, intervaly 1/3/7/14/30 dní), 🔁 moje chyby, časování (7 časů), gramatická doplňování s výběrem témat (členy, stažené členy au/aux/du/des, zájmena, subjonctif…), passé composé être × avoir (dům slovesa être vs. ostatní), passé composé × imparfait, slovíčka (slovesa i tematická zásoba s výběrem témat — jídlo, počasí, čas…), diktáty s vyhodnocením po slovech, 🎤 výslovnost (věty se zrádnými dvojicemi i delší úryvky textů s čísly; čteš nahlas, telefon tě přepíše a appka obarví slova; plus vlastní nahrávka k porovnání se vzorem), porozumění textu ve stylu DELF (96 textů napříč A1–B2), čísla s volitelnými tématy (0–100, velká čísla, ceny v €/CHF, data, roky, telefonní čísla, 🕐 hodiny — i poslechově, francouzský i švýcarský styl nebo obojí), rody un/une, 🇨🇭 švýcarská francouzština (helvétismes). K tomu denní cíl a série 🔥, volitelné psaní odpovědí, francouzské předčítání, možnost vyřadit ohrané položky z rotace, statistiky chyb a záloha/obnova pokroku.

📖 **Kompletní popis všech režimů a nastavení je přímo v aplikaci** — ikona **ℹ️** vpravo nahoře v menu. Tam je jediná udržovaná verze nápovědy (README ji záměrně neduplikuje).

Soukromí: všechna data (historie, statistiky, nastavení) zůstávají jen v prohlížeči (localStorage) — žádný účet, žádný server. Výjimka: rozpoznávání řeči ve Výslovnosti zpracovává výrobce prohlížeče (Apple/Google); dá se vypnout. Data jsou tím pádem vázaná na konkrétní zařízení a prohlížeč.

## Pro správce

- `index.html` — celá aplikace (vanilla JS, žádný build); obsahuje i text nápovědy (`renderHelp()`)
- `data.js` — veškerá data: slovesa (`VERBS`), nepravidelné kmeny futuru (`FUT_STEMS`), nepravidelný subjonctif (`SUBJ_FORMS`), podstatná jména (`NOUNS`), gramatická doplňování (`GRAMMAR`), tematická slovíčka (`VOCAB`), diktáty (`DICT`), PC être×avoir (`PCAUX`), helvétismes (`SWISS`), věty PC×imparfait (`SENTENCES`), věty na výslovnost (`PRON`), texty na čtení (`TEXTS`) — formáty jsou popsané v komentářích přímo v souboru
- `deploy.sh` — nasazení: `./deploy.sh "popis změny"` razítkuje verzi (číslo commitu + datum) do appky, commitne a pushne; nepushovat ručně, verze by se rozjela
- `CLAUDE.md` — kompletní kontext pro údržbu (workflow, formáty dat, validace, známé záludnosti); čti jako první při jakékoli změně
