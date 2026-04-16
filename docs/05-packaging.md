\# Module 5 — Packaging Applicatif (Win32, Détection, Logs, Automatisation)



\## 🎯 Objectifs du module

\- Comprendre le packaging moderne dans Intune.

\- Maîtriser le format .intunewin.

\- Créer des règles de détection professionnelles.

\- Gérer les logs d’installation via IME.

\- Automatiser le packaging et le déploiement.

\- Standardiser les applications pour un environnement grand compte.



\---



\## 1. Pourquoi le packaging Win32 ?



\### Limites des MSI / EXE classiques

\- Pas de gestion centralisée.

\- Pas de règles de détection.

\- Pas de logs standardisés.

\- Pas de mécanisme de retry.



\### Avantages du format Win32 (.intunewin)

\- Compression + encapsulation.

\- Détection personnalisée.

\- Désinstallation propre.

\- Logs centralisés via IME.

\- Support des scripts PowerShell.



\---



\## 2. IntuneWinAppUtil — L’outil officiel Microsoft



\### Télécharger l’outil

Disponible sur GitHub Microsoft.



\### Commande de conversion

IntuneWinAppUtil.exe -c "C:\\Sources\\App" -s setup.exe -o "C:\\Packages"



Paramètres :

\- `-c` : dossier source  

\- `-s` : fichier d’installation  

\- `-o` : dossier de sortie  



Résultat :

➡️ un fichier `.intunewin` prêt à être importé dans Intune.



\---



\## 3. Structure recommandée pour un package



AppName/

install/

setup.exe

install.ps1

uninstall/

uninstall.ps1

detection/

detection.ps1

README.md



\### Pourquoi cette structure ?

\- Standardisation

\- Automatisation possible

\- Documentation intégrée

\- Maintenance facilitée



\---



\## 4. Scripts d’installation (install.ps1)



Exemple professionnel :



```powershell

Start-Process ".\\setup.exe" -ArgumentList "/silent" -Wait -NoNewWindow

if (!(Test-Path "C:\\Program Files\\AppName")) {

&#x20;   Write-Error "Installation failed"

&#x20;   exit 1

}

exit 0

5\. Scripts de désinstallation (uninstall.ps1)

Start-Process "C:\\Program Files\\AppName\\uninstall.exe" -ArgumentList "/silent" -Wait

exit 0

6\. Règles de détection (Detection Rules)

3 types possibles :

Fichier



Clé de registre



Version



Script PowerShell



Exemple : détection via registre

HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\AppName

Exemple : détection via script

if (Test-Path "C:\\Program Files\\AppName\\App.exe") { exit 0 } else { exit 1 }

7\. Logs d’installation (IME Logs)

Chemin :

C:\\ProgramData\\Microsoft\\IntuneManagementExtension\\Logs

Fichiers clés :



IntuneManagementExtension.log



AgentExecutor.log



AppIntentEval.log



Analyse rapide

0x0 = succès



0x1 = échec script



0x80070005 = accès refusé



0x87D30067 = détection incorrecte



8\. Automatisation du packaging

Script PowerShell pour packager automatiquement

$apps = Get-ChildItem "C:\\Sources" -Directory

foreach ($app in $apps) {

&#x20;   IntuneWinAppUtil.exe -c $app.FullName -s "install.ps1" -o "C:\\Packages"

}

Avantages

Gain de temps



Standardisation



Réduction des erreurs humaines

9\. Bonnes pratiques grand compte

Toujours utiliser un script d’installation.



Toujours utiliser un script de détection.



Toujours documenter le package.



Tester dans un ring pilote.



Ne jamais déployer une app en Required sans test.



Utiliser des groupes dynamiques par OS / version.

10\. Prochain module

➡️ Module 6 — Updates \& Security (WUfB, Baselines, Defender)  

Nous allons créer :



docs/06-updates-security.md



labs/06-updates-security.md





