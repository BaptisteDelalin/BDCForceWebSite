# 📧 Modification de la Section Contact

Ce guide explique comment modifier la section contact pour retirer le bouton de rendez-vous et inviter les visiteurs à contacter directement par email ou téléphone.

## 🎯 Changements à effectuer

### Avant
- Bouton "Planifier un appel" avec lien Calendly/Google Calendar
- Formulaire de contact

### Après
- **Suppression complète du formulaire de contact**
- Invitation à contacter directement par email ou téléphone uniquement
- Email : baptiste.delalin@outlook.com
- Téléphone : 06-17-67-92-67

## 📝 Code à modifier dans Next.js

Dans votre composant Contact (probablement dans `app/page.tsx` ou `pages/index.tsx`), vous devez :

1. **Retirer complètement le formulaire de contact**
2. **Retirer le bouton "Planifier un appel" / Calendly**
3. **Remplacer par une section centrée avec les boutons Email et Téléphone**

### Code à retirer (Formulaire de contact)

```tsx
{/* RETIRER TOUT CE BLOC */}
<div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
  <h3 class="text-2xl font-semibold text-gray-900 mb-6">Envoyez-nous un message</h3>
  <form class="space-y-6">
    {/* Tout le formulaire avec les champs name, email, phone, company, projectType, budget, message */}
  </form>
</div>
```

### Code à retirer (Bouton Calendly)

### Ancien code (à retirer)

```tsx
{/* RETIRER : Bouton Calendly */}
<div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
  <h3 class="text-2xl font-semibold text-gray-900 mb-6">Prenez rendez-vous</h3>
  <p class="text-gray-600 mb-8">Réservez un créneau de 30 minutes pour discuter de votre projet avec nos experts.</p>
  <a href="https://calendly.com/bdcforce" target="_blank" rel="noopener noreferrer" class="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200">
    <i class="far fa-calendar-alt mr-2"></i>Planifier un appel
  </a>
</div>

{/* RETIRER : Formulaire de contact complet */}
<div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
  <h3 class="text-2xl font-semibold text-gray-900 mb-6">Envoyez-nous un message</h3>
  <form class="space-y-6">
    {/* Tous les champs du formulaire */}
  </form>
</div>
```

### Nouveau code (à utiliser) - Section centrée sans formulaire

```tsx
{/* REMPLACER la grille à 2 colonnes par une section centrée */}
<div class="max-w-2xl mx-auto">
  <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
    <h3 class="text-2xl font-semibold text-gray-900 mb-6 text-center">
      Contactez-nous directement
    </h3>
    <p class="text-gray-600 mb-8 text-center">
      Discutons de votre projet Salesforce. Contactez-nous par email ou téléphone pour planifier un rendez-vous.
    </p>
    <div class="space-y-4">
      <a 
        href="mailto:baptiste.delalin@outlook.com?subject=Demande%20de%20contact%20-%20BDCForce&body=Bonjour,%0D%0A%0D%0AJe%20souhaiterais%20discuter%20de%20mon%20projet%20Salesforce.%0D%0A%0D%0ACordialement"
        class="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
      >
        <i class="fas fa-envelope mr-2"></i>
        Envoyer un email
      </a>
      <a 
        href="tel:+33617679267"
        class="inline-flex items-center justify-center w-full bg-green-600 hover:bg-green-700 text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
      >
        <i class="fas fa-phone mr-2"></i>
        Appeler maintenant
      </a>
    </div>
  </div>
</div>
```

**Important :** Remplacez aussi la grille `grid grid-cols-1 lg:grid-cols-2` par une simple div centrée, car vous n'avez plus besoin de 2 colonnes.

## 🎨 Version alternative avec icônes côte à côte

Si vous préférez un design avec les deux boutons côte à côte :

```tsx
<div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
  <h3 class="text-2xl font-semibold text-gray-900 mb-6">Contactez-nous</h3>
  <p class="text-gray-600 mb-8">Discutons de votre projet Salesforce. Contactez-nous directement par email ou téléphone.</p>
  <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
    <a 
      href="mailto:baptiste.delalin@outlook.com?subject=Demande%20de%20contact%20-%20BDCForce&body=Bonjour,%0D%0A%0D%0AJe%20souhaiterais%20discuter%20de%20mon%20projet%20Salesforce.%0D%0A%0D%0ACordialement"
      class="inline-flex items-center justify-center bg-primary hover:bg-primary-dark text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200"
    >
      <i class="fas fa-envelope mr-2"></i>
      Email
    </a>
    <a 
      href="tel:+33617679267"
      class="inline-flex items-center justify-center bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-lg font-medium transition-colors duration-200"
    >
      <i class="fas fa-phone mr-2"></i>
      Téléphone
    </a>
  </div>
</div>
```

## 📧 Détails de l'email

L'email utilisé est : **baptiste.delalin@outlook.com**

