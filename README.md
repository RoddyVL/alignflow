# Application de Génération d'Idées de Produits Rentables

essayer cette application en live ici: https://frozen-citadel-32064-5a306c4bd116.herokuapp.com/

## Description
Cette application permet de générer des idées de produits ou de services rentables à partir des centres d'intérêt renseignés par un utilisateur. Elle utilise l'API OpenAI pour identifier des offres prometteuses en s'appuyant sur des critères prédéfinis, garantissant ainsi leur potentiel.

L'application facilite la sélection et l'analyse des opportunités de marché en proposant des sous-marchés ciblables pour chaque offre. De plus, elle automatise la génération de contenu stratégique comprenant :
- Un avatar client
- Une offre détaillée
- Un message marketing

Grâce à cette approche, les utilisateurs gagnent du temps dans la recherche d'offres rentables et disposent d'un écosystème optimisé pour contacter efficacement leur audience cible.

## Fonctionnalités
- **Identification d'idées de produits/services** en fonction des centres d'intérêt de l'utilisateur.
- **Requête à l'API OpenAI** pour évaluer la viabilité des offres.
- **Sélection d'une offre intéressante** et génération de sous-marchés ciblables.
- **Création automatique de contenu marketing** pour structurer une stratégie commerciale efficace.
- **Optimisation du positionnement** grâce à des informations clés sur le marché sélectionné.

## Défi principal
Le plus grand défi de cette application a été l'orchestration de l'interactivité entre l'utilisateur, le déclenchement de méthodes en background job, les requêtes API, la récupération des données de l'IA et le formatage en bonne et due forme pour correspondre aux colonnes des modèles, tout en appliquant du CSS directement à l'intérieur du contenu généré par l'IA.

## Technologies utilisées
- **Langage** : Ruby
- **API** : OpenAI
- **Framework** : ruby on rails
- **Base de données** : postgreSQL
- **Autre** : turbostream, hotwire, solid_queue

## Installation
1. Cloner ce dépôt :
   ```bash
   git clone https://github.com/RoddyVL/alignflow
   ```
2. Accéder au dossier du projet :
   ```bash
   cd alignflow
   ```
3. Installer les dépendances :
   ```bash
   bundle install
   ```
4. Configurer les variables d'environnement pour l'API OpenAI.
5. Lancer l'application :
   ```bash
   rails s
   ```
   et tester sur: localhost:3000

## Utilisation
1. Créer un compte et se connecter
2. créer un projet
3. Saisir ses centres d'intérêt dans l'interface.
4. Sélectionner une idée d'offre parmi les suggestions générées.
5. Explorer les sous-marchés potentiels et choisir une cible spécifique.
6. Obtenir automatiquement un avatar client, une offre et un message marketing.
7. Utiliser ces informations pour affiner sa stratégie et contacter les prospects efficacement.

## Contribution
Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou à proposer une pull request.
