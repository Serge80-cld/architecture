\# Lab 02 — Déploiement Autopilot (User-driven)



\##  Objectifs du lab

\- Récupérer le hash matériel d’un device Windows.

\- Importer le device dans Autopilot.

\- Créer et assigner un profil Autopilot.

\- Réaliser un déploiement complet via OOBE.

\- Vérifier l’enrollment Intune + ESP.



\---



\## 1. Prérequis

\- Un tenant Microsoft 365 avec Intune activé.

\- Un compte avec rôle :

&#x20; - Intune Administrator \*\*ou\*\*

&#x20; - Windows Autopilot Administrator.

\- Un PC Windows 10/11 (physique ou VM).

\- PowerShell 5+ ou 7+.

\- Connexion Internet.



\---



\## 2. Étape 1 — Récupération du hash matériel



\### Installer le script officiel Microsoft

```powershell

Install-Script -Name Get-WindowsAutopilotInfo -Force

Exécuter la collecte du hash

Get-WindowsAutopilotInfo -OutputFile device.csv



Le fichier device.csv contient :



Serial Number



Hardware Hash



Manufacturer



Model



 Important : ce hash est unique et obligatoire pour Autopilot.



3\. Étape 2 — Import du device dans Autopilot

Via le portail Intune

Aller dans :

Intune → Devices → Windows → Windows enrollment → Devices



Cliquer sur Import.



Importer le fichier device.csv.



Attendre que le device apparaisse (1 à 5 minutes).



(Optionnel) Import automatique via PowerShell

powershell

Import-AutopilotCSV -csvFile .\\device.csv

4\. Étape 3 — Création du profil Autopilot

Dans Intune :

Devices → Windows → Windows enrollment → Deployment Profiles



Create profile → Windows PC



Paramètres recommandés :



Deployment mode : User-driven



Join type : Entra ID Join



Skip privacy settings : Yes



Skip EULA : Yes



Skip account setup : Yes



Apply device name template :

FR-PAR-LTP-%SERIAL%



Assigner le profil

Créer un groupe dynamique basé sur le Group Tag (optionnel).



Assigner le profil au groupe.



5\. Étape 4 — Préparation du device

Réinitialiser le PC

powershell

systemreset -factoryreset

Ou via interface :

Settings → System → Recovery → Reset this PC



Démarrer l’OOBE

Le PC doit afficher :



Choix de langue



Connexion réseau



Écran Autopilot (logo entreprise si configuré)



6\. Étape 5 — Déroulement du provisioning

Ce que l’utilisateur voit :

Connexion au Wi-Fi



Écran “Welcome to Contoso” (branding)



Connexion Entra ID



ESP (Enrollment Status Page)



Ce que fait Intune en arrière-plan :

Entra ID Join



Enrollment MDM



Application des policies



Installation des apps Win32



Compliance



7\. Étape 6 — Validation du déploiement

Vérifier dans Intune :

Devices → Windows → All devices



Le device doit être :



Enrolled



Compliant



Assigné au bon utilisateur



Avec le bon nom (template appliqué)



Vérifier la conformité :

Devices → Monitor → Device compliance



Vérifier les apps :

Apps → Monitor → App install status



8\. Troubleshooting (grand compte)

ESP bloqué

Trop d’apps dans la phase “Block device use”.



Solution : réduire les apps critiques.



Device non assigné

Group Tag incorrect.



Profil non assigné.



Hash incorrect

Refaire la commande :



powershell

Get-WindowsAutopilotInfo -OutputFile device.csv

Device non visible dans Autopilot

Attendre 5 minutes.



Vérifier les rôles.



Vérifier le fichier CSV.



9\. Résultat attendu

À la fin du lab, tu dois avoir :



Un device importé dans Autopilot.



Un profil assigné automatiquement.



Un déploiement complet via OOBE.



Un device compliant dans Intune.



Un provisioning 100% moderne, sans master WIM.
10. Prochain module
Module 3 — Lifecycle (compliance, configuration, offboarding)  
Nous allons créer :

docs/03-lifecycle.md

labs/03-lifecycle.md