Le lien `mailto:` est pré-configuré avec :
- **Sujet** : "Demande de contact - BDCForce"
- **Corps** : Message pré-rempli (modifiable par l'utilisateur)

## 📱 Détails du téléphone

Le numéro utilisé est : **06-17-67-92-67**

Le lien `tel:` permet d'appeler directement depuis un mobile.

## ✅ Checklist de modification

- [ ] **Retirer complètement le formulaire de contact**
- [ ] Retirer le bouton "Planifier un appel" / Calendly
- [ ] Ajouter le bouton "Envoyer un email" avec mailto:baptiste.delalin@outlook.com
- [ ] Ajouter le bouton "Appeler maintenant" avec tel:+33617679267
- [ ] Mettre à jour le texte d'invitation
- [ ] Modifier la grille pour une seule colonne (plus besoin de 2 colonnes)
- [ ] Tester les liens sur mobile et desktop
- [ ] Vérifier que l'email s'ouvre correctement
- [ ] Vérifier que le téléphone fonctionne sur mobile

## 🔄 Mise à jour des autres sections

N'oubliez pas de vérifier et mettre à jour l'email dans d'autres sections si nécessaire :

1. **Section contact (informations)** : Vérifier que l'email affiché est correct
2. **Footer** : Vérifier l'email dans le footer
3. **Données structurées JSON-LD** : Mettre à jour l'email dans `structured-data.json`

## 📝 Exemple complet de section Contact

Voici un exemple complet de la section contact modifiée :

```tsx
<section id="contact" class="py-20 bg-white">
  <div class="container mx-auto px-4">
    <div class="text-center mb-16">
      <h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
        Contactez-nous
      </h2>
      <p class="text-xl text-gray-600 max-w-2xl mx-auto">
        Discutons de votre projet et de vos besoins en transformation digitale
      </p>
    </div>
    
    {/* Section Contact Direct - Centrée, sans formulaire */}
    <div class="max-w-2xl mx-auto">
      <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
        <h3 class="text-2xl font-semibold text-gray-900 mb-6 text-center">
          Contactez-nous directement
        </h3>
        <p class="text-gray-600 mb-8 text-center">
          Discutons de votre projet Salesforce. Contactez-nous par email ou téléphone pour planifier un rendez-vous.
        </p>
        <div class="space-y-4">
          <a 
            href="mailto:baptiste.delalin@outlook.com?subject=Demande%20de%20contact%20-%20BDCForce&body=Bonjour,%0D%0A%0D%0AJe%20souhaiterais%20discuter%20de%20mon%20projet%20Salesforce.%0D%0A%0D%0ACordialement"
            class="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
          >
            <i class="fas fa-envelope mr-2"></i>
            Envoyer un email
          </a>
          <a 
            href="tel:+33617679267"
            class="inline-flex items-center justify-center w-full bg-green-600 hover:bg-green-700 text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
          >
            <i class="fas fa-phone mr-2"></i>
            Appeler maintenant
          </a>
        </div>
      </div>
    </div>
    
    {/* Informations de contact (mettre à jour l'email) */}
    <div class="mt-12 grid grid-cols-1 md:grid-cols-3 gap-8">
      <div class="bg-white rounded-xl shadow-lg p-6 border border-gray-100">
        <div class="flex items-start">
          <div class="text-primary text-2xl mr-4">
            <i class="fas fa-map-marker-alt"></i>
          </div>
          <div class="ml-4">
            <h4 class="text-lg font-semibold text-gray-900">Adresse</h4>
            <p class="text-gray-600">Hauts-de-France / Paris / Bruxelles</p>
          </div>
        </div>
      </div>
      <div class="bg-white rounded-xl shadow-lg p-6 border border-gray-100">
        <div class="flex items-start">
          <div class="text-primary text-2xl mr-4">
            <i class="fas fa-phone"></i>
          </div>
          <div class="ml-4">
            <h4 class="text-lg font-semibold text-gray-900">Téléphone</h4>
            <a href="tel:+33617679267" class="text-blue-600 hover:text-blue-800">
              06-17-67-92-67
            </a>
          </div>
        </div>
      </div>
      <div class="bg-white rounded-xl shadow-lg p-6 border border-gray-100">
        <div class="flex items-start">
          <div class="text-primary text-2xl mr-4">
            <i class="fas fa-envelope"></i>
          </div>
          <div class="ml-4">
            <h4 class="text-lg font-semibold text-gray-900">Email</h4>
            <a href="mailto:baptiste.delalin@outlook.com" class="text-blue-600 hover:text-blue-800">
              baptiste.delalin@outlook.com
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
```

## 🔍 Vérifications à faire

1. **Email dans le footer** : Vérifier que l'email est mis à jour
2. **Email dans les données structurées** : Mettre à jour dans `structured-data.json` si nécessaire
3. **Test des liens** : 
   - Tester `mailto:` sur différents navigateurs
   - Tester `tel:` sur mobile
4. **Responsive** : Vérifier l'affichage sur mobile

---

**Note :** Cette modification doit être faite dans le **code source Next.js**, pas dans les fichiers statiques du dépôt actuel.

