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

  message: <<~TEXT,
    À partir de cette niche ***%category***, je veux que tu répondes aux questions suivantes en te basant sur **des données réelles et vérifiables**.

    ### **Format de réponse attendu**
    - Chaque question doit être en **gras** avec la balise `<strong>`.
    - La réponse doit être claire, détaillée et structurée avec des retours à la ligne pour faciliter la lecture.
    - Ne saute aucune question et veille à ce que chaque élément soit traité de manière précise et pertinente.

    ### **Exemple de réponse correcte :**
    ```html
    <strong>Cette niche possède-t-elle son propre langage/argot ? Et si oui, quels sont quelques-uns des mots clés, phrases et expressions qu'ils utilisent ?</strong><br>
    Oui, cette niche utilise un certain nombre de termes spécifiques à leur domaine. Par exemple, les mots "toiture", "rénovation", "zinguerie" sont couramment utilisés dans leur communication. Certains expressions comme "toit végétalisé" ou "isolation thermique" sont également fréquemment mentionnées, indiquant une spécialisation dans les aspects techniques de la toiture.<br><br>

    <strong>Définis ton message en une ou deux phrases en utilisant l' “Équation du message” :  Equation: Je aide [niche] à [obtenir un résultat] en [offre].</strong><br>
    J'aide les entreprises de toiture à augmenter leur rentabilité et à obtenir plus de contrats en optimisant leur processus internes et en mettant en place une stratégie d'acquisition client efficace.<br><br>

    <strong>Évalue ton Message-Hypothèse sur une échelle de 1 à 10 pour voir à quel point il résonne avec tes prospects avant tout retour. 1 étant sans résonance et 10 étant une résonance parfaitement claire.</strong><br>
    8/10.<br><br>
    Les questions à traiter :
    <strong>Cette niche possède-t-elle son propre langage/argot ? Et si oui, quels sont quelques-uns des mots clés, phrases et expressions qu'ils utilisent ?</strong>
    <strong>Définis ton message en une ou deux phrases en utilisant l' “Équation du message” : Equation: Je aide [niche] à [obtenir un résultat] en [offre].</strong>
    <strong>Évalue ton Message-Hypothèse sur une échelle de 1 à 10 pour voir à quel point il résonne avec tes prospects avant tout retour. 1 étant sans résonance et 10 étant une résonance parfaitement claire.</strong>
    ⚡ Contraintes strictes :
    ✅ Utilise uniquement des données réalistes et vérifiables. Pas de spéculations ou de généralisations.
    ✅ Retourne la réponse en utilisant des balises HTML : Les questions en <strong> et les réponses avec des retours à la ligne (<br>) pour améliorer la lisibilité.
    ✅ Ne change pas la structure du prompt. Respecte l'ordre des questions et la présentation.


  TEXT

  result: <<~TEXT,
    À partir de la niche ***%category***, réponds aux questions suivantes en utilisant des **données réelles et vérifiables**. Organise ta réponse de la manière suivante :

    1. **Pour cette question spécifique** : "Déterminons ce qui fonctionne et ce qui ne fonctionne pas pour aider cette niche : ***%category***", rends la réponse sous forme de tableau avec deux colonnes : "Signal" et "Noise". Les éléments pertinents seront placés dans la colonne **Signal** et les éléments inutiles ou contradictoires seront placés dans la colonne **Noise**.

    2. **Pour toutes les autres questions**, tu réponds en texte normal avec une structure claire, incluant des balises HTML de formatage.

    <table class="table table-dark">
      <thead>
        <tr>
          <th scope="col">Signal</th>
          <th scope="col">Noise</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Signal 1: [Décrire un signal ici]</td>
          <td>Noise 1: [Décrire un bruit ici]</td>
        </tr>
        <tr>
          <td>Signal 2: [Décrire un autre signal ici]</td>
          <td>Noise 2: [Décrire un autre bruit ici]</td>
        </tr>
        <tr>
          <td>Signal 3: [Décrire un autre signal ici]</td>
          <td>Noise 3: [Décrire un autre bruit ici]</td>
        </tr>
        <!-- Ajoute des lignes supplémentaires pour chaque signal/noise -->
      </tbody>
    </table>

    <strong>Sur la base de ce qui précède, quel est le minimum de travail possible que tu pourrais faire pour aider cette niche à passer de leur situation actuelle à leur situation désirée ? (décris exactement ce que tu feras pour eux et combien de temps cela prendra)</strong><br>
    réponse<br><br>

    <strong>Quel serait un prix juste mais élevé que tu pourrais facturer pour cette offre ?</strong><br>
    réponse<br><br>

    <strong>Quelle est ta certitude sur ta niche sur une échelle de 1 à 10, avec 1 étant totalement incertain et 10 étant absolument certain ?</strong><br>
    réponse<br><br>

    <strong>À quel point la situation actuelle de la niche est-elle douloureuse, selon leur point de vue, sur une échelle de 1 à 10, avec 1 étant pas douloureux du tout et 10 étant une douleur excruciante ?</strong><br>
    réponse<br><br>

    <strong>À quel point le désir d'atteindre leur situation désirée est-il urgent pour cette niche, sur une échelle de 1 à 10, avec 1 étant aucun désir et 10 étant un désir extrême ?</strong><br>
    réponse<br><br>

    <strong>À quel point est-il complexe d'offrir la solution que tu proposes actuellement, sur une échelle de 1 à 10, avec 1 étant extrêmement complexe et 10 étant simple ?</strong><br>
    réponse<br><br>

    <strong>À quel point penses-tu qu'il est possible d'atteindre la situation désirée de la niche, sur une échelle de 1 à 10, avec 1 étant pas possible du tout et 10 étant plus que possible ?</strong><br>
    réponse<br><br>

    <strong>Ajoute tes classements des questions 8 à 12 ci-dessus. Quelle est ta note totale sur 50 ?</strong><br>
    réponse<br><br>

    <strong>Quel délai est-ce que tu estimes pour atteindre la situation désirée en jours ?</strong><br>
    réponse<br><br>

    ✅ Ne donne aucune analyse ou explication. Fournis uniquement les réponses sous la forme demandée.

  TEXT
}
