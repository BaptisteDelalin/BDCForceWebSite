# 🔍 Comment Trouver ou Créer le Code Source Next.js

Ce guide vous aide à localiser le code source Next.js de votre site BDCForce, ou à créer un nouveau projet si le code source n'existe plus.

## 🔎 Où Chercher le Code Source

### 1. Vérifier les Dossiers Communs

Le code source Next.js pourrait être dans :

```bash
# Vérifier dans Documents
~/Documents/BDCForce/
~/Documents/bdcforce-nextjs/
~/Documents/www.bdcforce.fr-source/

# Vérifier dans le dossier parent
~/Documents/GitHub/bdcforce-source/
~/Documents/GitHub/BDCForce-nextjs/

# Vérifier dans d'autres emplacements
~/Projects/bdcforce/
~/Dev/bdcforce/
```

### 2. Rechercher avec la Commande Find

Ouvrez un terminal et exécutez :

```bash
# Chercher package.json avec Next.js
find ~/Documents -name "package.json" -exec grep -l "next" {} \; 2>/dev/null

# Chercher next.config
find ~/Documents -name "next.config.*" 2>/dev/null

# Chercher des dossiers app/ ou pages/
find ~/Documents -type d -name "app" -o -name "pages" 2>/dev/null | grep -v node_modules
```

### 3. Vérifier les Dépôts GitHub

Le code source pourrait être dans un autre dépôt GitHub :
- https://github.com/BaptisteDelalin/BDCForce-nextjs
- https://github.com/BaptisteDelalin/bdcforce-source
- Ou un autre dépôt privé

### 4. Vérifier les Services Cloud

Si vous utilisez Vercel, Netlify, ou un autre service :
- Vérifier votre compte Vercel/Netlify
- Le code source pourrait être lié à un dépôt Git

## 🆕 Solution Alternative : Modifier les Fichiers HTML Statiques

Si vous ne trouvez pas le code source Next.js, vous pouvez modifier directement les fichiers HTML statiques. **Attention :** Ces modifications seront perdues au prochain build, mais c'est une solution temporaire.

### Modifier index.html directement

Je peux vous aider à modifier directement le fichier `index.html` pour :
1. Supprimer le bouton "Prenez rendez-vous"
2. Garder le formulaire
3. Centrer le formulaire

**Souhaitez-vous que je modifie directement le fichier `index.html` ?**

## 🛠️ Créer un Nouveau Projet Next.js (Si le code source n'existe plus)

Si le code source n'existe plus, voici comment créer un nouveau projet :

### Étape 1 : Créer un nouveau projet Next.js

```bash
npx create-next-app@latest bdcforce-source --typescript --tailwind --app
cd bdcforce-source
```

### Étape 2 : Copier les assets

```bash
# Copier les images
cp -r /Users/delalinbaptiste/Documents/GitHub/www.bdcforce.fr/img ./public/img

# Copier les autres assets
cp -r /Users/delalinbaptiste/Documents/GitHub/www.bdcforce.fr/audio ./public/audio
cp /Users/delalinbaptiste/Documents/GitHub/www.bdcforce.fr/favicon.ico ./public/
```

### Étape 3 : Recréer les composants

Créer les composants basés sur le HTML actuel.

## 💡 Solution Recommandée

**Option 1 : Modifier directement index.html (Rapide mais temporaire)**
- Je peux modifier le fichier HTML statique maintenant
- Les changements seront visibles immédiatement
- Mais seront perdus au prochain build Next.js

**Option 2 : Trouver le code source (Durable)**
- Chercher le code source Next.js
- Modifier le code source
- Rebuild et redéployer

**Option 3 : Créer un nouveau projet (Si le code source n'existe plus)**
- Créer un nouveau projet Next.js
- Recréer les composants
- Configurer EmailJS

## ❓ Questions pour Vous

1. **Avez-vous un autre dossier ou dépôt avec le code source Next.js ?**
2. **Utilisez-vous Vercel, Netlify, ou un autre service de déploiement ?**
3. **Souhaitez-vous que je modifie directement le fichier `index.html` maintenant ?** (solution temporaire mais immédiate)

---

**En attendant, je peux modifier directement le fichier `index.html` pour retirer le bouton Calendly et centrer le formulaire. Voulez-vous que je le fasse ?**

