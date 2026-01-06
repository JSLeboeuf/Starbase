/**
 * 🎯 JEROME STRATEGIC SEARCH
 * Recherches Perplexity adaptées pour le dossier Jerome
 * 
 * Usage: node scripts/jerome-strategic-search.mjs
 * Requiert: PERPLEXITY_API_KEY dans .env
 */

import fs from "node:fs/promises";
import path from "node:path";
import { config } from "dotenv";

config();

function requiredEnv(name) {
  const value = process.env[name];
  if (!value) throw new Error(`Variable d'environnement manquante: ${name}`);
  return value;
}

async function ensureDir(dir) {
  await fs.mkdir(dir, { recursive: true });
}

async function deepSearch(query, apiKey, systemPrompt) {
  const response = await fetch("https://api.perplexity.ai/chat/completions", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${apiKey}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: "sonar-deep-research",
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: query }
      ],
      temperature: 0.1,
      max_tokens: 8000,
      return_citations: true,
      return_images: false
    })
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(`Erreur API Perplexity (${response.status}): ${errorText}`);
  }

  return await response.json();
}

async function saveResult(content, citations, outputDir, filename, title) {
  const filepath = path.join(outputDir, filename);
  
  let markdown = `# ${title}\n\n`;
  markdown += `**Date**: ${new Date().toISOString()}\n`;
  markdown += `**Modèle**: sonar-deep-research\n`;
  markdown += `**Type**: Recherche stratégique - Dossier Jerome\n\n`;
  markdown += `---\n\n`;
  markdown += content;
  
  if (citations && citations.length > 0) {
    markdown += `\n\n---\n\n## Sources et Citations\n\n`;
    citations.forEach((citation, idx) => {
      markdown += `${idx + 1}. ${citation}\n`;
    });
  }

  await fs.writeFile(filepath, markdown, "utf8");
  return filepath;
}

// Prompt système spécialisé pour le cas Jerome
const systemPrompt = `Tu es un expert combinant plusieurs domaines:

1. DROIT DES AFFAIRES QUÉBÉCOIS
   - Loi sur les sociétés par actions du Québec
   - Loi canadienne sur les sociétés par actions (LCSA)
   - Recours en oppression (art. 241 LCSA)
   - Conventions entre actionnaires
   - Jurisprudence québécoise et canadienne

2. PSYCHOLOGIE FORENSIQUE ET CORPORATIVE
   - Dark Triad en milieu professionnel (Babiak, Hare)
   - Manipulation corporative
   - Patterns de comportement prédateur en affaires
   - Documentation de comportements problématiques

3. STRATÉGIE DE NÉGOCIATION
   - Négociation distributive et intégrative
   - Tactiques de manipulation et contre-manipulation
   - BATNA et alternatives
   - Théorie des jeux appliquée aux conflits d'actionnaires

4. PROTECTION DES ACTIONNAIRES MINORITAIRES
   - Droits des actionnaires minoritaires
   - Mécanismes de protection
   - Recours disponibles

Tu fournis des analyses EXHAUSTIVES, DOCUMENTÉES, avec des CITATIONS de jurisprudence et d'études.
Tu es objectif, stratégique, et pratique. Tu proposes des actions concrètes.
Le contexte est québécois/canadien.`;

