# 📅 Remplacer Calendly par Google Calendar

Ce guide vous explique comment remplacer le lien Calendly par un lien vers Google Calendar dans votre site.

## 🔍 Où se trouve le lien Calendly ?

Le lien Calendly se trouve dans la section **Contact** de votre site, dans le composant qui affiche le bouton "Planifier un appel".

## 📝 Solution : Utiliser Google Calendar

Google Calendar permet de créer un lien de rendez-vous public. Voici comment procéder :

### Étape 1 : Créer un lien Google Calendar

1. **Ouvrir Google Calendar** : https://calendar.google.com
2. **Créer un nouvel événement** :
   - Cliquez sur "Créer" ou sur une date/heure
   - Remplissez les détails (titre, description, durée)
3. **Rendre l'événement public** :
   - Dans les paramètres de l'événement, cliquez sur "Ajouter des invités" ou "Plus d'options"
   - Cochez "Rendre disponible publiquement" ou "Public"
4. **Copier le lien** :
   - Cliquez sur "Enregistrer" puis "Copier le lien"
   - Ou utilisez le format : `https://calendar.google.com/calendar/render?action=TEMPLATE&text=[TITRE]&dates=[DATE_DEBUT]/[DATE_FIN]&details=[DESCRIPTION]&location=[LIEU]`

### Étape 2 : Format du lien Google Calendar

Format standard pour un lien de rendez-vous :

```
https://calendar.google.com/calendar/render?action=TEMPLATE
&text=Consultation+BDCForce
&dates=20250120T090000Z/20250120T093000Z
&details=Discutons+de+votre+projet+Salesforce
&location=En+ligne+ou+%C3%A0+Lille
```

**Paramètres :**
- `text` : Titre du rendez-vous (URL encodé)
- `dates` : Date/heure début et fin (format ISO 8601)
- `details` : Description (URL encodé)
- `location` : Lieu (URL encodé)

### Étape 3 : Modifier le code Next.js

Dans votre code source Next.js, trouvez le composant de la section Contact et remplacez :

**Avant (Calendly) :**
```tsx
<a 
  href="https://calendly.com/bdcforce" 
  target="_blank" 
  rel="noopener noreferrer"
  className="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
>
  <i className="far fa-calendar-alt mr-2"></i>
  Planifier un appel
</a>
```

**Après (Google Calendar) :**
```tsx
<a 
  href="https://calendar.google.com/calendar/render?action=TEMPLATE&text=Consultation+BDCForce+-+Salesforce&dates=20250120T090000Z/20250120T093000Z&details=Discutons+de+votre+projet+Salesforce+et+de+vos+besoins+en+transformation+digitale&location=En+ligne+ou+%C3%A0+Lille"
  target="_blank" 
  rel="noopener noreferrer"
  className="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
>
  <i className="far fa-calendar-alt mr-2"></i>
  Planifier un appel
</a>
```

### Étape 4 : Alternative - Utiliser un service de génération de lien

Pour simplifier, vous pouvez utiliser un service comme **Calendly-like** avec Google Calendar :

1. **Calendly-like avec Google Calendar** :
   - Utilisez un service comme `cal.com` (gratuit) qui se connecte à Google Calendar
   - Ou créez votre propre page de réservation

2. **Lien direct vers votre calendrier public** :
   - Partagez votre calendrier Google en mode "public"
   - Créez un lien direct vers votre calendrier

### Étape 5 : Exemple de lien Google Calendar personnalisé

Voici un exemple de lien que vous pouvez utiliser (à personnaliser avec vos informations) :

```
https://calendar.google.com/calendar/render?action=TEMPLATE
&text=Consultation+BDCForce+-+Expert+Salesforce
&dates=20250120T090000Z/20250120T093000Z
&details=Discutons+de+votre+projet+Salesforce%0A%0AJe+suis+expert+Salesforce+certifi%C3%A9+bas%C3%A9+%C3%A0+Lille.+Je+vous+accompagne+dans+l%27optimisation+de+votre+CRM+Salesforce%2C+la+gestion+de+donn%C3%A9es%2C+la+migration+et+l%27automatisation+des+processus.
&location=En+ligne+%28visioconf%C3%A9rence%29+ou+%C3%A0+Lille
```

**Note :** Les dates dans l'exemple sont des placeholders. Vous pouvez les laisser telles quelles, Google Calendar proposera de choisir une date.

### Étape 6 : Solution recommandée - Lien générique

Pour un lien qui fonctionne toujours sans date fixe, utilisez ce format :

```tsx
<a 
  href="https://calendar.google.com/calendar/render?action=TEMPLATE&text=Consultation+BDCForce+-+Salesforce&details=Discutons+de+votre+projet+Salesforce+et+de+vos+besoins+en+transformation+digitale.+Contactez-moi+pour+planifier+un+rendez-vous.&location=En+ligne+ou+%C3%A0+Lille"
  target="_blank" 
  rel="noopener noreferrer"
  className="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
>
  <i className="far fa-calendar-alt mr-2"></i>
  Planifier un appel
</a>
```

Ce lien ouvrira Google Calendar avec un formulaire pré-rempli où l'utilisateur pourra choisir la date et l'heure.

## 🔧 Alternative : Utiliser un service tiers gratuit

Si vous préférez une solution plus professionnelle sans compte Calendly, voici des alternatives :

### 1. Cal.com (Recommandé)
- **Gratuit** pour usage personnel
- Se connecte à Google Calendar
- Interface professionnelle
- URL : https://cal.com

### 2. Doodle
- **Gratuit** pour usage basique
- Facile à utiliser
- URL : https://doodle.com

### 3. YouCanBook.me
- **Gratuit** pour usage limité
- Se connecte à Google Calendar
- URL : https://youcanbook.me

## 📝 Code complet à remplacer

Dans votre composant Contact (probablement dans `app/page.tsx` ou `pages/index.tsx`), recherchez et remplacez :

```tsx
// Ancien code avec Calendly
<a href="https://calendly.com/bdcforce" ...>

// Nouveau code avec Google Calendar
<a 
  href="https://calendar.google.com/calendar/render?action=TEMPLATE&text=Consultation+BDCForce+-+Salesforce&details=Discutons+de+votre+projet+Salesforce+et+de+vos+besoins+en+transformation+digitale.+Contactez-moi+pour+planifier+un+rendez-vous.&location=En+ligne+ou+%C3%A0+Lille"
  target="_blank" 
  rel="noopener noreferrer"
  className="inline-flex items-center justify-center w-full bg-primary hover:bg-primary-dark text-white px-8 py-4 rounded-lg font-medium transition-colors duration-200"
>
  <i className="far fa-calendar-alt mr-2"></i>
  Planifier un appel
</a>
```

## ✅ Après modification

1. **Tester le lien** : Cliquez sur le bouton et vérifiez que Google Calendar s'ouvre correctement
2. **Rebuild le site** : `npm run build` ou `next build`
3. **Tester en local** : Vérifiez que tout fonctionne
4. **Déployer** : Suivez le guide `DEPLOIEMENT_OVH.md`

## 📞 Besoin d'aide ?

Si vous avez besoin d'aide pour personnaliser le lien ou intégrer un autre service, n'hésitez pas à me le demander !

---

**Note importante :** Comme le HTML est généré par Next.js, cette modification doit être faite dans le **code source Next.js**, pas dans les fichiers statiques du dépôt actuel.

