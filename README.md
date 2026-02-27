# 🛠️ Deep Windows Update Repair Tool
**Utility avanzata per la ri-registrazione delle librerie di sistema e il reset degli ID di Windows Update.**

Questo script è una soluzione intensiva per risolvere errori critici di Windows Update (come gli errori `0x800...`) che non si risolvono con la semplice pulizia della cache. È una risorsa avanzata della community di [angolodiwindows.com](https://www.angolodiwindows.com).

---

## 🚀 Cosa fa questo script?

A differenza della versione base, questo tool esegue operazioni profonde sul cuore del sistema operativo:

### 1. Re-registrazione DLL di Sistema
* Registra nuovamente oltre 20 librerie critiche (`.dll`) responsabili del corretto funzionamento di Windows Update, WMI e dei servizi crittografici.
* Risolve problemi legati a "Interfaccia non registrata" o componenti mancanti.

### 2. Reset dei Componenti Crittografici
* Deregistra e registra nuovamente i moduli `wintrust`, `initpki`, `mssip32` e altri, fondamentali per la verifica della firma digitale degli aggiornamenti.

### 3. Reset dell'Identità del Client (WSUS/WU)
* Elimina le chiavi di registro `AccountDomainSid`, `PingID` e `SusClientId`. 
* Questo forza Windows a rigenerare un nuovo identificativo univoco, risolvendo i conflitti di comunicazione con i server Microsoft.

---

## 💻 Istruzioni per l'uso

1. **Download:** Scarica il file `deep_wu_repair.bat`.
2. **Avvio:** Eseguilo con un doppio clic. Grazie all'auto-elevazione integrata, lo script richiederà i **privilegi di Amministratore** necessari.
3. **Automazione:** Lo script gira in modalità "Silent". Non dovrai cliccare "OK" su decine di popup di sistema; farà tutto da solo.
4. **Finalizzazione:** Al termine, lo script forzerà un nuovo ciclo di rilevamento aggiornamenti (`wuauclt /detectnow`).

---

## ⚠️ Quando usare questo tool?

Questo script va utilizzato se:
* La pulizia della cartella `SoftwareDistribution` non ha funzionato.
* Ricevi errori relativi a file di sistema o librerie DLL corrotte.
* Il tuo PC sembra "non vedere" nuovi aggiornamenti nonostante sia connesso a internet.

> [!WARNING]
> **Nota di sicurezza:** Questo script modifica chiavi di registro e registra componenti di sistema. Sebbene sia testato, è consigliabile creare un **Punto di Ripristino** prima dell'esecuzione.

---

## 🤝 Supporto

* **Guida Completa:** [Leggi l'articolo su Angolo di Windows]([https://www.angolodiwindows.com](https://angolodiwindows.com/2018/05/fix-risoluzione-problemi-windows-update/))
* **Discussioni:** Unisciti al nostro subreddit dedicato.
* **Segnalazioni:** Se riscontri problemi, apri una *Issue* in questo repository.

---

## 📄 Licenza
Rilasciato sotto licenza MIT. Libero per uso personale e commerciale citando la fonte.