// Recherches spécifiques au cas Jerome
const searches = [
  {
    id: "01-oppression-actionnaire-quebec",
    title: "Oppression d'actionnaire minoritaire - Droit québécois",
    query: `
Analyse EXHAUSTIVE du recours en oppression d'actionnaire au Québec et au Canada:

## 1. CADRE JURIDIQUE
- Article 241 LCSA et équivalent LSAQ
- Définition juridique de l'oppression, préjudice, iniquité
- Distinction entre les trois concepts
- Seuil de preuve requis

## 2. JURISPRUDENCE CLÉE
- BCE Inc. c. Détenteurs de débentures 1976 (2008 CSC)
- Wilson c. Alharayeri (2017 CSC)
- Budd c. Gentra (1998 Ont. CA)
- Cas québécois pertinents
- Évolution de la jurisprudence

## 3. SITUATIONS COUVERTES
- Demandes de parts excessives/injustifiées
- Ciblage discriminatoire d'un actionnaire
- Tentatives de dilution
- Exclusion des décisions
- Manipulation entre actionnaires

## 4. REMÈDES DISPONIBLES
- Rachat des actions
- Ordonnance de rectification
- Dommages-intérêts
- Dissolution
- Autres réparations possibles

## 5. PROCESSUS ET PROCÉDURE
- Comment initier un recours
- Preuves à rassembler
- Délais et coûts
- Chances de succès selon les situations

## 6. CAS SPÉCIFIQUE À ANALYSER
Un actionnaire (6% + 80k$/an) demande unilatéralement 17% de parts additionnelles à UN SEUL autre actionnaire, sans justification objective. Quels éléments d'oppression potentielle?

Fournis des références précises à la jurisprudence et à la doctrine.
`
  },
  {
    id: "02-convention-actionnaire-protection",
    title: "Convention d'actionnaire - Clauses de protection maximale",
    query: `
Analyse EXHAUSTIVE des conventions entre actionnaires et clauses de protection:

## 1. CLAUSES DE VESTING
- Vesting et reverse vesting
- Schedules typiques (4 ans, cliff 1 an)
- Vesting rétroactif - est-ce possible?
- Conséquences de la démission/congédiement

## 2. CLAUSES DE PRÉEMPTION ET PREMIERS REFUS
- Droit de premier refus (ROFR)
- Droit de préemption
- Tag-along rights
- Drag-along rights
- Comment ça protège contre la dilution

## 3. CLAUSES RESTRICTIVES
- Non-concurrence
- Non-sollicitation (employés, clients)
- Confidentialité
- Durée et portée raisonnables au Québec

## 4. CLAUSES DE RÉSOLUTION DE CONFLITS
- Shotgun clause (buy-sell)
- Médiation obligatoire
- Arbitrage
- Clause d'évaluation en cas de désaccord

## 5. CLAUSES DE GOUVERNANCE
- Décisions requérant l'unanimité
- Composition du conseil
- Droits de veto
- Information aux actionnaires

## 6. PROTECTION SPÉCIFIQUE
Comment structurer une convention pour EMPÊCHER:
- Demandes unilatérales de parts additionnelles
- Ciblage discriminatoire d'un actionnaire
- Manipulation par pression informelle
- Exclusion progressive

## 7. MISE EN PLACE RÉTROACTIVE
Peut-on mettre en place une convention maintenant alors que les parts existent déjà sans convention? Procédure et négociation.

Fournis des exemples de clauses types et références juridiques québécoises.
`
  },
  {
    id: "03-dark-triad-corporatif",
    title: "Dark Triad en milieu corporatif - Identification et défense",
    query: `
Analyse EXHAUSTIVE de la Dark Triad en contexte professionnel:

## 1. CORPORATE PSYCHOPATHS (Babiak & Hare)
- "Snakes in Suits" - prévalence en entreprise (4-12%)
- Comment ils accèdent à des positions de pouvoir
- Caractéristiques distinctives
- Études de Boddy sur les corporate psychopaths

## 2. NARCISSISME CORPORATIF
- Narcissistic Personality Inventory (NPI)
- Manifestations en milieu professionnel
- "Je mérite plus" comme pattern
- Sense of entitlement et demandes excessives
- Envy et ciblage des plus performants

## 3. MACHIAVÉLISME EN AFFAIRES
- MACH-IV scale
- Lecture stratégique (Machiavel, Greene) comme indicateur
- Manipulation calculée à long terme
- "La fin justifie les moyens" en pratique
- Études sur les machiavéliques en entreprise

## 4. INDICATEURS À DOCUMENTER
Quels comportements spécifiques documenter pour établir un pattern?
- Communications écrites
- Témoins de comportements
- Incohérences entre paroles et actions
- Ciblage discriminatoire

## 5. STRATÉGIES DE DÉFENSE ÉTHIQUES
- Documentation systématique
- Création d'alliances
- Communication par écrit
- Ne pas répondre émotionnellement
- Établir des limites claires

## 6. CAS SPÉCIFIQUE
Un individu:
- Lit activement Machiavel et "48 Laws of Power"
- Demande 17% de parts supplémentaires sans justification
- Cible UN SEUL associé (pas les 2 autres)
- Utilise "c'est logique" comme justification
- A confessé (en état d'ébriété) se sentir "en-dessous" de sa cible

Quels patterns? Quelles protections?

Cite Hare, Babiak, Boddy, et études peer-reviewed.
`
  },
  {
    id: "04-negociation-contre-manipulation",
    title: "Négociation contre un manipulateur - Stratégies",
    query: `
Analyse EXHAUSTIVE des stratégies de négociation face à un manipulateur:

## 1. IDENTIFIER LA MANIPULATION
- Techniques de manipulation courantes en négociation
- Red flags à reconnaître
- Fausse urgence, fausse amitié, guilt-tripping
- Moving goalposts
- DARVO (Deny, Attack, Reverse Victim and Offender)

## 2. BATNA ET POSITION DE FORCE
- Best Alternative To Negotiated Agreement
- Comment renforcer sa position
- Quand dire non est la meilleure option
- Coût d'opportunité de céder

## 3. TECHNIQUES DE CONTRE-MANIPULATION
- Grey rock method
- Broken record technique
- Refus de s'engager émotionnellement
- Documentation systématique
- Témoins et transparence

## 4. COMMUNICATION EFFICACE
- Toujours par écrit
- CC d'autres parties
- Phrases à utiliser et éviter
- Ne pas JADE (Justify, Argue, Defend, Explain)

## 5. THÉORIE DES JEUX APPLIQUÉE
- Jeu répété vs one-shot
- Stratégie tit-for-tat
- Commitment devices
- Signaling credibility

## 6. SCÉNARIO SPÉCIFIQUE
Comment répondre à:
"Je veux qu'on switch nos parts, toi tu passes de 23% à 6%, moi de 6% à 23%. C'est logique parce que je développe tout."

Options:
A) Refus total
B) Refus + action préventive (alliances)
C) Contre-offre (laquelle?)
D) Acceptation (conséquences?)
E) Sortie (nuclear option)

Analyse chaque option avec probabilités de succès.

Cite Fisher & Ury (Getting to Yes), Cialdini, recherches sur la négociation.
`
  },
  {
    id: "05-documentation-preuve",
    title: "Documentation et constitution de preuves - Best practices",
    query: `
Analyse EXHAUSTIVE de la documentation de comportements problématiques en contexte corporatif:

## 1. TYPES DE PREUVES ADMISSIBLES
- Communications écrites (emails, textos, messages)
- Témoignages de tiers
- Documents corporatifs
- Preuves de contributions
- Enregistrements (légalité au Québec)

## 2. DOCUMENTATION CONTEMPORAINE
- Tenir un journal des événements
- Dates, heures, témoins
- Citations exactes
- Contexte et circonstances
- Impact ressenti

## 3. PRÉSERVATION DES PREUVES
- Ne pas modifier les originaux
- Copies de sauvegarde
- Chaîne de custody
- Authentification

## 4. PREUVES DE CONTRIBUTION
- Comment documenter sa propre contribution
- Emails récapitulatifs
- Livrables attribués
- Décisions prises
- Innovation apportée

## 5. TÉMOINS
- Identifier les témoins potentiels
- Comment les approcher
- Déclarations écrites vs témoignage
- Protection des témoins

## 6. ERREURS À ÉVITER
- Modification de preuves
- Harcèlement pour obtenir des preuves
- Violation de confidentialité
- Preuves obtenues illégalement

## 7. APPLICATION PRATIQUE
Pour documenter:
- Demande de switch de parts (23%→6% vs 6%→23%)
- Ciblage discriminatoire (toi seul, pas les autres)
- Pattern machiavélique (lecture stratégique, manipulation)
- Justifications changeantes

Quoi documenter? Comment? Où stocker?

Cite jurisprudence québécoise sur l'admissibilité des preuves.
`
  },
  {
    id: "06-alliances-strategiques",
    title: "Création d'alliances stratégiques entre actionnaires",
    query: `
Analyse EXHAUSTIVE de la création d'alliances entre actionnaires:

## 1. DYNAMIQUES D'ACTIONNARIAT
- Coalitions et blocs de vote
- Actionnaire de contrôle vs minoritaires
- Équilibre des pouvoirs
- Règles de majorité et unanimité

## 2. STRATÉGIE D'ALLIANCE
- Identifier les alliés naturels
- Intérêts alignés vs divergents
- Approche de recrutement d'alliés
- Timing de l'approche

## 3. COMMUNICATION STRATÉGIQUE
- Parler aux alliés AVANT le manipulateur
- Framing de la situation
- Information factuelle vs émotionnelle
- Ne pas attaquer, documenter

## 4. PROTECTION MUTUELLE
- Accords informels de vote
- Conventions de vote (legales?)
- Engagements de solidarité
- Mécanismes de consultation

## 5. RISQUES À GÉRER
- Être perçu comme manipulateur soi-même
- Briser la confiance
- Créer des camps permanents
- Escalade du conflit

## 6. CAS SPÉCIFIQUE
Structure: 4 actionnaires
- Cédric: 48% (actionnaire principal)
- Jean-Samuel (toi): 23%
- Jérôme: 6% (le demandeur)
- Félix: 23% (ami de Jérôme)

Comment:
1. S'assurer du support de Cédric?
2. Neutraliser/récupérer Félix?
3. Isoler Jérôme sans paraître manipulateur?
4. Documenter les alliances?

Stratégie recommandée pour chaque acteur.
`
  },
  {
    id: "07-psychologie-noire-defense",
    title: "Psychologie noire - Techniques de défense",
    query: `
Analyse EXHAUSTIVE des techniques de défense contre la manipulation psychologique:

## 1. CHARTE DE BIDERMAN (INVERSÉE)
Les 8 techniques de coercition:
1. Isolement → Comment contrer
2. Monopolisation de perception → Comment contrer
3. Épuisement → Comment contrer
4. Menaces → Comment contrer
5. Indulgences occasionnelles → Comment reconnaître
6. Démonstration de toute-puissance → Comment contrer
7. Humiliation → Comment contrer
8. Trivialisation → Comment contrer

## 2. TECHNIQUES DE DÉSARMEMENT
- Miroir noir (refléter le comportement)
- Inversion de charge (retourner la pression)
- Question mortelle (impossible à répondre sans s'exposer)
- Silence stratégique
- Documentation publique

## 3. PROTECTION ÉMOTIONNELLE
- Grey rock (devenir ennuyeux)
- No JADE (pas de justification)
- Détachement émotionnel
- Maintenir ses limites
- Self-care pendant le conflit

## 4. CONTRE-TECHNIQUES SPÉCIFIQUES
Comment répondre à:
- "C'est logique" → ?
- "Je développe tout" → ?
- "Tu fais rien" → ?
- "Switch de parts" → ?
- Menace de partir → ?

## 5. EXPOSER LA MANIPULATION
- Quand exposer (timing)
- Comment exposer (ton, preuves)
- À qui exposer (audience)
- Risques de l'exposition

## 6. PROTECTION LÉGALE
- Quand impliquer un avocat
- Mise en demeure
- Documentation formelle
- Recours disponibles

Cite études sur la manipulation, counter-manipulation, psychologie forensique.
`
  },
  {
    id: "08-valuation-parts-societe-privee",
    title: "Évaluation de parts de société privée - Méthodes",
    query: `
Analyse EXHAUSTIVE des méthodes d'évaluation de parts de société privée au Québec:

## 1. MÉTHODES D'ÉVALUATION
- Valeur comptable ajustée
- Multiple des bénéfices (EBITDA)
- Flux de trésorerie actualisés (DCF)
- Transactions comparables
- Valeur de liquidation

## 2. SPÉCIFICITÉS IMMOBILIÈRES
- Évaluation de projets immobiliers
- Valeur des terrains et immeubles
- Projets en développement
- NAV (Net Asset Value)
- Cap rates et leur application

## 3. DÉCOTES ET PRIMES
- Décote d'illiquidité (30-50%?)
- Décote de minorité
- Prime de contrôle
- Impact sur la valeur des 6% vs 23%

## 4. CLAUSES D'ÉVALUATION
- Fair market value (JVM)
- Prix plancher/plafond
- Mécanisme d'évaluation en cas de désaccord
- Expert indépendant vs formule

## 5. CAS PRATIQUE
Projet de 48 portes (multirésidentiel):
- Valeur estimée du projet complet
- Valeur de 23% de parts
- Valeur de 6% de parts
- Impact du switch demandé en $$$

Si le projet vaut 10M$:
- 23% = 2.3M$ (moins décotes)
- 6% = 600k$ (moins décotes)
- Différence = ~1.7M$

Comment justifier ce refus en termes financiers?

## 6. JURISPRUDENCE SUR L'ÉVALUATION
- Cas québécois de désaccord sur évaluation
- Rôle des experts
- Coûts d'expertise

Cite standards de l'industrie et jurisprudence pertinente.
`
  }
];

