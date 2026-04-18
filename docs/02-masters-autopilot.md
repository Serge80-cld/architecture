\# Module 2 — Conception des Masters Modernes \& Autopilot



\##  Objectifs du module

\- Remplacer les images WIM traditionnelles par un provisioning moderne.

\- Standardiser le déploiement des postes via Autopilot.

\- Réduire le time-to-serve et les erreurs humaines.

\- Supporter les scénarios : machine neuve, réaffectation, break/fix, remote work.



\---



\## 1. Pourquoi abandonner les masters traditionnels ?

\### Limites des images WIM

\- Maintenance lourde (patching, drivers, apps).

\- Risque d’incohérence entre versions.

\- Dépendance aux équipes SCCM/Infra.

\- Déploiement lent (réseau, PXE, MDT).



\### Avantages du modèle moderne

\- Provisioning cloud-first.

\- Zero-touch IT.

\- Standardisation par policies Intune.

\- Applications Win32 packagées proprement.

\- Réduction drastique du coût opérationnel.



\---



\## 2. Les trois modes Autopilot

\### \*\*User-driven\*\*

\- Scénario le plus courant.

\- L’utilisateur final réalise l’OOBE.

\- Entra ID Join + Enrollment Intune.



\### \*\*Self-deploying\*\*

\- Pas d’utilisateur.

\- Idéal pour bornes, kiosks, salles de réunion.



\### \*\*Pre-provisioning (anciennement WhiteGlove)\*\*

\- Préparation du poste par un technicien.

\- L’utilisateur final reçoit un poste déjà configuré.



\---



\## 3. Composants essentiels

\### \*\*Profil Autopilot\*\*

\- Mode de déploiement.

\- Paramètres OOBE.

\- Nom du device.

\- Joins : Entra ID ou Hybrid Join.



\### \*\*ESP (Enrollment Status Page)\*\*

\- Contrôle du provisioning.

\- Bloque l’accès tant que les apps critiques ne sont pas installées.



\### \*\*Group Tags\*\*

\- Permettent d’automatiser l’assignation des profils.



\### \*\*Groupes dynamiques\*\*

Exemple :

(device.devicePhysicalIds -any \_ -contains "\[OrderID]:Autopilot")



\### \*\*Applications Win32\*\*

\- Format .intunewin

\- Détection + désinstallation + logs



\---



\## 4. Flux complet de provisioning Autopilot

1\. Récupération du hash du device.

2\. Import dans Intune.

3\. Assignation du profil Autopilot.

4\. OOBE → connexion utilisateur.

5\. Entra ID Join.

6\. Enrollment Intune.

7\. Application des policies.

8\. Installation des applications.

9\. Validation ESP.



\---



\## 5. Bonnes pratiques grand compte

\- Minimiser les apps dans ESP (sinon blocage).

\- Utiliser des groupes dynamiques pour l’automatisation.

\- Standardiser les scripts d’import.

\- Tester sur un ring pilote avant production.

\- Documenter les versions de drivers et firmwares.

\- Utiliser des noms de devices standardisés (ex : `FR-PAR-LTP-%SERIAL%`).



\---



\## 6. Scripts utiles

\### Récupération du hash Autopilot

Install-Script -Name Get-WindowsAutopilotInfo

Get-WindowsAutopilotInfo -OutputFile device.csv



\### Import automatique dans Intune

(à utiliser dans un environnement pro)

Import-AutopilotCSV -csvFile device.csv



\---



\## 7. Validation

\- Device visible dans \*\*Devices → Windows → Windows enrollment → Devices\*\*.

\- Profil assigné automatiquement.

\- ESP passe au vert.

\- Device compliant après installation des policies.







