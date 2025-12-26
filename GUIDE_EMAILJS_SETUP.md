# 🚀 Guide Pratique : Configuration EmailJS pour BDCForce

Guide étape par étape pour configurer EmailJS et envoyer les emails du formulaire de contact à **baptiste.delalin@outlook.com**.

## 📋 Prérequis

- Compte Outlook (baptiste.delalin@outlook.com)
- Accès au code source Next.js
- npm ou yarn installé

## 🔧 Étape 1 : Créer un compte EmailJS

1. **Aller sur EmailJS** : https://www.emailjs.com/
2. **Cliquer sur "Sign Up"** (gratuit)
3. **Créer un compte** avec votre email
4. **Vérifier votre email** (vérifiez votre boîte de réception)

## 📧 Étape 2 : Configurer le Service Email (Outlook)

1. **Se connecter à EmailJS**
2. **Aller dans "Email Services"** (menu de gauche)
3. **Cliquer sur "Add New Service"**
4. **Choisir "Outlook"** ou **"Custom SMTP"**

### Option A : Outlook (Recommandé)

Si vous choisissez Outlook :
- EmailJS se connectera directement à votre compte Outlook
- Suivez les instructions pour autoriser l'accès

### Option B : Custom SMTP (Si Outlook ne fonctionne pas)

Si vous choisissez Custom SMTP, utilisez ces paramètres :

```
Host: smtp-mail.outlook.com
Port: 587
Username: baptiste.delalin@outlook.com
Password: [Votre mot de passe Outlook]
Secure: STARTTLS
```

5. **Nommer le service** : "BDCForce Contact" (ou autre nom)
6. **Noter le Service ID** : `service_xxxxx` (vous en aurez besoin)

## 📝 Étape 3 : Créer un Template d'Email

1. **Aller dans "Email Templates"** (menu de gauche)
2. **Cliquer sur "Create New Template"**
3. **Configurer le template** :

### Configuration du Template

**Template Name :** BDCForce Contact Form

**Subject :** 
```
Nouvelle demande de contact - BDCForce - {{name}}
```

**Content (HTML) :**
```html
<h2>Nouvelle demande de contact - BDCForce</h2>

<p>Vous avez reçu une nouvelle demande de contact depuis votre site web :</p>

<table style="width: 100%; border-collapse: collapse;">
  <tr>
    <td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;"><strong>Nom :</strong></td>
    <td style="padding: 8px; border: 1px solid #ddd;">{{name}}</td>
  </tr>
  <tr>
    <td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;"><strong>Email :</strong></td>
    <td style="padding: 8px; border: 1px solid #ddd;">{{email}}</td>
  </tr>
  <tr>
    <td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;"><strong>Téléphone :</strong></td>
    <td style="padding: 8px; border: 1px solid #ddd;">{{phone}}</td>
  </tr>
  <tr>
    <td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;"><strong>Entreprise :</strong></td>
    <td style="padding: 8px; border: 1px solid #ddd;">{{company}}</td>
  </tr>
  <tr>
    <td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;"><strong>Type de projet :</strong></td>
    <td style="padding: 8px; border: 1px solid #ddd;">{{projectType}}</td>
  </tr>
  <tr>
    <td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;"><strong>Budget :</strong></td>
    <td style="padding: 8px; border: 1px solid #ddd;">{{budget}}</td>
  </tr>
</table>

<h3>Message :</h3>
<p style="background-color: #f5f5f5; padding: 15px; border-left: 4px solid #06b6d4; margin: 20px 0;">
  {{message}}
</p>

<hr style="border: none; border-top: 1px solid #ddd; margin: 20px 0;">

<p style="color: #666; font-size: 12px;">
  <em>Email envoyé depuis www.bdcforce.fr</em><br>
  Date : {{date}}
</p>
```

4. **To Email :** baptiste.delalin@outlook.com
5. **From Name :** BDCForce Website
6. **From Email :** baptiste.delalin@outlook.com (ou votre email de service)
7. **Cliquer sur "Save"**
8. **Noter le Template ID** : `template_xxxxx` (vous en aurez besoin)

## 🔑 Étape 4 : Obtenir la Public Key

