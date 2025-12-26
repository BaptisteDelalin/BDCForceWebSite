# 🚀 Guide de Déploiement OVH - BDCForce

Ce guide vous explique comment déployer votre site BDCForce sur OVH après les modifications.

## 📋 Prérequis

- Compte OVH avec accès FTP/SSH
- Accès au panneau de contrôle OVH
- Git installé localement
- Accès SSH ou FTP configuré

## 🔧 Méthodes de Déploiement

### Méthode 1 : Déploiement via FTP (Recommandé pour débutants)

#### Étape 1 : Préparer les fichiers

```bash
# Dans le répertoire du projet
cd /Users/delalinbaptiste/Documents/GitHub/www.bdcforce.fr

# Vérifier que tous les fichiers sont à jour
git status

# S'assurer que le dossier _next/ est exclu (déjà dans .gitignore)
```

#### Étape 2 : Se connecter via FTP

1. **Via FileZilla ou Cyberduck :**
   - Hôte : `ftp.cluster0XX.hosting.ovh.net` (remplacer XX par votre numéro)
   - Utilisateur : Votre identifiant FTP OVH
   - Mot de passe : Votre mot de passe FTP
   - Port : 21 (FTP) ou 22 (SFTP)

2. **Via ligne de commande :**
```bash
# Installer lftp si nécessaire
brew install lftp  # macOS
# ou
sudo apt-get install lftp  # Linux

# Se connecter
lftp -u VOTRE_USER,VOTRE_PASSWORD ftp.cluster0XX.hosting.ovh.net

# Dans lftp
cd www  # ou le dossier de votre site
mirror -R --delete --verbose . /www/
```

#### Étape 3 : Uploader les fichiers

- Uploader tous les fichiers **SAUF** le dossier `_next/` (fichiers de build Next.js)
- Vérifier que `.htaccess` est bien uploadé
- Vérifier que `manifest.json` est bien uploadé
- Vérifier que `robots.txt` et `sitemap.xml` sont bien uploadés

### Méthode 2 : Déploiement via Git (Recommandé pour développeurs)

#### Étape 1 : Configurer Git sur OVH

1. **Créer un dépôt Git sur OVH :**
   - Se connecter à l'espace client OVH
   - Aller dans "Hébergement" > "Git"
   - Créer un nouveau dépôt Git

2. **Configurer le hook de déploiement :**
   - Créer un fichier `post-receive` dans `.git/hooks/` sur le serveur OVH
   - Contenu du hook :
```bash
#!/bin/bash
cd /homez.XXX/votrecompte/www  # Adapter le chemin
git --git-dir=.git --work-tree=. checkout -f
```

#### Étape 2 : Pousser depuis votre machine

```bash
# Ajouter le remote OVH
git remote add ovh ssh://votrecompte@cluster0XX.ovh.net:/homez.XXX/votrecompte/git/repo.git

# Pousser vers OVH
git push ovh main
```

### Méthode 3 : Déploiement via SSH (Avancé)

```bash
# Se connecter en SSH
ssh votrecompte@cluster0XX.ovh.net

# Naviguer vers le dossier www
cd www

# Cloner ou pull depuis GitHub
git clone https://github.com/BaptisteDelalin/BDCForceWebSite.git .
# ou
git pull origin main
```

## ✅ Checklist Post-Déploiement

### Vérifications Essentielles

- [ ] Le site est accessible via HTTPS
- [ ] Le fichier `.htaccess` est bien présent et fonctionne
- [ ] Les redirections HTTPS fonctionnent
- [ ] Le `sitemap.xml` est accessible : `https://www.bdcforce.fr/sitemap.xml`
- [ ] Le `robots.txt` est accessible : `https://www.bdcforce.fr/robots.txt`
- [ ] Le `manifest.json` est accessible : `https://www.bdcforce.fr/manifest.json`
- [ ] Les images se chargent correctement
- [ ] Le formulaire de contact fonctionne (si implémenté)
- [ ] Les pages 404 fonctionnent

### Tests de Performance

- [ ] Tester avec [PageSpeed Insights](https://pagespeed.web.dev/)
- [ ] Tester avec [GTmetrix](https://gtmetrix.com/)
- [ ] Vérifier le score Lighthouse (objectif : > 90)
- [ ] Vérifier le temps de chargement (objectif : < 2s)

### Tests SEO

- [ ] Soumettre le sitemap à Google Search Console
- [ ] Soumettre le sitemap à Bing Webmaster Tools
- [ ] Vérifier les données structurées avec [Google Rich Results Test](https://search.google.com/test/rich-results)
- [ ] Vérifier les métadonnées avec [Facebook Sharing Debugger](https://developers.facebook.com/tools/debug/)

### Tests de Sécurité

- [ ] Vérifier les headers de sécurité avec [SecurityHeaders.com](https://securityheaders.com/)
- [ ] Vérifier le certificat SSL avec [SSL Labs](https://www.ssllabs.com/ssltest/)
- [ ] Tester la protection XSS
- [ ] Vérifier que les fichiers sensibles ne sont pas accessibles

## 🔄 Mise à Jour Régulière

### Processus de mise à jour

1. **Faire les modifications localement**
2. **Tester en local**
3. **Commit et push vers GitHub**
```bash
git add .
git commit -m "Description des modifications"
git push origin main
```
4. **Déployer sur OVH** (selon la méthode choisie)
5. **Vérifier le site en production**

### Automatisation (Optionnel)

Créer un script de déploiement automatique :

```bash
#!/bin/bash
# deploy.sh

echo "🚀 Déploiement BDCForce sur OVH..."

# Build (si nécessaire)
# npm run build

# Push vers GitHub
git add .
git commit -m "Auto-deploy: $(date)"
git push origin main

# Déployer sur OVH via FTP
lftp -u $OVH_USER,$OVH_PASSWORD ftp.cluster0XX.hosting.ovh.net <<EOF
cd www
mirror -R --delete --exclude _next/ --exclude .git/ .
quit
EOF

echo "✅ Déploiement terminé !"
```

## 🐛 Résolution de Problèmes

### Problème : Le site ne se charge pas

- Vérifier que les fichiers sont bien dans le dossier `www/`
- Vérifier les permissions des fichiers (644 pour les fichiers, 755 pour les dossiers)
- Vérifier les logs d'erreur dans le panneau OVH

### Problème : Le .htaccess ne fonctionne pas

- Vérifier que le module `mod_rewrite` est activé sur OVH
- Vérifier la syntaxe du `.htaccess`
- Contacter le support OVH si nécessaire

### Problème : Les images ne se chargent pas

- Vérifier les chemins relatifs/absolus
- Vérifier les permissions des fichiers images
- Vérifier que les images sont bien uploadées

### Problème : HTTPS ne fonctionne pas

- Vérifier que le certificat SSL est activé dans le panneau OVH
- Vérifier la configuration du `.htaccess`
- Vérifier les redirections

## 📞 Support

- **Documentation OVH :** https://docs.ovh.com/
- **Support OVH :** Via l'espace client
- **GitHub du projet :** https://github.com/BaptisteDelalin/BDCForceWebSite

## 📝 Notes Importantes

- ⚠️ **Ne jamais uploader** le dossier `_next/` (fichiers de build)
- ⚠️ **Ne jamais uploader** le dossier `.git/`
- ⚠️ **Toujours tester** en local avant de déployer
- ⚠️ **Sauvegarder** avant chaque déploiement important
- ✅ **Utiliser HTTPS** pour toutes les connexions
- ✅ **Vérifier** les performances après chaque déploiement

