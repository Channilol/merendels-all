# Merendels - Sistema Gestione Ferie, Permessi e Timbrature

Sistema completo per la digitalizzazione della gestione delle richieste di ferie, permessi e timbrature aziendali.

## Architettura del Sistema

Il progetto è completamente containerizzato con Docker e include:

- **Backend**: API REST in Go (Gin framework) con autenticazione JWT
- **Frontend**: Applicazione React per la gestione via web
- **Database**: PostgreSQL con schema e dati precaricati
- **Containerizzazione**: Docker Compose per orchestrazione completa

## Funzionalità Principali

### Timbrature (Core Feature)

- Registrazione entrata/uscita con timestamp
- Supporto modalità ufficio/smart working
- Storico completo per utente
- Validazione sequenza logica (entrata → uscita)

### Gestione Ferie e Permessi

- Richieste con range date personalizzabile
- Sistema di approvazioni gerarchiche
- Calcolo automatico saldi residui
- Calendario condiviso per pianificazione team

### Sicurezza e Ruoli

- Autenticazione JWT con refresh token
- Gestione ruoli gerarchici (Capo → Responsabile → Dipendente)
- Protezione endpoint basata su livelli autorizzazione
- Rate limiting e validazione server-side

## Avvio Rapido

### Prerequisiti

- Docker
- Docker Compose

### Installazione

```bash
# Clona il repository
git clone https://github.com/Channilol/merendels-all.git
cd merendels-all

# Avvia tutto il sistema
docker-compose up --build
```

### Accesso ai Servizi

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080
- **Database**: localhost:5432

### Test Immediato

Il sistema include utenti e dati preconfigurati per test immediati:

**Utente Admin/Capo:**

- Email: `giacomo.festuccia@merendels.it`
- Password: `123456`

**Utente Dipendente:**

- Email: `test@example.com`
- Password: `123456`

## Struttura Progetto

```
merendels/
├── merendels-backend/     # API Go con Gin
│   ├── models/           # Strutture dati
│   ├── handlers/         # Controller HTTP
│   ├── services/         # Business logic
│   ├── repositories/     # Data access layer
│   └── middleware/       # JWT auth & CORS
├── merendels-frontend/    # React SPA
│   ├── src/components/   # Componenti riutilizzabili
│   ├── src/views/        # Pagine applicazione
│   └── src/redux/        # State management
├── db/                   # Schema e dati PostgreSQL
└── docker-compose.yml    # Orchestrazione servizi
```

## API Documentation

Per testare il backend e tutte le funzionalità disponibili, consulta la documentazione completa:

**[📖 Guida Test API Backend](https://github.com/Channilol/merendels-all/blob/main/docs/Merendels%20Backend%20-%20Guida%20Test%20API.pdf)**

La documentazione include:

- Endpoint completi con esempi curl
- Sequenze di test guidate
- Gestione autenticazione JWT
- Esempi di payload per ogni operazione
- Troubleshooting errori comuni

## Tecnologie Utilizzate

### Backend

- **Go 1.21** con Gin framework
- **PostgreSQL 15** database relazionale
- **JWT** per autenticazione
- **bcrypt** per hashing password
- **CORS** configurato per ambiente sviluppo

### Frontend

- **React 18** con hooks moderni
- **React Router** per navigazione
- **Redux Toolkit** per state management
- **CSS moderno** con variabili custom

### DevOps

- **Docker** multi-stage builds
- **Docker Compose** per orchestrazione
- **Nginx** per serving produzione frontend
- **Volumi persistenti** per database

## Comandi Utili

```bash
# Avvio completo
docker-compose up --build

# Solo backend + database (per sviluppo frontend locale)
docker-compose up database backend

# Rebuild singolo servizio
docker-compose build backend
docker-compose build frontend

# Logs specifici
docker-compose logs backend
docker-compose logs frontend

# Reset completo con cancellazione dati
docker-compose down -v
docker-compose up --build
```

## Database

Il sistema utilizza PostgreSQL con schema ottimizzato per:

- Integrità referenziale completa
- Timestamp UTC per consistency
- Enum types per validazione dati
- Indici ottimizzati per query frequenti

Schema principale:

- `users` - Anagrafica utenti
- `user_roles` - Ruoli e livelli gerarchici
- `timbrature` - Registrazioni entrata/uscita
- `requests` - Richieste ferie/permessi
- `approvals` - Approvazioni richieste
- `auth_credentials` - Credenziali e sicurezza

## Sviluppo

### Setup Locale per Sviluppo

```bash
# Backend (richiede Go 1.21+)
cd merendels-backend
go mod tidy
go run main.go

# Frontend (richiede Node.js 16+)
cd merendels-frontend
npm install
npm start

# Database (richiede PostgreSQL)
psql -U postgres -d merendels_db < db/backup.sql
```

### Environment Variables

Il sistema supporta configurazione tramite variabili ambiente:

- `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`
- `REACT_APP_BACKEND_URL` per il frontend

## Supporto

Per domande tecniche o problemi di installazione, consulta:

- Log dei container: `docker-compose logs [servizio]`
- Documentazione API per test endpoint
- Schema database per comprensione dati

---

**Versione**: 1.0  
**Ultima modifica**: Settembre 2025
