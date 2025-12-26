# 📧 Configuration du Formulaire de Contact - Envoi par Email

Ce guide explique comment configurer le formulaire de contact pour qu'il envoie un email à **baptiste.delalin@outlook.com** lorsque le client valide le formulaire.

## 🎯 Objectif

- **Supprimer** : La section "Prendre un RDV" / Calendly
- **Conserver** : Le formulaire de contact
- **Configurer** : Le formulaire pour envoyer un email à baptiste.delalin@outlook.com

## 📋 Solutions Recommandées

### Option 1 : EmailJS (Recommandé - Simple et Gratuit)

EmailJS est un service gratuit qui permet d'envoyer des emails directement depuis le frontend sans backend.

#### Étape 1 : Créer un compte EmailJS

1. Aller sur https://www.emailjs.com/
2. Créer un compte gratuit (100 emails/mois)
3. Vérifier votre email

#### Étape 2 : Configurer EmailJS

1. **Connecter un service email** :
   - Aller dans "Email Services"
   - Cliquer sur "Add New Service"
   - Choisir "Outlook" ou "Custom SMTP"
   - Configurer avec vos identifiants Outlook

2. **Créer un template d'email** :
   - Aller dans "Email Templates"
   - Cliquer sur "Create New Template"
   - Template ID : `template_xxxxx` (à noter)
   - Configurer le template :

```
Sujet : Nouvelle demande de contact - BDCForce

Bonjour,

Vous avez reçu une nouvelle demande de contact depuis votre site web :

Nom : {{name}}
Email : {{email}}
Téléphone : {{phone}}
Entreprise : {{company}}
Type de projet : {{projectType}}
Budget : {{budget}}

Message :
{{message}}

---
Email envoyé depuis www.bdcforce.fr
```

#### Étape 3 : Installer EmailJS dans Next.js

```bash
npm install @emailjs/browser
```

#### Étape 4 : Code du formulaire avec EmailJS

```tsx
'use client';

import { useState } from 'react';
import emailjs from '@emailjs/browser';

export default function ContactForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    company: '',
    projectType: '',
    budget: '',
    message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState<'idle' | 'success' | 'error'>('idle');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setSubmitStatus('idle');

    try {
      // Remplacer par vos identifiants EmailJS
      const serviceId = 'service_xxxxx';
      const templateId = 'template_xxxxx';
      const publicKey = 'your_public_key';

      await emailjs.send(
        serviceId,
        templateId,
        {
          name: formData.name,
          email: formData.email,
          phone: formData.phone || 'Non renseigné',
          company: formData.company || 'Non renseigné',
          projectType: formData.projectType,
          budget: formData.budget,
          message: formData.message,
          to_email: 'baptiste.delalin@outlook.com', // Email de destination
        },
        publicKey
      );

      setSubmitStatus('success');
      setFormData({
        name: '',
        email: '',
        phone: '',
        company: '',
        projectType: '',
        budget: '',
        message: ''
      });
    } catch (error) {
      console.error('Erreur envoi email:', error);
      setSubmitStatus('error');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {/* Messages de statut */}
      {submitStatus === 'success' && (
        <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded">
          ✅ Votre message a été envoyé avec succès ! Nous vous répondrons dans les plus brefs délais.
        </div>
      )}
      {submitStatus === 'error' && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
          ❌ Une erreur est survenue. Veuillez réessayer ou nous contacter directement par email.
        </div>
      )}

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
          rows={4}
          value={formData.message}
          onChange={handleChange}
          className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent"
        />
      </div>

      <button
        type="submit"
        disabled={isSubmitting}
        className="w-full bg-primary hover:bg-primary-dark text-white py-3 rounded-lg font-medium transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {isSubmitting ? 'Envoi en cours...' : 'Envoyer le message'}
      </button>
    </form>
  );
}
```

### Option 2 : API Route Next.js avec Nodemailer

Si vous préférez une solution plus contrôlée avec votre propre backend.

#### Étape 1 : Installer les dépendances

```bash
npm install nodemailer
npm install --save-dev @types/nodemailer
```

#### Étape 2 : Créer l'API Route

Créer `app/api/contact/route.ts` (App Router) ou `pages/api/contact.ts` (Pages Router) :

