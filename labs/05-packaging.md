\# Lab 05 — Packaging Applicatif (Win32, Détection, Logs, Automatisation)



\##  Objectifs du lab

\- Créer un package Win32 (.intunewin) complet.

\- Ajouter un script d’installation et de désinstallation.

\- Créer une règle de détection professionnelle.

\- Importer l’application dans Intune.

\- Vérifier l’installation et analyser les logs IME.

\- Automatiser la création de packages.



\---



\## 1. Prérequis

\- Windows 10/11

\- Intune activé

\- Rôle : Intune Administrator

\- Outil \*\*IntuneWinAppUtil.exe\*\*

\- Application à packager (ex : 7zip, VLC, Notepad++)



\---



\## 2. Étape 1 — Préparer la structure du package



Créer un dossier propre :



C:\\Sources\\NotepadPP\\



Créer la structure recommandée :



C:\\Sources\\NotepadPP\\

install\\

uninstall\\

detection\\

README.md



Copier l’installeur dans :



C:\\Sources\\NotepadPP\\install\\



Exemple : `npp.8.6.2.Installer.x64.exe`



\---



\## 3. Étape 2 — Créer le script d’installation



Créer le fichier :



notepad C:\\Sources\\NotepadPP\\install\\install.ps1



Coller :



```powershell

$exe = ".\\npp.8.6.2.Installer.x64.exe"

Start-Process $exe -ArgumentList "/S" -Wait -NoNewWindow



if (!(Test-Path "C:\\Program Files\\Notepad++\\notepad++.exe")) {

&#x20;   Write-Error "Installation failed"

&#x20;   exit 1

}



exit 0

4\. Étape 3 — Créer le script de désinstallation

Créer :

notepad C:\\Sources\\NotepadPP\\uninstall\\uninstall.ps1

Coller :

$path = "C:\\Program Files\\Notepad++\\uninstall.exe"

if (Test-Path $path) {

&#x20;   Start-Process $path -ArgumentList "/S" -Wait

}

exit 0

5\. Étape 4 — Créer la règle de détection

Créer :

notepad C:\\Sources\\NotepadPP\\detection\\detection.ps1

Coller :

if (Test-Path "C:\\Program Files\\Notepad++\\notepad++.exe") {

&#x20;   exit 0

}

exit 1

6\. Étape 5 — Créer le package .intunewin

Exécuter :

IntuneWinAppUtil.exe -c "C:\\Sources\\NotepadPP" -s "install\\install.ps1" -o "C:\\Packages"

Résultat attendu :



C:\\Packages\\NotepadPP.intunewin

7\. Étape 6 — Importer l’application dans Intune

Dans Intune :



Apps → Windows → Add



Type : Win32 app



Upload : NotepadPP.intunewin



Installer :

powershell.exe -ExecutionPolicy Bypass -File install\\install.ps1

5.Désinstaller :

powershell.exe -ExecutionPolicy Bypass -File uninstall\\uninstall.ps1

6.Détection :



Script PowerShell → detection.ps1



Assigner à un groupe pilote.

8\. Étape 7 — Vérifier l’installation sur le device

Sur le poste Windows :



Forcer la sync :

Start-Process "ms-settings:workplace"

Vérifier les logs IME :

C:\\ProgramData\\Microsoft\\IntuneManagementExtension\\Logs

Fichiers clés :



IntuneManagementExtension.log



AgentExecutor.log



AppIntentEval.log

9\. Étape 8 — Automatiser le packaging

Créer un script :



notepad C:\\Sources\\auto-package.ps1

Coller :

$apps = Get-ChildItem "C:\\Sources" -Directory

foreach ($app in $apps) {

&#x20;   if (Test-Path "$($app.FullName)\\install\\install.ps1") {

&#x20;       IntuneWinAppUtil.exe -c $app.FullName -s "install\\install.ps1" -o "C:\\Packages"

&#x20;   }

}

10\. Résultat attendu

À la fin du lab, tu dois avoir :



Un package Win32 complet et fonctionnel.



Une installation silencieuse.



Une désinstallation propre.



Une règle de détection fiable.



Des logs IME analysés.



Un script d’automatisation opérationnel.



11\. Prochain module

Module 6 — Updates \& Security (WUfB, Baselines, Defender)  

Nous allons créer :



docs/06-updates-security.md



labs/06-updates-security.md



