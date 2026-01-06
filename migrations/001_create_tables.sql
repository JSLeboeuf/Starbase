-- Migration: create_jerome_tables
-- Projet: JEROME - Conflit Actionnaires
-- Date: 21 decembre 2025
-- Supabase Project: yixgiabpoeoixxqdgyrs

-- ============================================
-- 1. EMAILS COMME PREUVES
-- ============================================
CREATE TABLE IF NOT EXISTS emails_preuves (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date_email TIMESTAMPTZ,
  expediteur TEXT NOT NULL,
  destinataire TEXT,
  cc TEXT,
  sujet TEXT,
  contenu TEXT,
  message_id TEXT UNIQUE,
  thread_id TEXT,
  categorie TEXT CHECK (categorie IN (
    'contradiction', 
    'manipulation', 
    'preuve_positive', 
    'communication_normale', 
    'collusion', 
    'menace',
    'promesse',
    'aveu'
  )),
  importance INTEGER DEFAULT 5 CHECK (importance >= 1 AND importance <= 10),
  notes TEXT,
  pieces_jointes JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE emails_preuves IS 'Emails extraits comme preuves pour le dossier juridique';

-- ============================================
-- 2. TIMELINE DES EVENEMENTS
-- ============================================
CREATE TABLE IF NOT EXISTS timeline_evenements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date_evenement DATE NOT NULL,
  titre TEXT NOT NULL,
  description TEXT,
  acteurs TEXT[],
  type_evenement TEXT CHECK (type_evenement IN (
    'reunion', 
    'email', 
    'decision', 
    'demande', 
    'conflit', 
    'document', 
    'transaction',
    'autre'
  )),
  impact TEXT CHECK (impact IN ('positif', 'negatif', 'neutre', 'critique')),
  preuves_liees UUID[],
  source TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE timeline_evenements IS 'Chronologie des evenements du conflit';

-- ============================================
-- 3. ARGUMENTS JURIDIQUES
-- ============================================
CREATE TABLE IF NOT EXISTS arguments_juridiques (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titre TEXT NOT NULL,
  argument TEXT NOT NULL,
  base_legale TEXT, -- Ex: Art. 450 LSAQ
  type_argument TEXT CHECK (type_argument IN (
    'defense', 
    'attaque', 
    'contre_argument', 
    'precedent',
    'factuel'
  )),
  force INTEGER DEFAULT 5 CHECK (force >= 1 AND force <= 10),
  preuves_emails UUID[],
  jurisprudence TEXT,
  notes TEXT,
  statut TEXT DEFAULT 'draft' CHECK (statut IN ('draft', 'valide', 'utilise', 'rejete')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE arguments_juridiques IS 'Arguments juridiques avec base legale et preuves';

-- ============================================
-- 4. CONTRADICTIONS DE JEROME
-- ============================================
CREATE TABLE IF NOT EXISTS contradictions_jerome (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date_affirmation_1 DATE,
  affirmation_1 TEXT NOT NULL,
  source_1 TEXT,
  contexte_1 TEXT,
  date_affirmation_2 DATE,
  affirmation_2 TEXT NOT NULL,
  source_2 TEXT,
  contexte_2 TEXT,
  analyse TEXT,
  type_contradiction TEXT CHECK (type_contradiction IN (
    'factuelle',
    'temporelle', 
    'intentionnelle',
    'financiere',
    'comportementale'
  )),
  gravite INTEGER DEFAULT 5 CHECK (gravite >= 1 AND gravite <= 10),
  emails_lies UUID[],
  created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE contradictions_jerome IS 'Contradictions documentees de Jerome Levac';

-- ============================================
-- 5. ACTEURS DU CONFLIT
-- ============================================
CREATE TABLE IF NOT EXISTS acteurs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom TEXT NOT NULL,
  prenom TEXT,
  emails TEXT[],
  telephone TEXT,
  role TEXT,
  entreprise TEXT,
  parts_pourcent DECIMAL(5,2),
  salaire_annuel INTEGER,
  camp TEXT CHECK (camp IN ('allie', 'adversaire', 'neutre', 'incertain')),
  relation_avec_jerome TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE acteurs IS 'Personnes impliquees dans le conflit';

-- ============================================
-- 6. DOCUMENTS/PIECES JOINTES
-- ============================================
CREATE TABLE IF NOT EXISTS documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom_fichier TEXT NOT NULL,
  type_document TEXT CHECK (type_document IN (
    'contrat',
    'email',
    'facture',
    'rapport',
    'photo',
    'enregistrement',
    'autre'
  )),
  storage_path TEXT,
  storage_bucket TEXT DEFAULT 'jerome-project',
  email_source UUID REFERENCES emails_preuves(id),
  description TEXT,
  importance INTEGER DEFAULT 5,
  date_document DATE,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE documents IS 'Pieces jointes et documents du dossier';

-- ============================================
-- 7. RECHERCHES JURIDIQUES
-- ============================================
CREATE TABLE IF NOT EXISTS recherches_juridiques (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  titre TEXT NOT NULL,
  requete TEXT,
  source TEXT, -- perplexity, google, canlii
  resultats TEXT,
  articles_loi TEXT[],
  jurisprudence_citee TEXT[],
  pertinence INTEGER DEFAULT 5,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE recherches_juridiques IS 'Recherches juridiques effectuees';

-- ============================================
-- INDEX POUR PERFORMANCE
-- ============================================
CREATE INDEX IF NOT EXISTS idx_emails_date ON emails_preuves(date_email DESC);
CREATE INDEX IF NOT EXISTS idx_emails_expediteur ON emails_preuves(expediteur);
CREATE INDEX IF NOT EXISTS idx_emails_categorie ON emails_preuves(categorie);
CREATE INDEX IF NOT EXISTS idx_emails_importance ON emails_preuves(importance DESC);
CREATE INDEX IF NOT EXISTS idx_timeline_date ON timeline_evenements(date_evenement DESC);
CREATE INDEX IF NOT EXISTS idx_contradictions_gravite ON contradictions_jerome(gravite DESC);
CREATE INDEX IF NOT EXISTS idx_arguments_force ON arguments_juridiques(force DESC);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================
ALTER TABLE emails_preuves ENABLE ROW LEVEL SECURITY;
ALTER TABLE timeline_evenements ENABLE ROW LEVEL SECURITY;
ALTER TABLE arguments_juridiques ENABLE ROW LEVEL SECURITY;
ALTER TABLE contradictions_jerome ENABLE ROW LEVEL SECURITY;
ALTER TABLE acteurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE recherches_juridiques ENABLE ROW LEVEL SECURITY;

-- Politique: accès service_role uniquement (sécurité maximale)
CREATE POLICY "Service role only" ON emails_preuves FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role only" ON timeline_evenements FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role only" ON arguments_juridiques FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role only" ON contradictions_jerome FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role only" ON acteurs FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role only" ON documents FOR ALL USING (auth.role() = 'service_role');
CREATE POLICY "Service role only" ON recherches_juridiques FOR ALL USING (auth.role() = 'service_role');

-- ============================================
-- DONNEES INITIALES - ACTEURS
-- ============================================
INSERT INTO acteurs (nom, prenom, emails, role, entreprise, parts_pourcent, salaire_annuel, camp) VALUES
('Leboeuf', 'Jean-Samuel', ARRAY['jsleboeuf3@gmail.com'], 'Actionnaire 23%', 'Groupe Leboeuf / Veta', 23.00, 0, 'allie'),
('Levac', 'Jerome', ARRAY['jlevac@mkmg.ca', 'levacjerome@gmail.com'], 'Actionnaire 6% + Salarie', 'Groupe Leboeuf', 6.00, 80000, 'adversaire'),
('Hamel', 'Felix', ARRAY['felixhamel1991@gmail.com'], 'Actionnaire 23%', 'Groupe Leboeuf / Go Dentiste', 23.00, NULL, 'incertain'),
('Leboeuf', 'Cedric', ARRAY['cedric2177@gmail.com', 'info@cedricleboeuf.com'], 'Actionnaire 48%', 'Groupe Leboeuf', 48.00, NULL, 'neutre'),
('Marois', 'Nicolas', ARRAY['nicolas.marois@notavo.ca'], 'Avocat', 'Marois Avocat', NULL, NULL, 'neutre'),
('Rainville', 'Valerie', ARRAY['valerie@rhsupport.ca'], 'Directrice RH Support', 'RH Support', NULL, NULL, 'allie')
ON CONFLICT DO NOTHING;


