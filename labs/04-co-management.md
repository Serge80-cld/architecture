\# Lab 04 — Co-management (MECM + Intune)



\## 🎯 Objectifs du lab

\- Activer le co-management sur un device Windows.

\- Configurer les workloads en mode Pilot.

\- Vérifier la communication MECM ↔ Intune ↔ CMG.

\- Tester la bascule progressive des workloads.

\- Comprendre les logs et le troubleshooting.



\---



\## 1. Prérequis

\- MECM 2107 ou supérieur.

\- Un environnement Intune opérationnel.

\- Entra ID Connect configuré.

\- Un device Windows Hybrid Join ou Entra Join.

\- (Optionnel mais recommandé) Cloud Management Gateway (CMG).



\---



\## 2. Étape 1 — Vérifier l’état du device



\### Sur le device Windows :

Vérifier l’état Entra ID :

dsregcmd /status



Vérifier le client MECM :

Control smscfgrc



Vérifier la communication CMG :

ccmexec /restart



\---



\## 3. Étape 2 — Activer le Co-management dans MECM



\### Dans la console MECM :

1\. Aller dans :  

&#x20;  \*\*Administration → Cloud Services → Co-management\*\*

2\. Cliquer sur \*\*Configure Co-management\*\*

3\. Choisir :

&#x20;  - \*\*Pilot\*\* (recommandé)

4\. Sélectionner un \*\*groupe pilote\*\* (collection MECM)

5\. Activer les workloads suivants en mode Pilot :

&#x20;  - \*\*Compliance policies\*\*

&#x20;  - \*\*Resource access\*\*

&#x20;  - \*\*Device configuration\*\*



\### Vérification

Dans MECM :

\*\*Monitoring → Co-management\*\*



Le device doit apparaître comme \*\*Co-managed\*\*.



\---



\## 4. Étape 3 — Vérifier la bascule des workloads



\### Dans Intune :

1\. Aller dans :  

&#x20;  \*\*Devices → Windows → Co-managed devices\*\*

2\. Vérifier :

&#x20;  - Workloads = Pilot

&#x20;  - Device visible dans Intune

&#x20;  - Compliance évaluée



\### Sur le device Windows :

Forcer la synchronisation :

Invoke-CimMethod -Namespace root\\ccm -ClassName SMS\_Client -MethodName TriggerSchedule -Arguments @{sScheduleID="{00000000-0000-0000-0000-000000000021}"}



Puis :

dsregcmd /status



\---



\## 5. Étape 4 — Tester la bascule d’un workload



\### Exemple : basculer \*\*Device Configuration\*\* vers Intune



Dans MECM :

1\. Retourner dans \*\*Co-management\*\*

2\. Modifier le workload \*\*Device Configuration\*\*

3\. Passer de \*\*Pilot\*\* → \*\*All\*\*



\### Vérification

Dans Intune :

\- Le device doit recevoir les profils de configuration Intune.

\- Les policies MECM ne doivent plus s’appliquer.



\### Sur le device :

Get-MDMPolicyResultantSet



\---



\## 6. Étape 5 — Vérifier Windows Update en Co-management



\### Dans Intune :

\*\*Devices → Windows → Update rings\*\*



Créer un ring pilote :

\- Feature updates = Semi-Annual

\- Quality updates = Auto install

\- Deadline = 7 jours



Assigner au groupe pilote.



\### Sur le device :

usoclient StartScan



\---



\## 7. Étape 6 — Logs \& Troubleshooting



\### Logs MECM

\- `CoManagementHandler.log`

\- `CCMEnrollment.log`

\- `Sensor.log`



\### Logs Intune

\- `IntuneManagementExtension.log`

\- `DeviceManagement-Enterprise-Diagnostics-Provider`



\### Commandes utiles

Vérifier l’état du client MECM :

Get-WmiObject -Namespace root\\ccm -Class SMS\_Client



Forcer une sync Intune :

Start-Process "ms-settings:workplace"



\---



\## 8. Résultat attendu

À la fin du lab, tu dois avoir :

\- Un device en co-management.

\- Les workloads en mode Pilot.

\- Une bascule fonctionnelle vers Intune.

\- Une compréhension claire des logs MECM + Intune.

\- Une architecture hybride opérationnelle.



\---



\## 9. Prochain module

➡️ \*\*Module 5 — Packaging applicatif (Win32, detection rules, logs)\*\*  

Nous allons créer :

\- `docs/05-packaging.md`

\- `labs/05-packaging.md`











