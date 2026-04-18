\# Module 6 — Updates \& Security (WUfB, Baselines, Defender)



\## Objectifs du module

\- Comprendre la stratégie moderne de mise à jour Windows.

\- Configurer Windows Update for Business (WUfB).

\- Gérer les Feature Updates et Quality Updates.

\- Déployer les Security Baselines.

\- Configurer Microsoft Defender via Intune.

\- Assurer une posture de sécurité cohérente en environnement grand compte.



\---



\## 1. Pourquoi moderniser la gestion des mises à jour ?



\### Limites du modèle WSUS / MECM

\- Dépendance au réseau interne.

\- Maintenance lourde (SUP, WSUS cleanup).

\- Déploiement lent hors VPN.

\- Complexité des ADR.



\### Avantages de WUfB (Windows Update for Business)

\- 100% cloud.

\- Déploiement rapide et intelligent.

\- Contrôle granulaire des deadlines.

\- Feature updates pilotées.

\- Reporting centralisé dans Intune.



\---



\## 2. Architecture WUfB



\### Composants

\- Windows Update (Microsoft Cloud)

\- Intune (policies)

\- Windows Update for Business Deployment Service

\- Windows Analytics / Update Compliance (optionnel)



\### Flux

1\. Intune configure les policies WUfB.

2\. Le device contacte directement Windows Update.

3\. Les mises à jour sont téléchargées depuis Microsoft CDN.

4\. Intune collecte les rapports de conformité.



\---



\## 3. Configuration des Update Rings



\### Paramètres clés

\- \*\*Servicing channel\*\* : Semi-Annual (recommandé)

\- \*\*Quality updates\*\* : Auto install

\- \*\*Feature updates\*\* : Contrôlées via Feature Update Policy

\- \*\*Deadline\*\* : 7 jours (standard)

\- \*\*Grace period\*\* : 2 jours

\- \*\*Auto reboot\*\* : Oui



\### Recommandation grand compte

Créer 3 rings :

1\. \*\*Pilot\*\* (5% du parc)

2\. \*\*Broad\*\* (80%)

3\. \*\*Critical / VIP\*\* (15%)



\---



\## 4. Feature Updates (version de Windows)



Permet de figer la version cible :

\- Windows 10 22H2

\- Windows 11 23H2

\- Windows 11 24H2



\### Avantages

\- Contrôle total de la version

\- Déploiement progressif

\- Pas de mise à jour non planifiée



\---



\## 5. Security Baselines



\### Baselines disponibles

\- Windows 10/11 Security Baseline

\- Microsoft Defender Baseline

\- Edge Baseline



\### Objectifs

\- Standardiser la sécurité

\- Appliquer les recommandations Microsoft

\- Réduire les écarts de configuration



\### Bonnes pratiques

\- Toujours tester dans un ring pilote

\- Ne pas modifier trop de paramètres d’un coup

\- Documenter chaque changement



\---



\## 6. Microsoft Defender via Intune



\### Composants

\- Antivirus

\- EDR (Endpoint Detection \& Response)

\- ASR (Attack Surface Reduction)

\- SmartScreen

\- Firewall



\### Exemple de règles ASR recommandées

\- Block Office from creating child processes

\- Block credential stealing

\- Block executable content from email



\---



\## 7. Reporting \& Monitoring



\### Dans Intune :

\- \*\*Windows Update → Reports\*\*

\- \*\*Endpoint Security → Antivirus\*\*

\- \*\*Endpoint Security → Firewall\*\*

\- \*\*Endpoint Security → Attack Surface Reduction\*\*



\### Indicateurs clés

\- % de devices à jour

\- % de devices conformes

\- Versions Windows

\- Déploiement des Feature Updates



\---



\## 8. Bonnes pratiques grand compte

\- Toujours commencer par un ring pilote.

\- Séparer les rings par groupes dynamiques.

\- Documenter chaque policy dans GitHub.

\- Ne jamais activer toutes les ASR d’un coup.

\- Utiliser les baselines comme fondation.

\- Surveiller les logs IME pour les updates.



\---



\## 9. Résultat attendu

À la fin du module, tu maîtrises :

\- WUfB

\- Feature Updates

\- Security Baselines

\- Microsoft Defender

\- La stratégie de sécurité moderne



\---



\## 10. Fin du bootcamp

🎉 Félicitations — tu as terminé les 6 modules du bootcamp Modern Workplace.



Prochaines étapes possibles :

\- Ajouter des diagrammes dans `diagrams/`

\- Ajouter des scripts dans `scripts/`

\- Ajouter un README global pour présenter ton bootcamp

\- Préparer ton portfolio GitHub / LinkedIn



