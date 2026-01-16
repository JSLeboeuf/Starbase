/**
 * 🎯 JEROME STRATEGIC RESEARCH
 * 
 * Script de recherche approfondie adapte a la situation avec Jerome:
 * - Oppression actionnaire minoritaire Quebec
 * - Defense contre manipulation corporative
 * - Strategies negociation avec Dark Triad
 * - Protection juridique actionnaires
 */

import fs from "node:fs/promises";
import path from "node:path";
import { config } from "dotenv";

config();

function requiredEnv(name) {
  const value = process.env[name];
  if (!value) throw new Error(`Missing env var: ${name}. Cree un fichier .env avec PERPLEXITY_API_KEY=ta_cle`);
  return value;
}

async function ensureDir(dir) {
  await fs.mkdir(dir, { recursive: true });
}

// ═══════════════════════════════════════════════════════════
// RECHERCHES STRATEGIQUES POUR JEROME
// ═══════════════════════════════════════════════════════════

const STRATEGIC_QUERIES = [
  {
    id: "oppression-actionnaire",
    name: "Oppression Actionnaire Minoritaire Quebec",
    query: `
Analyse juridique COMPLETE sur le recours en oppression (oppression remedy) au Quebec et Canada:

1. **Cadre juridique**
   - Article 241 LCSA (Loi canadienne sur les societes par actions)
   - Loi sur les societes par actions du Quebec (LSAQ)
   - Jurisprudence cle: BCE Inc. c. Detenteurs de debentures, Wilson v Alharayeri

2. **Situations qui constituent de l'oppression**
   - Exclusion des decisions importantes
   - Dilution abusive des parts
   - Remuneration excessive des majoritaires
   - Refus de dividendes malgre profits
   - Transactions a des conditions desavantageuses
   - Squeeze-out tactics

3. **Preuves requises**
   - Attentes raisonnables de l'actionnaire minoritaire
   - Conduite oppressive, prejudiciable ou inéquitable
   - Documentation necessaire

4. **Remedes possibles**
   - Ordonnance d'achat des actions
   - Nomination d'administrateurs
   - Modification des statuts
   - Dommages-interets

5. **Processus et couts**
   - Etapes de la procedure
   - Delais typiques
   - Couts approximatifs
   - Chances de succes

Fournis des references aux articles de loi et decisions judiciaires pertinentes.
    `
  },
  {
    id: "convention-actionnaires",
    name: "Convention Actionnaires Protection",
    query: `
Guide COMPLET sur les conventions d'actionnaires au Quebec pour PROTEGER un actionnaire minoritaire:

1. **Clauses essentielles de protection**
   - Droit de veto sur decisions majeures
   - Tag-along (droit de sortie conjointe)
   - Drag-along (obligation de sortie conjointe)
   - Clause shotgun (offre reciproque)
   - Pre-emption (droit de premier refus)
   - Anti-dilution

2. **Gouvernance et decisions**
   - Quorum requis
   - Majorite qualifiee pour decisions importantes
   - Droit a l'information financiere
   - Representation au conseil d'administration

3. **Evaluation des actions**
   - Methodes d'evaluation (DCF, multiples, actif net)
   - Expert independant obligatoire
   - Clause de non-competition lors de sortie

4. **Clauses de sortie**
   - Evenements declencheurs
   - Formule de prix
   - Modalites de paiement
   - Garanties

5. **Red flags a eviter**
   - Clauses leonines favorisant le majoritaire
   - Absence de mecanisme de resolution de conflits
   - Discretion excessive au majoritaire

Fournis des exemples concrets de formulations.
    `
  },
  {
    id: "dark-triad-business",
    name: "Dark Triad en Affaires - Detection et Defense",
    query: `
Analyse APPROFONDIE sur comment detecter et se defendre contre un partenaire d'affaires avec traits Dark Triad (narcissisme, machiavelisme, psychopathie):

1. **Signes d'alerte en contexte corporatif**
   - Comportements narcissiques: grandiosite, besoin d'admiration, exploitation
   - Tactiques machiaveliques: manipulation, mensonges strategiques, alliances
   - Traits psychopathiques: charme superficiel, absence de remords, impulsivite

2. **Patterns de comportement typiques**
   - Love bombing initial puis devaluation
   - Gaslighting corporatif (nier des faits documentes)
   - Triangulation (monter les gens les uns contre les autres)
   - Moving goalposts (changer les regles constamment)
   - DARVO (Deny, Attack, Reverse Victim and Offender)

3. **Strategies de defense**
   - Documentation systematique (emails, decisions, promesses)
   - Communication ecrite uniquement
   - Temoins dans toutes les reunions importantes
   - Separation financiere claire
   - Alliances strategiques avec autres actionnaires/employes

4. **Tactiques de negociation**
   - Ne jamais montrer d'emotion
   - Positions fermes et documentees
   - Deadlines non-negociables
   - Avoir une BATNA (alternative) solide
   - Utiliser des intermediaires (avocats)

5. **Exit strategies**
   - Quand couper ses pertes
   - Comment maximiser sa sortie
   - Protection post-sortie (non-concurrence, confidentialite)

Base sur des etudes en psychologie organisationnelle et cas reels.
    `
  },
  {
    id: "negociation-manipulateur",
    name: "Negociation avec Manipulateur",
    query: `
Techniques AVANCEES de negociation face a un manipulateur sophistique en contexte d'affaires:

1. **Preparation pre-negociation**
   - Recherche exhaustive sur l'adversaire
   - Identifier ses leviers et vulnerabilites
   - Preparer plusieurs scenarios
   - Definir son BATNA et walk-away point
   - Anticiper les tactiques de manipulation

2. **Techniques defensives**
   - Broken record (repeter sa position calmement)
   - Fogging (accepter la critique sans ceder)
   - Negative inquiry (demander des precisions sur les attaques)
   - Time-out strategiques
   - Ne jamais reagir a chaud

3. **Techniques offensives ethiques**
   - Ancrage avec premiere offre agressive mais justifiee
   - Silence strategique apres une demande
   - Fausse concession (ceder sur ce qui n'a pas de valeur)
   - Deadline reel ou artificiel
   - Good cop/bad cop avec son avocat

4. **Gerer les tactiques adverses**
   - Face au bluff: demander des preuves
   - Face aux menaces: ignorer et documenter
   - Face au charme: rester factuel
   - Face a la colere: prendre une pause
   - Face aux promesses vagues: exiger par ecrit

5. **Finaliser l'accord**
   - Tout par ecrit, rien d'oral
   - Clauses de garantie et recours
   - Echeancier precis
   - Consequences en cas de non-respect

Inclure des exemples de phrases et formulations efficaces.
    `
  },
  {
    id: "documentation-preuves",
    name: "Documentation et Constitution de Preuves",
    query: `
Guide PRATIQUE pour documenter et constituer des preuves dans un conflit d'actionnaires au Quebec:

1. **Types de preuves admissibles**
   - Emails et correspondance ecrite
   - Proces-verbaux de reunions
   - Documents financiers (etats financiers, declarations fiscales)
   - Contrats et ententes
   - Enregistrements (regles au Quebec)
   - Temoignages

2. **Methodes de documentation**
   - Journal chronologique des evenements
   - Sauvegarde systematique des emails
   - Confirmation ecrite des discussions verbales
   - Photos/screenshots avec horodatage
   - Copies certifiees des documents importants

3. **Regles sur l'enregistrement au Quebec**
   - Consentement requis ou non
   - Admissibilite en cour
   - Risques legaux

4. **Organisation des preuves**
   - Classification chronologique
   - Index par sujet/personne
   - Chaine de possession
   - Sauvegardes multiples securisees

5. **Erreurs a eviter**
   - Ne pas modifier les documents originaux
   - Ne pas acceder illegalement a des systemes
   - Ne pas detruire de preuves (meme defavorables)
   - Ne pas harceler pour obtenir des aveux

6. **Preparation pour procedure judiciaire**
   - Affidavit et declaration sous serment
   - Interrogatoire au prealable
   - Communication de la preuve

Conseils pratiques et outils recommandes.
    `
  },
  {
    id: "alliances-strategiques",
    name: "Construction Alliances Strategiques",
    query: `
Strategies pour construire des ALLIANCES STRATEGIQUES dans un conflit corporatif contre un actionnaire majoritaire:

1. **Identifier les allies potentiels**
   - Autres actionnaires minoritaires mecontents
   - Employes cles qui ont des griefs
   - Anciens partenaires ou employes
   - Fournisseurs ou clients insatisfaits
   - Membres de la famille en desaccord

2. **Approche et recrutement**
   - Comment approcher discretement
   - Evaluer la fiabilite et la motivation
   - Partager l'information strategiquement
   - Creer des interets communs
   - Formaliser ou non l'alliance

3. **Coordination d'actions**
   - Communication securisee
   - Actions synchronisees
   - Partage des couts (legaux, experts)
   - Temoignages croises
   - Front uni en negociation

4. **Protection de l'alliance**
   - Confidentialite
   - Gestion des desaccords internes
   - Plan si un membre fait defection
   - Documentation des engagements

5. **Levier collectif**
   - Poids en assemblee d'actionnaires
   - Recours collectif
   - Pression mediatique coordonnee
   - Negociation groupee

Exemples de cas ou des minoritaires ont renverse la situation.
    `
  },
  {
    id: "psychologie-defense",
    name: "Defense Psychologique Personnelle",
    query: `
Strategies de PROTECTION PSYCHOLOGIQUE face a un manipulateur narcissique en contexte professionnel:

1. **Comprendre l'impact psychologique**
   - Gaslighting et doute de soi
   - Erosion de la confiance
   - Anxiete et hypervigilance
   - Sentiment d'impuissance apprise
   - Trauma bonding (attachement paradoxal)

2. **Techniques de protection mentale**
   - Grey rock (devenir ennuyeux et non-reactif)
   - Detachement emotionnel strategique
   - Validation externe (temoins, preuves)
   - Journaling pour maintenir sa realite
   - Limites fermes et consequences

3. **Gestion des emotions**
   - Ne pas reagir a chaud (pause 24h)
   - Canaliser la colere en action constructive
   - Eviter l'obsession et la rumination
   - Maintenir une vie equilibree hors du conflit
   - Support professionnel (psy, coach)

4. **Resilience a long terme**
   - Focus sur ce qu'on controle
   - Objectifs clairs et mesurables
   - Celebrer les petites victoires
   - Reseau de support solide
   - Plan de sortie comme filet de securite

5. **Erreurs psychologiques a eviter**
   - Esperer qu'il change
   - Chercher la validation du manipulateur
   - Se justifier excessivement
   - Reagir emotionnellement en public
   - S'isoler

Basé sur la recherche en psychologie et victimologie.
    `
  },
  {
    id: "evaluation-parts",
    name: "Evaluation Parts Sociales PME Quebec",
    query: `
Guide COMPLET sur l'evaluation des parts d'une PME au Quebec dans un contexte de conflit d'actionnaires:

1. **Methodes d'evaluation principales**
   - Actualisation des flux de tresorerie (DCF)
   - Multiples de benefices (EBITDA, revenus)
   - Valeur comptable ajustee
   - Transactions comparables
   - Methode mixte (goodwill + actifs)

2. **Ajustements specifiques**
   - Decote de minoritaire (20-35% typique)
   - Decote de non-liquidite
   - Surprime de controle
   - Normalisation des salaires et avantages
   - Actifs hors exploitation

3. **Documents requis pour evaluation**
   - Etats financiers 5 dernieres annees
   - Declarations fiscales corporatives
   - Projections financieres
   - Liste des actifs et passifs
   - Contrats importants

4. **Contestation d'une evaluation**
   - Identifier les hypotheses biaisees
   - Demander une contre-expertise
   - Comparer avec transactions similaires
   - Argumenter sur les decotes appliquees
   - Expert a l'audience

5. **Cas specifiques**
   - Evaluation en contexte d'oppression
   - Evaluation pour shotgun clause
   - Evaluation lors de divorce d'actionnaires
   - Impact des clauses de non-concurrence

Inclure des fourchettes de multiples par industrie au Quebec.
    `
  }
];

