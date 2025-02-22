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

  product_analysis: <<~TEXT,
    Analyse ce produit sous tous ses angles : marché, demande, opportunités et risques.
    Identifie les principaux segments de clients et leurs attentes.
    Évalue la concurrence et les facteurs clés de succès.
    Détermine les stratégies marketing et de positionnement les plus adaptées.
  TEXT

  niche_research: <<~TEXT,
    Trouve les meilleures niches pour ce produit en te basant sur des données de marché réelles.
    Identifie les besoins non satisfaits, les tendances émergentes et les opportunités inexploitées.
    Fournis une liste de niches spécifiques et justifiées.
  TEXT
}