async function main() {
  const PERPLEXITY_API_KEY = requiredEnv("PERPLEXITY_API_KEY");
  const OUTPUT_DIR = "recherches";
  
  console.log("🎯 JEROME STRATEGIC SEARCH\n");
  console.log("═".repeat(60));
  console.log(`📚 ${searches.length} recherches stratégiques à effectuer`);
  console.log("⏳ Temps estimé: 20-30 minutes\n");
  console.log("═".repeat(60) + "\n");

  await ensureDir(OUTPUT_DIR);
  
  const timestamp = new Date().toISOString().replace(/:/g, "-").split(".")[0];
  const searchDir = path.join(OUTPUT_DIR, `strategic-${timestamp}`);
  await ensureDir(searchDir);
  
  const results = [];
  let totalCitations = 0;
  let totalTokens = 0;
  
  for (let i = 0; i < searches.length; i++) {
    const search = searches[i];
    console.log(`\n[${i + 1}/${searches.length}] 🔍 ${search.title}`);
    console.log("─".repeat(50));
    
    try {
      const result = await deepSearch(search.query, PERPLEXITY_API_KEY, systemPrompt);
      
      const content = result.choices[0]?.message?.content || "Aucun contenu";
      const citations = result.citations || [];
      const tokens = result.usage?.total_tokens || 0;
      
      totalCitations += citations.length;
      totalTokens += tokens;
      
      const filename = `${search.id}.md`;
      const savedPath = await saveResult(content, citations, searchDir, filename, search.title);
      
      results.push({
        id: search.id,
        title: search.title,
        path: savedPath,
        citations: citations.length,
        tokens: tokens
      });
      
      console.log(`   ✅ Terminé! ${citations.length} sources, ${tokens} tokens`);
      console.log(`   📁 ${savedPath}`);
      
      // Pause entre les requêtes pour éviter le rate limiting
      if (i < searches.length - 1) {
        console.log(`   ⏳ Pause 5 secondes...`);
        await new Promise(r => setTimeout(r, 5000));
      }
      
    } catch (error) {
      console.log(`   ❌ Erreur: ${error.message}`);
      results.push({
        id: search.id,
        title: search.title,
        error: error.message
      });
      
      // Si erreur de rate limit, attendre plus longtemps
      if (error.message.includes("429") || error.message.includes("rate")) {
        console.log(`   ⏳ Rate limit détecté, pause 30 secondes...`);
        await new Promise(r => setTimeout(r, 30000));
      }
    }
  }
  
  // Créer l'index
  console.log("\n" + "═".repeat(60));
  console.log("📋 Création de l'index...\n");
  
  let indexContent = `# 🎯 JEROME STRATEGIC SEARCH - Index\n\n`;
  indexContent += `**Date**: ${new Date().toISOString()}\n`;
  indexContent += `**Recherches**: ${searches.length}\n`;
  indexContent += `**Sources totales**: ${totalCitations}\n`;
  indexContent += `**Tokens totaux**: ${totalTokens}\n\n`;
  indexContent += `---\n\n`;
  indexContent += `## 📚 Table des Matières\n\n`;
  
  for (const result of results) {
    if (result.error) {
      indexContent += `- ❌ **${result.title}** - Erreur: ${result.error}\n`;
    } else {
      indexContent += `- ✅ [**${result.title}**](./${result.id}.md) - ${result.citations} sources\n`;
    }
  }
  
  indexContent += `\n---\n\n`;
  indexContent += `## 📊 Résumé\n\n`;
  indexContent += `| # | Recherche | Sources | Tokens |\n`;
  indexContent += `|---|-----------|---------|--------|\n`;
  
  for (let i = 0; i < results.length; i++) {
    const r = results[i];
    if (r.error) {
      indexContent += `| ${i+1} | ${r.title} | ❌ | - |\n`;
    } else {
      indexContent += `| ${i+1} | ${r.title} | ${r.citations} | ${r.tokens} |\n`;
    }
  }
  
  indexContent += `| **TOTAL** | **${results.filter(r => !r.error).length}/${searches.length}** | **${totalCitations}** | **${totalTokens}** |\n`;
  
  indexContent += `\n---\n\n`;
  indexContent += `## 🎯 Utilisation\n\n`;
  indexContent += `Ces recherches fournissent:\n`;
  indexContent += `1. **Cadre juridique** québécois pour le conflit d'actionnaires\n`;
  indexContent += `2. **Analyse psychologique** du pattern machiavélique-narcissique\n`;
  indexContent += `3. **Stratégies de défense** documentées et éthiques\n`;
  indexContent += `4. **Options de négociation** avec probabilités\n`;
  indexContent += `5. **Méthodes de documentation** des comportements\n`;
  indexContent += `\n*Généré automatiquement par jerome-strategic-search.mjs*\n`;
  
  await fs.writeFile(path.join(searchDir, "INDEX.md"), indexContent, "utf8");
  
  // Résumé final
  console.log("═".repeat(60));
  console.log("\n🎯 RECHERCHES TERMINÉES!\n");
  console.log(`📁 Dossier: ${searchDir}`);
  console.log(`📚 Recherches: ${results.filter(r => !r.error).length}/${searches.length} réussies`);
  console.log(`📖 Sources totales: ${totalCitations}`);
  console.log(`🔢 Tokens totaux: ${totalTokens}`);
  console.log(`\n📋 Index: ${path.join(searchDir, "INDEX.md")}`);
  console.log("\n" + "═".repeat(60));
}

main().catch((err) => {
  console.error("❌ Erreur fatale:", err);
  process.exit(1);
});