// ═══════════════════════════════════════════════════════════
// FONCTIONS DE RECHERCHE
// ═══════════════════════════════════════════════════════════

async function deepSearch(query, apiKey, model = "sonar-pro") {
  const response = await fetch("https://api.perplexity.ai/chat/completions", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${apiKey}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: model,
      messages: [
        {
          role: "system",
          content: `Tu es un expert multidisciplinaire specialise en:
- Droit des affaires et droit corporatif quebecois/canadien
- Psychologie organisationnelle et personnalites difficiles
- Strategies de negociation avancees
- Protection des actionnaires minoritaires

Tu fournis des analyses approfondies, pratiques et actionnables.
Tu cites les sources legales, jurisprudence et etudes pertinentes.
Tu es direct et strategique, pas academique.
Langue: Francais.`
        },
        {
          role: "user",
          content: query
        }
      ],
      temperature: 0.1,
      max_tokens: 8000,
      return_citations: true,
      return_images: false
    })
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`Perplexity API error (${response.status}): ${errorText}`);
  }

  return await response.json();
}

async function saveResult(result, outputDir, filename, queryName) {
  const filepath = path.join(outputDir, filename);

  const content = result.choices[0]?.message?.content || "No content returned";
  const citations = result.citations || [];
  
  let markdown = `# 🎯 ${queryName}\n\n`;
  markdown += `**Date**: ${new Date().toLocaleString('fr-CA')}\n`;
  markdown += `**Modele**: ${result.model}\n`;
  markdown += `**Projet**: Jerome Strategic Research\n\n`;
  markdown += `---\n\n`;
  markdown += content;
  
  if (citations.length > 0) {
    markdown += `\n\n---\n\n## 📚 Sources et Citations\n\n`;
    citations.forEach((citation, idx) => {
      markdown += `${idx + 1}. ${citation}\n`;
    });
  }

  markdown += `\n\n---\n*Genere par jerome-strategic-research.mjs*\n`;

  await fs.writeFile(filepath, markdown, "utf8");
  return filepath;
}

