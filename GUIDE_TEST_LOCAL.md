# 🧪 Guide de Test Local - BDCForce

Ce guide vous explique comment tester le site BDCForce en local avant de le déployer sur OVH.

## 🚀 Démarrage Rapide

### Option 1 : Serveur Local Simple (Recommandé)

```bash
# Lancer le serveur local sur le port 8000
./serve-local.sh

# Ou spécifier un port différent
./serve-local.sh 3000
```

Puis ouvrez votre navigateur sur : **http://localhost:8000**

### Option 2 : Avec Python directement

```bash
# Python 3
python3 -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

### Option 3 : Avec PHP

```bash
php -S localhost:8000
```

### Option 4 : Avec Node.js (si installé)

```bash
npx http-server -p 8000
```

## ✅ Tests Automatiques

### Test Complet (Python)

Le script `test-complet.py` vérifie automatiquement :
- ✅ Présence des fichiers essentiels
- ✅ Validité des fichiers de configuration
- ✅ Structure HTML
- ✅ Présence des images
- ✅ Validité des liens internes
- ✅ Métadonnées SEO

```bash
# Exécuter tous les tests
python3 test-complet.py

# Ou avec chemin spécifique
python3 test-complet.py /chemin/vers/site
```

### Test Rapide (Bash)

Le script `test-site.sh` effectue des vérifications de base :

```bash
# Rendre exécutable (si nécessaire)
chmod +x test-site.sh

# Exécuter
./test-site.sh
```

## 📋 Checklist de Test Manuel

### 1. Navigation
- [ ] Le menu de navigation fonctionne
- [ ] Les liens vers les sections (#services, #contact, etc.) fonctionnent
- [ ] Le scroll smooth fonctionne
- [ ] Le menu mobile fonctionne (si applicable)

### 2. Contenu
- [ ] Toutes les images se chargent correctement
- [ ] Les textes sont lisibles et sans erreurs
- [ ] Les sections sont bien structurées
- [ ] Les témoignages s'affichent correctement

### 3. Formulaire de Contact
- [ ] Le formulaire s'affiche correctement
- [ ] Les champs sont accessibles
- [ ] La validation fonctionne (à implémenter)
- [ ] Le lien Google Calendar fonctionne

### 4. Liens Externes
- [ ] Les liens LinkedIn fonctionnent
- [ ] Le lien Twitter fonctionne (si présent)
- [ ] Le lien Google Calendar fonctionne

### 5. Responsive Design
- [ ] Tester sur mobile (Chrome DevTools)
- [ ] Tester sur tablette
- [ ] Tester sur desktop
- [ ] Vérifier que le menu mobile fonctionne

### 6. Performance
- [ ] Les images se chargent rapidement
- [ ] Pas d'erreurs dans la console (F12)
- [ ] Le site est fluide

### 7. SEO
- [ ] Vérifier les métadonnées (View Source)
- [ ] Vérifier les données structurées JSON-LD
- [ ] Vérifier que le sitemap.xml est accessible
- [ ] Vérifier que le robots.txt est accessible

## 🔍 Tests avec Chrome DevTools

### 1. Test Responsive

1. Ouvrir Chrome DevTools (F12)
2. Cliquer sur l'icône de device (Ctrl+Shift+M)
3. Tester différentes tailles :
   - Mobile (375px, 414px)
   - Tablet (768px, 1024px)
   - Desktop (1920px)

### 2. Test de Performance

1. Ouvrir Chrome DevTools (F12)
2. Aller dans l'onglet "Lighthouse"
3. Sélectionner :
   - Performance
   - Accessibility
   - Best Practices
   - SEO
4. Cliquer sur "Generate report"

**Objectifs :**
- Performance : > 90
- Accessibility : > 90
- Best Practices : > 90
- SEO : > 90

### 3. Test de Console

1. Ouvrir Chrome DevTools (F12)
2. Aller dans l'onglet "Console"
3. Vérifier qu'il n'y a pas d'erreurs en rouge
4. Vérifier les avertissements

### 4. Test de Réseau

1. Ouvrir Chrome DevTools (F12)
2. Aller dans l'onglet "Network"
3. Recharger la page (F5)
4. Vérifier :
   - Temps de chargement total
   - Taille des fichiers
   - Erreurs 404

## 🐛 Résolution de Problèmes

### Problème : Les images ne se chargent pas

**Solution :**
- Vérifier que les chemins sont corrects (relatifs ou absolus)
- Vérifier que les images existent dans le dossier `img/`
- Vérifier les permissions des fichiers

### Problème : Le CSS ne s'applique pas

**Solution :**
- Vérifier que les fichiers CSS sont bien chargés (Network tab)
- Vérifier les chemins vers les fichiers CSS
- Vider le cache du navigateur (Ctrl+Shift+R)

### Problème : Les liens ne fonctionnent pas

**Solution :**
- Vérifier que les sections existent dans le HTML
- Vérifier les IDs des sections
- Tester avec le serveur local (pas en ouvrant directement le fichier)

### Problème : Le serveur local ne démarre pas

**Solution :**
- Vérifier que le port n'est pas déjà utilisé
- Essayer un autre port : `./serve-local.sh 3000`
- Vérifier que Python/PHP est installé

## 📊 Résultats des Tests Automatiques

Dernière exécution : **Tous les tests sont passés ✅**

- ✅ Fichiers essentiels : 6/6
- ✅ Configuration : 5/5
- ✅ Structure HTML : 7/7 sections
- ✅ Images : Toutes présentes
- ✅ Liens internes : Tous valides
- ✅ Métadonnées : Présentes

**Total : 68 tests réussis, 0 erreur, 0 avertissement**

## 🚀 Après les Tests

Une fois tous les tests passés :

1. ✅ Vérifier que tout fonctionne en local
2. ✅ Commit les changements (si nécessaire)
3. ✅ Déployer sur OVH (voir `DEPLOIEMENT_OVH.md`)
4. ✅ Tester en production
5. ✅ Vérifier avec PageSpeed Insights

## 📝 Notes

- ⚠️ **Toujours tester en local avant de déployer**
- ⚠️ **Vérifier sur plusieurs navigateurs** (Chrome, Firefox, Safari, Edge)
- ⚠️ **Tester sur mobile réel** si possible
- ⚠️ **Vérifier les performances** avec Lighthouse

---

**Dernière mise à jour :** 2025-01-16