1. **Aller dans "Account"** (menu de gauche)
2. **Section "General"**
3. **Noter la "Public Key"** : `xxxxxxxxxxxxx` (vous en aurez besoin)

## 💻 Étape 5 : Installer EmailJS dans Next.js

Dans votre projet Next.js, exécutez :

```bash
npm install @emailjs/browser
```

Ou avec yarn :

```bash
yarn add @emailjs/browser
```

## 📝 Étape 6 : Créer le Composant Contact Form

Créer ou modifier votre composant de formulaire de contact :

**Fichier :** `components/ContactForm.tsx` (ou dans votre page)

```tsx
'use client';

import { useState } from 'react';
import emailjs from '@emailjs/browser';

// ⚠️ REMPLACER PAR VOS IDENTIFIANTS EMAILJS
const EMAILJS_SERVICE_ID = 'service_xxxxx'; // Votre Service ID
const EMAILJS_TEMPLATE_ID = 'template_xxxxx'; // Votre Template ID
const EMAILJS_PUBLIC_KEY = 'xxxxxxxxxxxxx'; // Votre Public Key

export default function ContactForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    company: '',
    projectType: '',
    budget: '',
    message: '',
    website: '' // Honeypot pour anti-spam
  });
  
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState<'idle' | 'success' | 'error'>('idle');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    // Protection anti-spam (honeypot)
    if (formData.website) {
      console.log('Spam détecté');
      return;
    }
    
    setIsSubmitting(true);
    setSubmitStatus('idle');

    try {
      await emailjs.send(
        EMAILJS_SERVICE_ID,
        EMAILJS_TEMPLATE_ID,
        {
          name: formData.name,
          email: formData.email,
          phone: formData.phone || 'Non renseigné',
          company: formData.company || 'Non renseigné',
          projectType: formData.projectType,
          budget: formData.budget,
          message: formData.message,
          date: new Date().toLocaleString('fr-FR'),
        },
        EMAILJS_PUBLIC_KEY
      );

      setSubmitStatus('success');
      setFormData({
        name: '',
        email: '',
        phone: '',
        company: '',
        projectType: '',
        budget: '',
        message: '',
        website: ''
      });
    } catch (error) {
      console.error('Erreur envoi email:', error);
      setSubmitStatus('error');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {/* Messages de statut */}
      {submitStatus === 'success' && (
        <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg">
          ✅ Votre message a été envoyé avec succès ! Nous vous répondrons dans les plus brefs délais.
        </div>
      )}
      {submitStatus === 'error' && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg">
          ❌ Une erreur est survenue. Veuillez réessayer ou nous contacter directement par email à baptiste.delalin@outlook.com
        </div>
      )}

      {/* Honeypot - Champ invisible pour anti-spam */}
      <input
        type="text"
        name="website"
        value={formData.website}
        onChange={handleChange}
        style={{ position: 'absolute', left: '-9999px' }}
        tabIndex={-1}
        autoComplete="off"
      />

      {/* Champs du formulaire */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label htmlFor="name" className="block text-sm font-medium text-gray-700 mb-1">
            Nom complet <span className="text-red-500">*</span>
          </label>
          <input
            type="text"
            id="name"
            name="name"
            required
            minLength={2}
            value={formData.name}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
          />
        </div>
        <div>
          <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">
            Email <span className="text-red-500">*</span>
          </label>
          <input
            type="email"
            id="email"
            name="email"
            required
            value={formData.email}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
          />
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label htmlFor="phone" className="block text-sm font-medium text-gray-700 mb-1">
            Téléphone
          </label>
          <input
            type="tel"
            id="phone"
            name="phone"
            value={formData.phone}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
          />
        </div>
        <div>
          <label htmlFor="company" className="block text-sm font-medium text-gray-700 mb-1">
            Entreprise
          </label>
          <input
            type="text"
            id="company"
            name="company"
            value={formData.company}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
          />
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label htmlFor="projectType" className="block text-sm font-medium text-gray-700 mb-1">
            Type de projet <span className="text-red-500">*</span>
          </label>
          <select
            id="projectType"
            name="projectType"
            required
            value={formData.projectType}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
          >
            <option value="">Sélectionnez un type de projet</option>
            <option value="consulting">Consulting Salesforce</option>
            <option value="development">Développement</option>
            <option value="training">Formation</option>
            <option value="support">Support</option>
            <option value="other">Autre</option>
          </select>
        </div>
        <div>
          <label htmlFor="budget" className="block text-sm font-medium text-gray-700 mb-1">
            Budget estimé <span className="text-red-500">*</span>
          </label>
          <select
            id="budget"
            name="budget"
            required
            value={formData.budget}
            onChange={handleChange}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
          >
            <option value="">Sélectionnez une fourchette de budget</option>
            <option value="0-5000">0€ - 5 000€</option>
            <option value="5000-10000">5 000€ - 10 000€</option>
            <option value="10000-25000">10 000€ - 25 000€</option>
            <option value="25000-50000">25 000€ - 50 000€</option>
            <option value="50000+">50 000€ et plus</option>
          </select>
        </div>
      </div>

      <div>
        <label htmlFor="message" className="block text-sm font-medium text-gray-700 mb-1">
          Message <span className="text-red-500">*</span>
        </label>
        <textarea
          id="message"
          name="message"
          required
          minLength={10}
          rows={4}
          value={formData.message}
          onChange={handleChange}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
        />
        <small className="text-gray-500">Minimum 10 caractères</small>
      </div>

      <button
        type="submit"
        disabled={isSubmitting}
        className="w-full bg-primary hover:bg-primary-dark text-white py-3 rounded-lg font-medium transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {isSubmitting ? '⏳ Envoi en cours...' : '📧 Envoyer le message'}
      </button>
    </form>
  );
}
```

