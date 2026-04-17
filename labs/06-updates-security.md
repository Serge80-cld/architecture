

\# Lab 06 — Updates \& Security (WUfB, Baselines, Defender)



\##  Objectifs du lab

\- Configurer Windows Update for Business (WUfB).

\- Créer des Update Rings (Pilot, Broad, VIP).

\- Déployer une Feature Update (version Windows).

\- Appliquer une Security Baseline.

\- Configurer Microsoft Defender via Intune.

\- Vérifier la conformité et analyser les logs.



\---



\## 1. Prérequis

\- Tenant Microsoft 365 avec Intune activé.

\- Rôle : Intune Administrator ou Endpoint Security Administrator.

\- Un device Windows 10/11 enrollé dans Intune.

\- Connexion Internet.



\---



\## 2. Étape 1 — Créer un Update Ring (Pilot)



\### Dans Intune :

1\. Aller dans :  

&#x20;  \*\*Devices → Windows → Update rings for Windows 10 and later\*\*

2\. Cliquer sur \*\*Create profile\*\*

3\. Nom : `WUfB - Pilot`

4\. Paramètres recommandés :

&#x20;  - Servicing channel : \*\*Semi-Annual\*\*

&#x20;  - Quality updates : \*\*Auto install\*\*

&#x20;  - Feature updates : \*\*Allow\*\*

&#x20;  - Deadline (quality) : \*\*7 jours\*\*

&#x20;  - Deadline (feature) : \*\*14 jours\*\*

&#x20;  - Grace period : \*\*2 jours\*\*

&#x20;  - Auto reboot : \*\*Yes\*\*



\### Assigner au groupe pilote

Exemple de groupe dynamique :

(device.deviceCategory -eq "Pilot")



\---



\## 3. Étape 2 — Créer un Update Ring (Broad)



Même procédure, mais avec :

\- Deadline quality : \*\*14 jours\*\*

\- Deadline feature : \*\*30 jours\*\*



Assigner au groupe \*\*Broad\*\*.



\---



\## 4. Étape 3 — Déployer une Feature Update



\### Dans Intune :

1\. Aller dans :  

&#x20;  \*\*Devices → Windows → Feature updates\*\*

2\. Cliquer sur \*\*Create profile\*\*

3\. Choisir la version cible :

&#x20;  - Windows 10 22H2  

&#x20;  - Windows 11 23H2  

&#x20;  - Windows 11 24H2  

4\. Assigner au groupe \*\*Pilot\*\*.



\### Vérification

Dans \*\*Reports → Windows updates\*\* :

\- Le device doit apparaître avec la version cible.



\---



\## 5. Étape 4 — Appliquer une Security Baseline



\### Dans Intune :

1\. Aller dans :  

&#x20;  \*\*Endpoint Security → Security Baselines\*\*

2\. Choisir :

&#x20;  - \*\*Windows 10/11 Security Baseline\*\*

3\. Cliquer sur \*\*Create profile\*\*

4\. Nom : `Baseline - Pilot`

5\. Laisser les paramètres par défaut (recommandé pour un pilote)



\### Assigner au groupe pilote



\### Vérification

Sur le device :

Get-MDMPolicyResultantSet



\---



\## 6. Étape 5 — Configurer Microsoft Defender



\### Dans Intune :

1\. Aller dans :  

&#x20;  \*\*Endpoint Security → Antivirus\*\*

2\. Créer une policy :

&#x20;  - Plateforme : Windows 10/11

&#x20;  - Type : Microsoft Defender Antivirus



\### Paramètres recommandés :

\- Real-time protection : \*\*Enabled\*\*

\- Cloud-delivered protection : \*\*Enabled\*\*

\- Automatic sample submission : \*\*Enabled\*\*

\- Scan type : \*\*Quick scan\*\*

\- Schedule : \*\*Daily\*\*



\### Ajouter une règle ASR (Attack Surface Reduction)

Exemple :

\- \*\*Block Office from creating child processes\*\*



\---



\## 7. Étape 6 — Vérifier l’état du device



\### Sur le device Windows :

Forcer la synchronisation :

Start-Process "ms-settings:workplace"



Vérifier la version Windows :

winver



Vérifier Defender :

Get-MpComputerStatus



Vérifier les policies appliquées :

Get-MDMPolicyResultantSet



\---



\## 8. Étape 7 — Logs \& Troubleshooting



\### Logs Windows Update

C:\\Windows\\SoftwareDistribution\\ReportingEvents.log



\### Logs IME (Intune)

C:\\ProgramData\\Microsoft\\IntuneManagementExtension\\Logs



Fichiers clés :

\- \*\*IntuneManagementExtension.log\*\*

\- \*\*AgentExecutor.log\*\*

\- \*\*AppIntentEval.log\*\*



\### Problèmes courants

\- \*\*0x8024001E\*\* → Windows Update service bloqué  

\- \*\*0x87D30067\*\* → Détection incorrecte  

\- \*\*Feature update bloquée\*\* → Device pas dans le bon ring  



\---



\## 9. Résultat attendu

À la fin du lab, tu dois avoir :

\- Des Update Rings opérationnels.

\- Une Feature Update déployée.

\- Une Security Baseline appliquée.

\- Microsoft Defender configuré.

\- Un device conforme et sécurisé.

\- Une compréhension complète de WUfB + Baselines + Defender.



\---



\## 10. Fin du bootcamp





ce depôt contient 

\- 6 modules complets  

\- 6 labs professionnels  

\- Une structure claire et consultant‑ready  

\- Un portfolio Modern Workplace crédible pour les grands comptes  



Prochaines étapes possibles :

\- Ajouter des diagrammes dans `diagrams/`

\- Ajouter des scripts dans `scripts/`

\- Ajouter un README global pour présenter ton bootcamp

\- Préparer ton portfolio GitHub / LinkedIn





