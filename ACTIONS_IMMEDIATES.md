# ⚡ Actions Immédiates - Modifications à Faire dans le Code Source Next.js

Ce document liste **exactement** ce qu'il faut modifier dans votre code source Next.js pour retirer le bouton de rendez-vous et configurer le formulaire.

## 🎯 Situation Actuelle

Dans le site actuel (fichiers statiques), il y a encore :
- ✅ Le formulaire de contact (à conserver mais configurer)
- ❌ Le bouton "Prenez rendez-vous" / Calendly (à SUPPRIMER)

## 📝 Modifications à Faire dans le Code Source Next.js

### 1. SUPPRIMER : Section "Prenez rendez-vous"

**Localisation :** Dans votre composant Contact (probablement `app/page.tsx` ou `pages/index.tsx`)

**Code à RETIRER complètement :**

```tsx
{/* ⚠️ SUPPRIMER TOUT CE BLOC */}
<div className="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
  <h3 className="text-2xl font-semibold text-gray-900 mb-6">Prenez rendez-vous</h3>
  <p className="text-gray-600 mb-8">Réservez un créneau de 30 minutes pour discuter de votre projet avec nos experts.</p>
  <a 
    href="https://calendly.com/bdcforce" 
    target="_blank" 
    rel="noopener noreferrer" 
    className="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
  >
    <i className="far fa-calendar-alt mr-2"></i>
    Planifier un appel
  </a>
</div>
```

### 2. CONSERVER : Formulaire de Contact (mais le configurer)

**Le formulaire doit être conservé** mais il faut :
1. Ajouter la fonctionnalité d'envoi d'email (voir `GUIDE_EMAILJS_SETUP.md`)
2. Ajouter la validation
3. Ajouter la protection anti-spam

### 3. MODIFIER : Structure de la grille

**Avant (2 colonnes) :**
```tsx
<div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
  {/* Colonne 1 : Prenez rendez-vous (À SUPPRIMER) */}
  {/* Colonne 2 : Formulaire de contact */}
</div>
```

**Après (1 colonne centrée) :**
```tsx
<div className="max-w-2xl mx-auto">
  {/* Formulaire de contact uniquement */}
</div>
```

## 🔍 Comment Trouver le Code dans Next.js

### Si vous utilisez App Router (Next.js 13+)

Le code se trouve probablement dans :
- `app/page.tsx` (page d'accueil)
- Ou dans un composant : `components/ContactSection.tsx`

### Si vous utilisez Pages Router

Le code se trouve probablement dans :
- `pages/index.tsx` (page d'accueil)
- Ou dans un composant : `components/ContactSection.tsx`

### Recherche dans le code source

Cherchez ces termes dans votre code source Next.js :
- `"Prenez rendez-vous"`
- `"Planifier un appel"`
- `calendly.com`
- `grid-cols-2` (pour la grille à 2 colonnes)

## 📋 Checklist Complète

### Étape 1 : Supprimer le bouton de rendez-vous
- [ ] Ouvrir le fichier du composant Contact dans Next.js
- [ ] Trouver la section "Prenez rendez-vous"
- [ ] Supprimer tout le bloc `<div>` contenant le bouton Calendly
- [ ] Supprimer la référence à `calendly.com`

### Étape 2 : Modifier la structure
- [ ] Changer `grid grid-cols-1 lg:grid-cols-2` en `max-w-2xl mx-auto`
- [ ] Centrer le formulaire de contact

### Étape 3 : Configurer le formulaire
- [ ] Suivre le guide `GUIDE_EMAILJS_SETUP.md`
- [ ] Installer EmailJS : `npm install @emailjs/browser`
- [ ] Créer le composant ContactForm avec envoi d'email
- [ ] Ajouter la validation
- [ ] Ajouter la protection anti-spam

### Étape 4 : Tester
- [ ] Tester en local : `npm run dev`
- [ ] Vérifier que le bouton Calendly a disparu
- [ ] Tester l'envoi du formulaire
- [ ] Vérifier la réception de l'email sur baptiste.delalin@outlook.com

## 🎨 Structure Finale Attendue

```tsx
<section id="contact" className="py-20 bg-white">
  <div className="container mx-auto px-4">
    <div className="text-center mb-16">
      <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
        Contactez-nous
      </h2>
      <p className="text-xl text-gray-600 max-w-2xl mx-auto">
        Discutons de votre projet et de vos besoins en transformation digitale
      </p>
    </div>
    
    {/* Formulaire centré - SANS la section "Prenez rendez-vous" */}
    <div className="max-w-2xl mx-auto">
      <div className="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
        <h3 className="text-2xl font-semibold text-gray-900 mb-6">
          Envoyez-nous un message
        </h3>
        <ContactForm /> {/* Composant avec EmailJS configuré */}
      </div>
    </div>
    
    {/* Informations de contact (garder cette section) */}
    <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-8">
      {/* Cartes avec adresse, téléphone, email */}
    </div>
  </div>
</section>
```

## ⚠️ Important

Les fichiers dans ce dépôt (`www.bdcforce.fr`) sont des **fichiers statiques générés** par Next.js. 

**Les modifications doivent être faites dans le code source Next.js**, pas dans ces fichiers statiques.

Après modification du code source :
1. Rebuild : `npm run build`
2. Les nouveaux fichiers statiques seront générés
3. Déployer sur OVH

## 📚 Guides de Référence

- **Supprimer le bouton Calendly** : `MODIFICATION_CONTACT.md`
- **Configurer l'envoi d'email** : `GUIDE_EMAILJS_SETUP.md`
- **Solutions alternatives** : `FORMULAIRE_CONTACT_EMAIL.md`

## 🆘 Si vous ne trouvez pas le code source

Si vous n'avez pas accès au code source Next.js, vous pouvez :
1. Chercher dans votre projet Next.js local
2. Vérifier s'il y a un autre dépôt GitHub avec le code source
3. Me donner plus d'informations sur la structure de votre projet

---

**Résumé :** Supprimer la section "Prenez rendez-vous", garder le formulaire, le centrer, et configurer l'envoi d'email avec EmailJS.

