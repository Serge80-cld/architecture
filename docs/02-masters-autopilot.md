\# Conception des Masters Modernes \& Autopilot



\## 1. Objectifs

\- Éliminer les images lourdes (WIM).

\- Standardiser le provisioning via Autopilot.

\- Réduire le time-to-serve.

\- Supporter les scénarios : machine neuve, réaffectation, break/fix.



\## 2. Types de déploiement

\- \*\*User-driven Autopilot\*\*

\- \*\*Self-deploying mode\*\*

\- \*\*Pre-provisioning (anciennement WhiteGlove)\*\*



\## 3. Composants clés

\- Profil Autopilot

\- ESP (Enrollment Status Page)

\- Group Tags

\- Dynamic Groups

\- Applications Win32

\- Policies Intune



\## 4. Flux de provisioning

1\. Import du hash

2\. Assignation du profil

3\. OOBE → Entra ID Join

4\. Enrollment Intune

5\. Application des policies

6\. Installation des apps

7\. Compliance



\## 5. Bonnes pratiques

\- Minimiser les apps dans ESP

\- Utiliser des groupes dynamiques

\- Standardiser les scripts d’import

\- Tester sur un ring pilote



