# 🌐 BDCForce - Site Web

Site web de BDCForce, expert Salesforce à Lille, spécialisé dans la transformation digitale et l'implémentation de solutions CRM.

## 📋 Vue d'ensemble

Ce dépôt contient les fichiers statiques du site web BDCForce, générés depuis une application Next.js.

## 🚀 Démarrage Rapide

### Prérequis
- Compte OVH avec accès FTP/SSH
- Git installé (pour la gestion de version)

### Déploiement
Consultez le guide complet : [DEPLOIEMENT_OVH.md](./DEPLOIEMENT_OVH.md)

### Optimisation des images
```bash
./optimize-images.sh
```

## 📁 Structure du Projet

```
www.bdcforce.fr/
├── .htaccess              # Configuration serveur (compression, cache, sécurité)
├── robots.txt             # Directives pour les robots d'indexation
├── sitemap.xml            # Plan du site pour le SEO
├── manifest.json          # Configuration PWA
├── structured-data.json   # Données structurées JSON-LD
├── index.html             # Page d'accueil
├── img/                   # Images du site
├── audio/                 # Fichiers audio
├── cyberpunk/             # Page expérimentale (non indexée)
├── optimize-images.sh     # Script d'optimisation d'images
├── DEPLOIEMENT_OVH.md     # Guide de déploiement
├── CHECKLIST_MAINTENANCE.md # Checklist de maintenance
├── AMELIORATIONS.md       # Liste des améliorations apportées
└── form-contact-example.html # Exemple de formulaire amélioré
```

## ✨ Améliorations Apportées

Consultez [AMELIORATIONS.md](./AMELIORATIONS.md) pour la liste complète des améliorations.

### Principales améliorations :
- ✅ Configuration .htaccess optimisée (compression, cache, sécurité)
- ✅ Sitemap.xml et robots.txt optimisés
- ✅ Support PWA (manifest.json)
- ✅ Données structurées JSON-LD améliorées
- ✅ Script d'optimisation d'images
- ✅ Guides de déploiement et maintenance

## 🔧 Maintenance

Consultez [CHECKLIST_MAINTENANCE.md](./CHECKLIST_MAINTENANCE.md) pour la checklist complète.

### Maintenance hebdomadaire
- Vérifier les liens et formulaires
- Vérifier les performances
- Vérifier les erreurs dans Google Search Console

### Maintenance mensuelle
- Audit SEO
- Vérification sécurité
- Optimisation images
- Mise à jour contenu

## 📊 Performance

### Objectifs
- Temps de chargement : < 2 secondes
- Score Lighthouse : > 90
- Score SecurityHeaders : A+

### Outils de test
- [PageSpeed Insights](https://pagespeed.web.dev/)
- [GTmetrix](https://gtmetrix.com/)
- [SecurityHeaders.com](https://securityheaders.com/)

## 🔒 Sécurité

### Headers de sécurité configurés
- X-XSS-Protection
- X-Content-Type-Options
- X-Frame-Options
- Referrer-Policy
- Permissions-Policy
- Strict-Transport-Security (HSTS)

### Protection
- Redirection HTTPS forcée
- Protection des fichiers sensibles
- Honeypot pour les formulaires (à implémenter)

## 📈 SEO

### Optimisations
- Sitemap.xml optimisé
- Robots.txt configuré
- Données structurées JSON-LD
- Métadonnées Open Graph et Twitter Cards

### Outils
- [Google Search Console](https://search.google.com/search-console)
- [Google Rich Results Test](https://search.google.com/test/rich-results)

## 🛠️ Technologies

- **Framework** : Next.js (export statique)
- **Hébergement** : OVH
- **Version Control** : Git / GitHub

## 📝 Notes Importantes

⚠️ **Le code source Next.js n'est pas dans ce dépôt**  
Ce dépôt contient uniquement les fichiers statiques générés. Les modifications du code source doivent être faites dans le projet Next.js source.

⚠️ **Ne jamais uploader le dossier `_next/`**  
Ce dossier contient les fichiers de build et ne doit pas être versionné ni uploadé sur OVH.

## 📞 Support

- **GitHub** : https://github.com/BaptisteDelalin/BDCForceWebSite
- **Site web** : https://www.bdcforce.fr
- **Email** : baptiste.delalin@bdcforce.fr

## 📄 Licence

Tous droits réservés © 2025 BDCForce

---

**Dernière mise à jour** : 2025-01-16

