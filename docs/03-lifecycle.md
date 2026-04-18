\# Module 3 — Lifecycle Management (Windows \& macOS)



\##  Objectifs du module

\- Comprendre le cycle de vie complet d’un device moderne.

\- Gérer la conformité, la configuration et la sécurité.

\- Maîtriser les actions de retrait, réaffectation et offboarding.

\- Standardiser les processus pour réduire les coûts opérationnels.



\---



\## 1. Les 6 états d’un device dans un environnement Modern Workplace



\### \*\*1. Enrolled\*\*

Le device est enregistré dans Intune et visible dans Entra ID.



\### \*\*2. Compliant / Non-compliant\*\*

Basé sur les règles de conformité :

\- Chiffrement

\- Antivirus

\- Firewall

\- OS version

\- Secure Boot



\### \*\*3. Configured\*\*

Policies appliquées :

\- Wi-Fi

\- VPN

\- Certificats

\- Restrictions

\- Baselines de sécurité



\### \*\*4. Managed\*\*

Le device reçoit :

\- Apps Win32

\- Scripts PowerShell

\- Updates Windows

\- Policies de sécurité



\### \*\*5. Retire\*\*

Suppression du MDM sans effacer les données utilisateur.



\### \*\*6. Wipe\*\*

Réinitialisation complète du device (factory reset).



\---



\## 2. Les règles de conformité (Compliance Policies)



\### Objectifs

\- Garantir un niveau minimal de sécurité.

\- Bloquer l’accès aux ressources si le device n’est pas conforme.

\- Alimenter Conditional Access.



\### Exemples de règles

\- \*\*BitLocker activé\*\*

\- \*\*Antivirus actif\*\*

\- \*\*Firewall activé\*\*

\- \*\*OS ≥ Windows 10 22H2\*\*

\- \*\*Secure Boot activé\*\*



\### Bonnes pratiques

\- Créer plusieurs niveaux de conformité (Baseline, Standard, Renforcé).

\- Utiliser des groupes dynamiques par OS.

\- Activer les notifications utilisateur.



\---



\## 3. Configuration Profiles (Windows \& macOS)



\### Types de profils

\- \*\*Settings Catalog\*\* (recommandé)

\- \*\*Templates\*\*

\- \*\*Custom (OMA-URI)\*\*



\### Exemples de configurations

\- Wi-Fi entreprise

\- VPN

\- Certificats SCEP

\- Restrictions Windows

\- FileVault (macOS)

\- Firewall

\- Password policies



\### Bonnes pratiques

\- Un profil = un objectif  

\- Éviter les profils “fourre-tout”

\- Documenter chaque profil dans GitHub



\---



\## 4. Gestion des applications



\### Types d’apps

\- Win32 (.intunewin)

\- Microsoft Store

\- LOB apps

\- Web apps



\### Points clés

\- Détection obligatoire pour Win32

\- Logs dans `C:\\ProgramData\\Microsoft\\IntuneManagementExtension\\Logs`

\- Déploiement par groupes dynamiques



\---



\## 5. Offboarding \& Réaffectation



\### \*\*Retire\*\*

\- Supprime la gestion MDM

\- Laisse les données utilisateur

\- Idéal pour départ d’un collaborateur



\### \*\*Wipe\*\*

\- Réinitialisation complète

\- Idéal pour réaffectation ou perte



\### \*\*Fresh Start\*\*

\- Réinstalle Windows sans toucher aux données

\- Nettoie les bloatwares OEM



\### \*\*Delete\*\*

\- Supprime le device d’Intune

\- À faire uniquement après Retire/Wipe



\---



\## 6. Automatisation du cycle de vie



\### Scripts utiles

\- Nettoyage automatique des devices inactifs

\- Réaffectation automatisée

\- Vérification de conformité

\- Rotation des certificats



\### Exemple : supprimer les devices inactifs depuis 90 jours

```powershell

Get-IntuneManagedDevice | 

Where-Object { $\_.lastSyncDateTime -lt (Get-Date).AddDays(-90) } |

Remove-IntuneManagedDevice

7\. Bonnes pratiques grand compte

Utiliser des rings (Pilote → Standard → VIP).



Documenter chaque action dans GitHub.



Automatiser le nettoyage des devices obsolètes.



Utiliser Conditional Access basé sur la conformité.



Séparer les policies Windows et macOS.



Tester chaque profil dans un groupe pilote.

8\. Résultat attendu

À la fin du module, tu maîtrises :



La conformité



La configuration



Le cycle de vie complet



Le retrait / réaffectation



Les bonnes pratiques de sécurité

9\. Prochain module

Module 4 — Co-management (MECM + Intune)  

Nous allons créer :



docs/04-co-management.md



labs/04-co-management.md



C



