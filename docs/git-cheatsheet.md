\# 🧾 Git Cheat Sheet — Commandes essentielles



Ce mémo regroupe les commandes Git indispensables pour gérer ton dépôt Modern Workplace.



\---



\## 🔵 1. Ajouter des fichiers



| Action | Commande |

|--------|----------|

| Ajouter un fichier précis | `git add nom\_du\_fichier` |

| Ajouter un dossier complet | `git add dossier/` |

| Ajouter tous les fichiers modifiés | `git add .` |



\---



\## 🟢 2. Enregistrer les changements (commit)



| Action | Commande |

|--------|----------|

| Créer un commit | `git commit -m "Message clair"` |

| Modifier le dernier commit (avant push) | `git commit --amend` |



\---



\## 🟦 3. Envoyer sur GitHub (push)



| Action | Commande |

|--------|----------|

| Envoyer les commits | `git push` |

| Premier push d’un dépôt | `git push -u origin main` |



\---



\## 🟣 4. Récupérer les changements (pull)



| Action | Commande |

|--------|----------|

| Mettre à jour ton dépôt local | `git pull` |



\---



\## 🟠 5. Vérifier l’état du dépôt



| Action | Commande |

|--------|----------|

| Voir les fichiers modifiés | `git status` |

| Voir l’historique des commits | `git log` |



\---



\## 🟤 6. Annuler / corriger



| Action | Commande |

|--------|----------|

| Annuler un fichier modifié (avant add) | `git checkout -- nom\_du\_fichier` |

| Retirer un fichier du staging (après add) | `git reset nom\_du\_fichier` |

| Annuler le dernier commit (sans perdre les fichiers) | `git reset --soft HEAD\~1` |



\---



\## 🎯 Résumé ultra-simple



À chaque modification :





