\# Lab 02 – Déploiement Autopilot



\## Objectifs

\- Importer un device dans Autopilot

\- Créer un profil Autopilot

\- Déployer un poste via OOBE



\## Étapes

1\. Récupérer le hash du device :

Get-WindowsAutopilotInfo -OutputFile device.csv

2\. Importer dans Intune

3\. Créer un profil Autopilot

4\. Assigner le profil

5\. Démarrer le device → OOBE

6\. Vérifier l’enrollment Intune



\## Validation

\- Device visible dans Autopilot

\- Profil appliqué

\- ESP passe au vert