// ═══════════════════════════════════════════════════════════
// MAIN
// ═══════════════════════════════════════════════════════════

async function main() {
  const PERPLEXITY_API_KEY = requiredEnv("PERPLEXITY_API_KEY");
  const timestamp = new Date().toISOString().slice(0, 10);
  const OUTPUT_DIR = path.join(process.cwd(), "recherches-strategiques", timestamp);
  
  console.log("\n" + "═".repeat(60));
  console.log("🎯 JEROME STRATEGIC RESEARCH");
  console.log("═".repeat(60));
  console.log(`\n📁 Output: ${OUTPUT_DIR}\n`);

  await ensureDir(OUTPUT_DIR);

  // Verifier quel argument a ete passe
  const arg = process.argv[2];
  
  let queriesToRun = STRATEGIC_QUERIES;
  
  if (arg && arg !== "all") {
    const found = STRATEGIC_QUERIES.find(q => q.id === arg);
    if (found) {
      queriesToRun = [found];
    } else {
      console.log("❌ Recherche non trouvee. Options disponibles:");
      STRATEGIC_QUERIES.forEach(q => console.log(`   - ${q.id}: ${q.name}`));
      console.log("   - all: Toutes les recherches");
      process.exit(1);
    }
  }

  console.log(`📋 Recherches a effectuer: ${queriesToRun.length}\n`);

  for (const queryDef of queriesToRun) {
    console.log(`\n🔍 ${queryDef.name}...`);
    console.log("   ⏳ Recherche en cours (peut prendre 1-2 minutes)...");
    
    try {
      const result = await deepSearch(queryDef.query, PERPLEXITY_API_KEY);
      const filename = `${queryDef.id}.md`;
      const savedPath = await saveResult(result, OUTPUT_DIR, filename, queryDef.name);
      
      console.log(`   ✅ Sauvegarde: ${filename}`);
      console.log(`   📊 Tokens: ${result.usage?.total_tokens || "N/A"}`);
      console.log(`   📚 Sources: ${result.citations?.length || 0}`);
      
      // Delai entre les requetes pour eviter rate limiting
      if (queriesToRun.length > 1) {
        console.log("   ⏳ Pause 5s avant prochaine recherche...");
        await new Promise(r => setTimeout(r, 5000));
      }
      
    } catch (error) {
      console.error(`   ❌ Erreur: ${error.message}`);
    }
  }

  console.log("\n" + "═".repeat(60));
  console.log("✅ RECHERCHES TERMINEES");
  console.log("═".repeat(60));
  console.log(`\n📁 Resultats dans: ${OUTPUT_DIR}\n`);
  
  // Lister les fichiers generes
  try {
    const files = await fs.readdir(OUTPUT_DIR);
    console.log("📄 Fichiers generes:");
    files.forEach(f => console.log(`   - ${f}`));
  } catch (e) {}
  
  console.log("\n");
}

// Afficher l'aide si demande
if (process.argv[2] === "--help" || process.argv[2] === "-h") {
  console.log(`
🎯 JEROME STRATEGIC RESEARCH
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Usage: node jerome-strategic-research.mjs [recherche]

Recherches disponibles:
`);
  STRATEGIC_QUERIES.forEach(q => {
    console.log(`  ${q.id.padEnd(25)} ${q.name}`);
  });
  console.log(`  ${"all".padEnd(25)} Toutes les recherches

Exemples:
  node jerome-strategic-research.mjs                    # Toutes les recherches
  node jerome-strategic-research.mjs oppression-actionnaire
  node jerome-strategic-research.mjs dark-triad-business

Prerequis:
  Creer un fichier .env avec:
  PERPLEXITY_API_KEY=pplx-xxxxx

  Obtenir une cle API: https://www.perplexity.ai/settings/api
`);
  process.exit(0);
}

main().catch((err) => {
  console.error("❌ Erreur fatale:", err.message);
  process.exit(1);
});


