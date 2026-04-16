\# Architecture Modern Workplace – Bootcamp Ingénieur Workplace



\## 1. Contexte et enjeux



Les usages ont basculé vers un modèle :

\- Utilisateurs distribués (télétravail, mobilité, prestataires).

\- Postes hétérogènes (Windows, macOS, BYOD parfois).

\- Exposition massive aux risques (ransomware, fuite de données, shadow IT).



L’objectif de cette architecture est de définir une \*\*plateforme de gestion des terminaux moderne et hybride\*\*, capable de :

\- Gérer le cycle de vie complet des postes (onboarding → exploitation → maintenance → offboarding).

\- Supporter la \*\*coexistence MECM/SCCM + Intune\*\*.

\- Appliquer des \*\*contrôles de sécurité Zero Trust\*\* sans dégrader l’expérience utilisateur.



Ce document sert de \*\*référence d’architecture\*\* pour le bootcamp et pour les labs associés.



\---



\## 2. Objectifs d’architecture



\*\*Objectifs techniques :\*\*

\- Unifier la gestion des terminaux Windows et macOS via MDM (Intune) et MECM.

\- Standardiser le poste de travail (version OS, configuration, sécurité).

\- Industrialiser le déploiement (Autopilot, séquences MECM, profils MDM).

\- Centraliser la gestion des mises à jour et correctifs de sécurité.



\*\*Objectifs métier :\*\*

\- Réduire le time-to-serve d’un nouveau collaborateur.

\- Réduire les incidents liés au poste de travail (config, patch, applicatif).

\- Améliorer la posture de sécurité (chiffrement, durcissement, conformité).

\- Donner de la visibilité au management (indicateurs de conformité, patching, vulnérabilités).



\---



\## 3. Périmètre et hypothèses



\*\*Périmètre :\*\*

\- Postes \*\*Windows 10/11\*\* et \*\*macOS\*\* d’entreprise.

\- Environnement \*\*hybride\*\* : AD DS on-prem + Microsoft Entra ID.

\- Outils de gestion :

&#x20; - \*\*Microsoft Intune\*\* (MDM/MAM, compliance, configuration, apps, updates).

&#x20; - \*\*MECM/SCCM\*\* (applications, OS, updates, reporting, CMG éventuel).

\- Services de sécurité Microsoft 365 (Defender, Conditional Access, baselines).



\*\*Hors périmètre (pour ce bootcamp) :\*\*

\- Gestion détaillée des mobiles (iOS/Android).

\- Intégration profonde avec SIEM/SOAR.

\- Scénarios multi-tenant complexes.



\*\*Hypothèses :\*\*

\- Licences M365 E3/E5 ou équivalent (Intune, Entra ID P1/P2).

\- AD DS existant, synchronisé avec Entra ID.

\- Accès Internet des postes aux endpoints Microsoft (Intune, Autopilot, WUfB, etc.).



\---



\## 4. Principes de design



\*\*4.1 Identity-first \& Zero Trust\*\*



\- L’\*\*identité\*\* (utilisateur + device) est le point de contrôle principal.

\- Accès conditionnel basé sur :

&#x20; - Identité (MFA, risque).

&#x20; - Conformité du device.

&#x20; - Localisation / contexte.



\*\*4.2 Cloud-first, hybride pragmatique\*\*



\- Intune est la \*\*cible\*\* pour la gestion moderne.

\- MECM est conservé pour :

&#x20; - Scénarios on-prem lourds.

&#x20; - Migration progressive (co-management).

\- Coexistence organisée, pas de “double pilotage sauvage”.



\*\*4.3 Standardisation \& industrialisation\*\*



\- Standards OS (versions supportées, build cible).

\- Standards de configuration (profils, baselines).

\- Standards de packaging (naming, détection, logs).

\- Automatisation via scripts (PowerShell) et pipelines là où pertinent.



\*\*4.4 Sécurité by design\*\*



\- Chiffrement systématique (BitLocker / FileVault).

\- Durcissement via baselines de sécurité.

\- Gestion centralisée des mises à jour et correctifs.

\- Principe du moindre privilège (RBAC, scopes Intune/MECM).



\---



\## 5. Architecture cible



\### 5.1 Composants principaux



\*\*On-premises :\*\*

\- AD DS (domain controllers, DNS).

\- MECM/SCCM (site server, DB, distribution points, éventuellement CMG).

\- PKI interne (si nécessaire pour certifs Wi-Fi/VPN).



\*\*Cloud :\*\*

