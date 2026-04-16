\# Lab 03 — Lifecycle Management (Conformité, Configuration, Offboarding)



\## 🎯 Objectifs du lab

\- Créer et appliquer des règles de conformité (Compliance Policies).

\- Déployer des profils de configuration (Configuration Profiles).

\- Tester la conformité d’un device Windows.

\- Exécuter les actions de cycle de vie : Retire, Wipe, Fresh Start.

\- Vérifier les logs et la synchronisation MDM.



\---



\## 1. Prérequis

\- Tenant Microsoft 365 avec Intune activé.

\- Rôle : Intune Administrator ou Endpoint Security Administrator.

\- Un device Windows 10/11 déjà enrollé dans Intune.

\- Connexion Internet.



\---



\## 2. Étape 1 — Créer une règle de conformité



\### Dans Intune :

1\. Aller dans :  

&#x20;  \*\*Intune → Devices → Compliance policies → Policies\*\*

2\. Cliquer sur \*\*Create policy\*\*.

3\. Choisir \*\*Windows 10 and later\*\*.

4\. Ajouter les règles suivantes :

&#x20;  - \*\*Require BitLocker = Yes\*\*

&#x20;  - \*\*Require Secure Boot = Yes\*\*

&#x20;  - \*\*Minimum OS version = 10.0.19045\*\*

&#x20;  - \*\*Firewall = Required\*\*

5\. Enregistrer.



\### Assigner la règle

\- Créer un groupe dynamique (exemple) :

(device.deviceOSType -eq "Windows")

\- Assigner la policy au groupe.



\### Vérification

Dans \*\*Devices → Monitor → Device compliance\*\*, ton device doit apparaître :

\- \*\*Compliant\*\* ou  

\- \*\*Not compliant\*\* (si BitLocker n’est pas activé)



\---



\## 3. Étape 2 — Créer un profil de configuration



\### Dans Intune :

1\. Aller dans :  

&#x20;\*\*Devices → Configuration profiles\*\*

2\. \*\*Create profile\*\*

3\. Plateforme : \*\*Windows 10 and later\*\*

4\. Type : \*\*Settings Catalog\*\*

5\. Ajouter les paramètres :

&#x20;- \*\*Password → Minimum length = 8\*\*

&#x20;- \*\*Firewall → Enable = Yes\*\*

&#x20;- \*\*OneDrive → Silent Account Config = Enabled\*\*

&#x20;- \*\*Windows Update → Automatic Updates = Auto install\*\*



\### Assigner le profil

\- Même groupe dynamique que précédemment.



\### Vérification

Sur le device Windows :

dsregcmd /status

Puis :

Get-MDMPolicyResultantSet



\---



\## 4. Étape 3 — Vérifier la conformité du device



\### Sur le device Windows :

Forcer la synchronisation :

Start-Process "ms-settings:workplace"

Puis cliquer sur \*\*Sync\*\*.



\### Vérifier les logs Intune

C:\\ProgramData\\Microsoft\\IntuneManagementExtension\\Logs



Fichiers importants :

\- \*\*IntuneManagementExtension.log\*\*

\- \*\*DeviceManagement-Enterprise-Diagnostics-Provider\*\*



\---



\## 5. Étape 4 — Tester les actions de cycle de vie



\### 1. \*\*Retire\*\*

Dans Intune :

\*\*Devices → Windows → \[Device] → Retire\*\*



Effet :

\- Retire le MDM

\- Laisse les données utilisateur



\### 2. \*\*Wipe\*\*

\*\*Devices → Windows → \[Device] → Wipe\*\*



Effet :

\- Réinitialisation complète

\- Suppression des données



\### 3. \*\*Fresh Start\*\*

\*\*Devices → Windows → \[Device] → Fresh Start\*\*



Effet :

\- Réinstalle Windows

\- Conserve les données utilisateur

\- Supprime les bloatwares OEM



\---



\## 6. Étape 5 — Réaffectation d’un device



\### Scénario :

Un collaborateur quitte l’entreprise → le PC doit être réaffecté.



\### Étapes :

1\. \*\*Wipe\*\* du device.

2\. Suppression du device dans :

&#x20;  - Intune

&#x20;  - Entra ID

3\. Réassignation du device à un nouvel utilisateur.

4\. Nouveau déploiement via Autopilot.



\---



\## 7. Troubleshooting (grand compte)



\### Device non compliant

\- Vérifier BitLocker :

manage-bde -status

\- Vérifier Secure Boot :

Confirm-SecureBootUEFI



\### Policies non appliquées

\- Vérifier la sync :

dsregcmd /status

\- Vérifier les logs IME.



\### Device bloqué dans “Not evaluated”

\- Attendre 5–10 minutes.

\- Forcer la sync.

\- Vérifier les groupes dynamiques.



\---



\## 8. Résultat attendu

À la fin du lab, tu dois avoir :

\- Une compliance policy fonctionnelle.

\- Un profil de configuration appliqué.

\- Un device compliant dans Intune.

\- La maîtrise des actions : Retire, Wipe, Fresh Start.

\- Une compréhension complète du cycle de vie d’un device.



\---



\## 9. Prochain module

➡️ \*\*Module 4 — Co-management (MECM + Intune)\*\*  

Nous allons créer :

\- `docs/04-co-management.md`

\- `labs/04-co-management.md`



