```typescript
import { NextRequest, NextResponse } from 'next/server';
import nodemailer from 'nodemailer';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { name, email, phone, company, projectType, budget, message } = body;

    // Configuration du transporteur email (Outlook)
    const transporter = nodemailer.createTransport({
      host: 'smtp-mail.outlook.com',
      port: 587,
      secure: false, // true pour 465, false pour autres ports
      auth: {
        user: process.env.OUTLOOK_EMAIL, // baptiste.delalin@outlook.com
        pass: process.env.OUTLOOK_PASSWORD, // Mot de passe Outlook
      },
    });

    // Contenu de l'email
    const mailOptions = {
      from: process.env.OUTLOOK_EMAIL,
      to: 'baptiste.delalin@outlook.com',
      subject: `Nouvelle demande de contact - BDCForce - ${name}`,
      html: `
        <h2>Nouvelle demande de contact</h2>
        <p>Vous avez reçu une nouvelle demande de contact depuis votre site web :</p>
        <ul>
          <li><strong>Nom :</strong> ${name}</li>
          <li><strong>Email :</strong> ${email}</li>
          <li><strong>Téléphone :</strong> ${phone || 'Non renseigné'}</li>
          <li><strong>Entreprise :</strong> ${company || 'Non renseigné'}</li>
          <li><strong>Type de projet :</strong> ${projectType}</li>
          <li><strong>Budget :</strong> ${budget}</li>
        </ul>
        <h3>Message :</h3>
        <p>${message}</p>
        <hr>
        <p><em>Email envoyé depuis www.bdcforce.fr</em></p>
      `,
    };

    await transporter.sendMail(mailOptions);

    return NextResponse.json(
      { message: 'Email envoyé avec succès' },
      { status: 200 }
    );
  } catch (error) {
    console.error('Erreur envoi email:', error);
    return NextResponse.json(
      { message: 'Erreur lors de l\'envoi de l\'email' },
      { status: 500 }
    );
  }
}
```

#### Étape 3 : Variables d'environnement

Créer `.env.local` :

```env
OUTLOOK_EMAIL=baptiste.delalin@outlook.com
OUTLOOK_PASSWORD=votre_mot_de_passe_outlook
```

#### Étape 4 : Code du formulaire

```tsx
'use client';

import { useState } from 'react';

export default function ContactForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    company: '',
    projectType: '',
    budget: '',
    message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState<'idle' | 'success' | 'error'>('idle');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setSubmitStatus('idle');

    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        setSubmitStatus('success');
        setFormData({
          name: '',
          email: '',
          phone: '',
          company: '',
          projectType: '',
          budget: '',
          message: ''
        });
      } else {
        setSubmitStatus('error');
      }
    } catch (error) {
      console.error('Erreur:', error);
      setSubmitStatus('error');
    } finally {
      setIsSubmitting(false);
    }
  };

  // ... reste du code identique à l'option 1
}
```

### Option 3 : Formspree (Service tiers - Très simple)

Formspree est un service gratuit qui gère les formulaires sans code backend.

1. Aller sur https://formspree.io/
2. Créer un compte gratuit
3. Créer un nouveau formulaire
4. Obtenir l'endpoint : `https://formspree.io/f/YOUR_FORM_ID`

```tsx
<form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
  {/* Champs du formulaire */}
</form>
```

## ✅ Checklist de Configuration

- [ ] Choisir une solution (EmailJS recommandé pour simplicité)
- [ ] Configurer le service d'email
- [ ] Installer les dépendances nécessaires
- [ ] Intégrer le code dans le composant Contact
- [ ] Tester l'envoi d'email
- [ ] Vérifier la réception des emails sur baptiste.delalin@outlook.com
- [ ] Ajouter la validation du formulaire (voir `form-contact-example.html`)
- [ ] Ajouter la protection anti-spam (honeypot)

## 🔒 Sécurité

### Protection Anti-Spam

Ajouter un champ honeypot dans le formulaire :

```tsx
{/* Champ honeypot - invisible pour les utilisateurs */}
<input
  type="text"
  name="website"
  style={{ position: 'absolute', left: '-9999px' }}
  tabIndex={-1}
  autoComplete="off"
/>

{/* Dans handleSubmit */}
if (formData.website) {
  // C'est un bot, ne pas traiter
  return;
}
```

### Validation

Utiliser la validation HTML5 et JavaScript (voir `form-contact-example.html` pour un exemple complet).

## 📝 Résumé

**Solution recommandée : EmailJS**
- ✅ Gratuit (100 emails/mois)
- ✅ Simple à configurer
- ✅ Pas besoin de backend
- ✅ Fonctionne directement depuis le frontend

**Email de destination :** baptiste.delalin@outlook.com

---

**Note :** N'oubliez pas de retirer la section "Prendre un RDV" / Calendly comme indiqué dans `MODIFICATION_CONTACT.md`.