\- Microsoft Entra ID (identités, Conditional Access).

\- Intune (MDM/MAM, policies, apps, updates).

\- Autopilot (enrôlement et provisioning).

\- Defender (AV, EDR, vulnérabilités).



\### 5.2 Vue logique



\- \*\*Plan identité :\*\*

&#x20; - Utilisateurs et devices synchronisés AD → Entra ID.

&#x20; - Devices en \*\*Hybrid Join\*\* ou \*\*Entra Join\*\* selon scénario.

\- \*\*Plan gestion :\*\*

&#x20; - Devices Windows co-gérés (MECM + Intune) ou full Intune.

&#x20; - Devices macOS gérés via Intune.

\- \*\*Plan sécurité :\*\*

&#x20; - Conditional Access sur les apps cloud.

&#x20; - Compliance policies comme prérequis d’accès.

&#x20; - Baselines de sécurité appliquées par OS.



\*(Un diagramme logique sera ajouté dans `diagrams/architecture.mmd`.)\*



\---



\## 6. Flux clés



\*\*6.1 Onboarding d’un poste Windows\*\*



1\. Achat / préparation du device (OEM ou réaffectation).

2\. Enregistrement dans Autopilot (hash, group tag).

3\. Utilisateur démarre le poste → OOBE → Entra ID + Autopilot.

4\. Enrôlement Intune, application des profils (config, compliance, apps).

5\. Si co-management : client MECM présent ou déployé, workloads basculés progressivement.



\*\*6.2 Onboarding d’un poste macOS\*\*



1\. Enregistrement dans Intune (Apple Business Manager si dispo).

2\. Enrôlement MDM, application des profils (FileVault, Wi-Fi, VPN, apps).

3\. Application des politiques de conformité et de sécurité.



\*\*6.3 Gestion des mises à jour\*\*



\- Windows : Windows Update for Business (rings) + éventuellement MECM Software Updates.

\- macOS : policies Intune + mécanismes natifs Apple.

\- Pilotage via groupes pilotes → élargissement progressif.



\*\*6.4 Offboarding\*\*



1\. Désactivation du compte utilisateur.

2\. Wipe/Retire du device via Intune.

3\. Réaffectation ou sortie de parc (effacement sécurisé).



\---



\## 7. Gouvernance et responsabilités



\*\*Rôles typiques :\*\*

\- \*\*Équipe Workplace / Endpoint\*\* : design, configuration Intune/MECM, packaging, patching.

\- \*\*Équipe Identité / AD / Entra\*\* : synchronisation, Conditional Access, RBAC.

\- \*\*Équipe Sécurité\*\* : baselines, durcissement, validation des politiques.

\- \*\*Équipe Réseau\*\* : proxy, accès aux endpoints cloud, QoS/DO.



Une matrice RACI simplifiée sera documentée dans `docs/01-architecture/raci.md`.



\---



\## 8. Roadmap de mise en œuvre (vue bootcamp)



\*\*Phase 0 – Préparation\*\*

\- Clarifier périmètre, licences, prérequis réseau.

\- Standardiser les versions OS cibles.



\*\*Phase 1 – Fondations\*\*

\- AD + Entra ID + synchronisation.

\- Intune configuré (RBAC, scopes, groupes).

\- MECM prêt pour co-management (si utilisé).



\*\*Phase 2 – Pilotes\*\*

\- Pilote Autopilot sur un petit périmètre.

\- Pilote co-management (workloads ciblés).

\- Pilote WUfB / updates.



\*\*Phase 3 – Généralisation\*\*

\- Extension progressive des workloads Intune.

\- Réduction de la dépendance MECM si c’est l’objectif.

\- Stabilisation, documentation, runbooks.



\---



\## 9. Lien avec les labs du bootcamp



Chaque module du bootcamp s’appuie sur cette architecture :



\- \*\*Module 1 – Architecture\*\* : ce document + diagrammes.

\- \*\*Module 2 – Masters modernes \& Autopilot\*\* : mise en œuvre de l’onboarding.

\- \*\*Module 3 – Cycle de vie des terminaux\*\* : onboarding/offboarding, compliance.

\- \*\*Module 4 – MDM, MECM, co-management\*\* : activation et pilotage des workloads.

\- \*\*Module 5 – Packaging applicatif\*\* : standardisation des apps.

\- \*\*Module 6 – Mises à jour \& sécurité\*\* : WUfB, MECM updates, baselines.



Ce README est la \*\*brique d’architecture de référence\*\* pour tout le bootcamp.



