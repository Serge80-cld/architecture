\# Module 4 — Co-management (MECM + Intune)



\## Objectifs du module

\- Comprendre l’architecture du co-management.

\- Activer la coexistence MECM + Intune.

\- Définir les workloads basculés vers Intune.

\- Gérer les scénarios de transition progressive.

\- Préparer la migration vers un modèle 100% cloud.



\---



\## 1. Pourquoi le Co-management ?



\### Limites d’un environnement MECM seul

\- Dépendance au réseau interne.

\- Distribution lente hors VPN.

\- Maintenance lourde des DP/MP/SUP.

\- Difficulté à gérer les devices hybrides ou distants.



\### Avantages du Co-management

\- Transition progressive vers le cloud.

\- Gestion hybride : MECM + Intune.

\- Déploiement d’apps Win32 via IME.

\- Windows Update for Business.

\- Zero-touch provisioning via Autopilot.



\---



\## 2. Architecture du Co-management



\### Composants clés

\- MECM (SCCM) : MP, DP, SUP, SQL

\- Cloud Management Gateway (CMG)

\- Entra ID

\- Intune

\- Windows 10/11



\### Flux simplifié

1\. Le device est joint à Entra ID (ou Hybrid Join).

2\. MECM communique via CMG pour les devices distants.

3\. Intune prend progressivement le contrôle des workloads.

4\. Les deux solutions coexistent jusqu’à la bascule complète.



\---



\## 3. Activation du Co-management



\### Prérequis

\- MECM 2107+  

\- Windows 10/11 1909+  

\- Entra ID Connect configuré  

\- CMG recommandé (mais pas obligatoire)  

\- Device Hybrid Join ou Entra Join  



\### Étapes dans MECM

1\. \*\*Administration → Cloud Services → Co-management\*\*

2\. Cliquer sur \*\*Configure Co-management\*\*

3\. Choisir :

&#x20;  - \*\*Pilot\*\* (recommandé)

&#x20;  - ou \*\*All devices\*\*



\### Workloads disponibles

\- Compliance policies  

\- Resource access  

\- Windows Update  

\- Endpoint Protection  

\- Device Configuration  

\- Office Click-to-Run apps  



\---



\## 4. Stratégie de bascule des workloads



\### Mode recommandé : \*\*Pilot → Production\*\*

\- Créer un \*\*groupe pilote\*\* dans MECM

\- Tester chaque workload avant bascule globale



\### Ordre recommandé

1\. \*\*Compliance policies\*\*

2\. \*\*Resource access\*\*

3\. \*\*Device configuration\*\*

4\. \*\*Endpoint Protection\*\*

5\. \*\*Windows Update\*\*

6\. \*\*Office apps\*\*



\### Pourquoi cet ordre ?

\- Les workloads les plus critiques sont basculés en dernier.

\- On évite les conflits de configuration.



\---



\## 5. Gestion des applications en Co-management



\### MECM

\- Applications MSI

\- Packages

\- Task sequences

\- Applications complexes



\### Intune

\- Win32 (.intunewin)

\- Microsoft Store

\- Web apps

\- Scripts PowerShell



\### Bonnes pratiques

\- Ne jamais dupliquer une app dans MECM et Intune.

\- Documenter la source de vérité (MECM ou Intune).

\- Utiliser IME pour les apps modernes.



\---



\## 6. Windows Update en Co-management



\### MECM

\- SUP + ADR

\- WSUS

\- Déploiement classique



\### Intune (WUfB)

\- Rings

\- Feature updates

\- Quality updates

\- Deadline policies



\### Recommandation

Migrer progressivement vers \*\*WUfB\*\* pour simplifier l’architecture.



\---



\## 7. Scénarios de migration



\### 1. Device MECM → Co-management → Full Intune

Le scénario le plus courant.



\### 2. Device Autopilot → Intune → MECM client (rare)

Utilisé pour les environnements hybrides complexes.



\### 3. Device distant → CMG → Co-management

Idéal pour les collaborateurs en télétravail.



\---



\## 8. Troubleshooting



\### Vérifier l’état du Co-management

dsregcmd /status



\### Vérifier le client MECM

ccmexec /restart



\### Logs importants

\- \*\*CoManagementHandler.log\*\*

\- \*\*CCMEnrollment.log\*\*

\- \*\*Sensor.log\*\*

\- \*\*IntuneManagementExtension.log\*\*



\---



\## 9. Bonnes pratiques grand compte

\- Toujours commencer par un \*\*groupe pilote\*\*.

\- Documenter chaque workload basculé.

\- Ne jamais basculer tous les workloads en même temps.

\- Utiliser CMG pour les devices distants.

\- Préparer la migration vers un modèle full cloud.



\---



\## 10. Prochain module

➡️ \*\*Module 5 — Packaging applicatif (Win32, detection rules, logs)\*\*  

Nous allons créer :

\- `docs/05-packaging.md`

\- `labs/05-packaging.md`



