PROMPTS = {
  avatar: <<~TEXT,
   Je suis en train de créer une nouvelle offre: %category
    et j'ai besoin de comprendre mon client idéal.
    Ton travail est de m'aider en définissant un avatar client précis, basé sur des données réelles.

    Format de réponse :
    Retourne uniquement un JSON valide avec la structure suivante :

    json
    Copier
    Modifier
    {
      'description': '[Décris brièvement cet avatar : que fait-il ? Comment passe-t-il sa semaine ? Ses loisirs ? Où s'informe-t-il ? Quel est son revenu ? Son rapport à son travail ? Ses préoccupations ? Quels aspects de sa vie influencent la manière dont on doit lui vendre ce produit ? Quels événements ou expériences l'ont amené à ce point ? Comment perçoit-il ces expériences ? Quels centres d'intérêt en découlent ? Son statut familial et relationnel : est-il marié, célibataire, divorcé ? A-t-il des enfants ? Son cercle familial a-t-il une influence sur sa consommation du produit ? En quoi ce produit répond-il à un besoin, résout-il une douleur ou améliore-t-il sa vie ? Quels sont les éléments déclencheurs qui le poussent à acheter ? Quelles pensées lui traversent l'esprit avant de prendre sa décision ?]',
      'information': {
        'title': '[Titre du poste ou occupation]',
        'location': '[Pays, ville ou zone géographique]',
        'age': '[Âge en nombre]',
        'education': '[Niveau d'éducation]',
        'accomplishments': '[Principales réalisations]'
      }
    }
    Contraintes :

    Ne donne aucune analyse ou explication. Retourne uniquement la réponse au format JSON.
    Ne change pas la structure du JSON. Chaque élément doit être une chaîne de texte ou un nombre.
    Baser la réponse uniquement sur des données réelles et vérifiables, pas d'hypothèses.
    Aucune mise en forme supplémentaire (pas de retour à la ligne dans les valeurs JSON).

  TEXT

  offer: <<~TEXT,
    À partir de cette niche: %category

je veux que tu répondes aux questions suivantes en te basant sur des **données réelles et vérifiables**.

### **Format de réponse attendu**
Retourne **uniquement** un texte formaté en respectant la structure suivante :

- Chaque question doit être en **gras** avec la balise `<strong>`.
- La réponse doit être **claire, détaillée et bien structurée**, avec des retours à la ligne pour améliorer la lisibilité.
- Ne saute **aucune question** et assure-toi de donner des réponses précises et pertinentes.

### **Exemple de réponse correcte :**
```html
<strong>Quelle est leur situation actuelle ?</strong><br>
La majorité des participants de cette niche se trouvent dans une situation où ils manquent de ressources et de soutien pour atteindre leurs objectifs. Beaucoup sont encore en phase de test et d'expérimentation, ce qui les empêche d'obtenir des résultats stables.<br><br>

<strong>Quelle est leur situation désirée ?</strong><br>
Ils souhaitent atteindre un niveau où ils peuvent générer des revenus réguliers et avoir une stabilité financière grâce à leur activité. Leur objectif est de maximiser leur impact tout en ayant une charge de travail optimisée.<br><br>

<strong>Quel est le coût de rester dans leur situation actuelle ?</strong><br>
Leur stagnation leur coûte en opportunités perdues, en frustration et en temps gâché sur des stratégies inefficaces. Certains subissent également une pression financière qui les pousse à abandonner.<br><br>
Les questions à traiter :
<strong>Quelle est leur situation actuelle ?</strong>
<strong>Quelle est leur situation désirée ?</strong>
<strong>Quel est le coût de rester dans leur situation actuelle ?</strong>
<strong>Quelle est la valeur de les aider à atteindre leur situation désirée ?</strong>
<strong>Que font la plupart des participants de cette niche pour essayer d'atteindre leur situation désirée ? Cela fonctionne-t-il bien pour eux ?</strong>
<strong>Que proposent les prestataires de services aux participants pour les aider à atteindre leur situation désirée ? Cela fonctionne-t-il bien pour les participants et pour les prestataires ?</strong>
<strong>Que font les participants les plus performants ? Comment parviennent-ils à atteindre leur situation désirée et en quoi leur approche est-elle différente ?</strong>
⚡ Contraintes strictes :
✅ Ne donne aucune analyse ou explication. Fournis uniquement les réponses sous la forme demandée.
✅ Utilise des données réalistes et pertinentes. Pas d'hypothèses ou de spéculations vagues.
✅ Structure la réponse avec les balises <strong> pour les questions et <br> pour une meilleure lisibilité.

  TEXT

  niche_research: <<~TEXT,
    Trouve les meilleures niches pour ce produit en te basant sur des données de marché réelles.
    Identifie les besoins non satisfaits, les tendances émergentes et les opportunités inexploitées.
    Fournis une liste de niches spécifiques et justifiées.
  TEXT
}