## 🔧 Étape 7 : Intégrer dans votre Page Contact

Dans votre page Contact, utilisez le composant :

```tsx
import ContactForm from '@/components/ContactForm';

export default function ContactPage() {
  return (
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
        
        <div className="max-w-2xl mx-auto">
          <div className="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
            <h3 className="text-2xl font-semibold text-gray-900 mb-6">
              Envoyez-nous un message
            </h3>
            <ContactForm />
          </div>
        </div>
      </div>
    </section>
  );
}
```

## ✅ Étape 8 : Tester

1. **Lancer le serveur de développement** :
   ```bash
   npm run dev
   ```

2. **Aller sur la page Contact** : http://localhost:3000/#contact

3. **Remplir le formulaire** avec des données de test

4. **Soumettre le formulaire**

5. **Vérifier votre boîte email** : baptiste.delalin@outlook.com

## 🐛 Résolution de Problèmes

### Problème : Email non reçu

**Solutions :**
- Vérifier les identifiants EmailJS (Service ID, Template ID, Public Key)
- Vérifier les spams dans Outlook
- Vérifier la console du navigateur pour les erreurs
- Vérifier que le service EmailJS est bien configuré

### Problème : Erreur "Invalid template"

**Solution :**
- Vérifier que le Template ID est correct
- Vérifier que les variables dans le template correspondent aux données envoyées

### Problème : Erreur "Invalid service"

**Solution :**
- Vérifier que le Service ID est correct
- Vérifier que le service email est bien configuré dans EmailJS

## 📊 Limites EmailJS Gratuit

- **100 emails/mois** (gratuit)
- **200 emails/mois** (plan payant à partir de $15/mois)

Pour la plupart des sites, 100 emails/mois suffisent largement.

## 🔒 Sécurité

Le code inclut :
- ✅ Protection anti-spam (honeypot)
- ✅ Validation des champs
- ✅ Messages d'erreur sécurisés

## 📝 Checklist Finale

- [ ] Compte EmailJS créé
- [ ] Service email configuré (Outlook)
- [ ] Template d'email créé
- [ ] Service ID noté
- [ ] Template ID noté
- [ ] Public Key notée
- [ ] EmailJS installé dans Next.js
- [ ] Composant ContactForm créé
- [ ] Identifiants EmailJS ajoutés dans le code
- [ ] Formulaire intégré dans la page Contact
- [ ] Test d'envoi réussi
- [ ] Email reçu sur baptiste.delalin@outlook.com

## 🎉 C'est prêt !

Une fois toutes les étapes terminées, votre formulaire de contact enverra automatiquement les emails à **baptiste.delalin@outlook.com** !

---

**Besoin d'aide ?** Consultez la documentation EmailJS : https://www.emailjs.com/docs/

