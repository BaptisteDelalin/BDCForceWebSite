# 💡 Recommandations pour le Code Source Next.js

Ce document contient des recommandations pour améliorer le code source Next.js de BDCForce. Ces améliorations doivent être faites dans le projet Next.js source (non présent dans ce dépôt).

## 🎨 Améliorations UX/UI

### 1. Accessibilité

#### Attributs ARIA
```tsx
// Ajouter des labels ARIA pour améliorer l'accessibilité
<button 
  aria-label="Ouvrir le menu de navigation"
  aria-expanded={isMenuOpen}
  aria-controls="main-menu"
>
  <i className="fas fa-bars" aria-hidden="true"></i>
</button>
```

#### Navigation au clavier
```tsx
// S'assurer que tous les éléments interactifs sont accessibles au clavier
<div 
  role="button"
  tabIndex={0}
  onKeyDown={(e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      handleClick();
    }
  }}
  onClick={handleClick}
>
  Contenu
</div>
```

#### Contrastes de couleurs
- Vérifier tous les contrastes avec [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- Objectif : WCAG AA minimum (ratio 4.5:1 pour le texte normal)

### 2. Images

#### Lazy Loading
```tsx
import Image from 'next/image';

<Image
  src="/img/portfolio/project.jpg"
  alt="Description du projet"
  width={800}
  height={600}
  loading="lazy"
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,..."
/>
```

#### Support WebP avec fallback
```tsx
<picture>
  <source srcSet="/img/webp/image.webp" type="image/webp" />
  <source srcSet="/img/image.jpg" type="image/jpeg" />
  <img src="/img/image.jpg" alt="Description" loading="lazy" />
</picture>
```

#### Attributs alt descriptifs
```tsx
// ❌ Mauvais
<img src="/img/team/delalin.jpg" alt="Photo" />

// ✅ Bon
<img 
  src="/img/team/delalin.jpg" 
  alt="Delalin Baptiste, Fondateur et CEO de BDCForce, expert Salesforce certifié"
/>
```

### 3. Micro-interactions

#### Animations légères
```tsx
// Ajouter des transitions sur les hover
<button className="transition-all duration-300 hover:scale-105 hover:shadow-lg">
  Contactez-nous
</button>

// Animation au scroll
import { useInView } from 'react-intersection-observer';

function AnimatedSection() {
  const { ref, inView } = useInView({
    triggerOnce: true,
    threshold: 0.1,
  });

  return (
    <div
      ref={ref}
      className={`transition-opacity duration-1000 ${
        inView ? 'opacity-100' : 'opacity-0'
      }`}
    >
      Contenu
    </div>
  );
}
```

## 🔒 Sécurité et Formulaires

### 1. Formulaire de Contact

#### Validation en temps réel
```tsx
// Voir form-contact-example.html pour un exemple complet
const [errors, setErrors] = useState({});

const validateEmail = (email: string) => {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
};

const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault();
  
  // Validation
  const newErrors: Record<string, string> = {};
  if (!validateEmail(formData.email)) {
    newErrors.email = 'Email invalide';
  }
  
  if (Object.keys(newErrors).length > 0) {
    setErrors(newErrors);
    return;
  }
  
  // Envoi...
};
```

#### Protection Anti-Spam

##### Honeypot (recommandé)
```tsx
// Champ caché pour les bots
<input
  type="text"
  name="website"
  style={{ position: 'absolute', left: '-9999px' }}
  tabIndex={-1}
  autoComplete="off"
/>

// Vérification
if (formData.website) {
  // C'est un bot, ne pas traiter
  return;
}
```

##### reCAPTCHA v3 (optionnel)
```tsx
import { useReCaptcha } from 'next-recaptcha-v3';

function ContactForm() {
  const { executeRecaptcha } = useReCaptcha();
  
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    const token = await executeRecaptcha('contact_form');
    
    // Envoyer le token avec les données du formulaire
    const response = await fetch('/api/contact', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ ...formData, recaptchaToken: token }),
    });
  };
}
```

### 2. Headers de Sécurité

Ajouter dans `next.config.js` :
```js
module.exports = {
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-XSS-Protection',
            value: '1; mode=block',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'X-Frame-Options',
            value: 'SAMEORIGIN',
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
        ],
      },
    ];
  },
};
```

## 📊 Analytics et Tracking

### Google Analytics 4
```tsx
// _app.tsx ou layout.tsx
import { useEffect } from 'react';
import { usePathname } from 'next/navigation';
import Script from 'next/script';

export default function RootLayout({ children }) {
  const pathname = usePathname();
  
  useEffect(() => {
    if (typeof window !== 'undefined' && window.gtag) {
      window.gtag('config', 'GA_MEASUREMENT_ID', {
        page_path: pathname,
      });
    }
  }, [pathname]);
  
  return (
    <>
      <Script
        strategy="afterInteractive"
        src={`https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID`}
      />
      <Script id="google-analytics" strategy="afterInteractive">
        {`
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
          gtag('config', 'GA_MEASUREMENT_ID', {
            page_path: window.location.pathname,
          });
        `}
      </Script>
      {children}
    </>
  );
}
```

## 🎯 SEO

### 1. Métadonnées Dynamiques

```tsx
// app/layout.tsx ou pages/_app.tsx
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: {
    default: 'BDCForce - Freelance Salesforce à Lille',
    template: '%s | BDCForce',
  },
  description: 'Expert Salesforce à Lille, spécialisé dans la transformation digitale et l\'implémentation de solutions CRM.',
  keywords: ['Salesforce', 'CRM', 'Lille', 'Freelance', 'Consultant', 'Digital', 'Transformation'],
  openGraph: {
    type: 'website',
    locale: 'fr_FR',
    url: 'https://www.bdcforce.fr',
    siteName: 'BDCForce',
    images: [
      {
        url: 'https://www.bdcforce.fr/img/logo-web-transparent.png',
        width: 1200,
        height: 630,
        alt: 'BDCForce Logo',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'BDCForce - Freelance Salesforce à Lille',
    description: 'Expert Salesforce à Lille',
    images: ['https://www.bdcforce.fr/img/logo-web-transparent.png'],
  },
};
```

### 2. Données Structurées

```tsx
// Ajouter dans le <head> ou layout
<script
  type="application/ld+json"
  dangerouslySetInnerHTML={{
    __html: JSON.stringify({
      '@context': 'https://schema.org',
      '@type': 'LocalBusiness',
      name: 'BDCForce',
      // ... (voir structured-data.json)
    }),
  }}
/>
```

### 3. Breadcrumb

```tsx
// Composant Breadcrumb
import Link from 'next/link';

interface BreadcrumbProps {
  items: { label: string; href?: string }[];
}

export function Breadcrumb({ items }: BreadcrumbProps) {
  return (
    <nav aria-label="Breadcrumb" className="breadcrumb">
      <ol className="flex items-center space-x-2">
        {items.map((item, index) => (
          <li key={index} className="flex items-center">
            {index > 0 && <span className="mx-2">/</span>}
            {item.href ? (
              <Link href={item.href} className="text-blue-600 hover:underline">
                {item.label}
              </Link>
            ) : (
              <span className="text-gray-500">{item.label}</span>
            )}
          </li>
        ))}
      </ol>
    </nav>
  );
}
```

## 🌙 Dark Mode

```tsx
// Hook pour le dark mode
import { useState, useEffect } from 'react';

export function useDarkMode() {
  const [isDark, setIsDark] = useState(false);
  
  useEffect(() => {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const stored = localStorage.getItem('darkMode');
    
    setIsDark(stored ? stored === 'true' : prefersDark);
  }, []);
  
  useEffect(() => {
    document.documentElement.classList.toggle('dark', isDark);
    localStorage.setItem('darkMode', String(isDark));
  }, [isDark]);
  
  return [isDark, setIsDark] as const;
}

// Utilisation
function ThemeToggle() {
  const [isDark, setIsDark] = useDarkMode();
  
  return (
    <button onClick={() => setIsDark(!isDark)}>
      {isDark ? '☀️' : '🌙'}
    </button>
  );
}
```

## 📱 PWA (Progressive Web App)

### Service Worker
```tsx
// public/sw.js
const CACHE_NAME = 'bdcforce-v1';
const urlsToCache = [
  '/',
  '/manifest.json',
  '/img/logo-web-transparent.png',
  // ... autres assets
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(urlsToCache);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
```

### Enregistrement
```tsx
// _app.tsx ou layout.tsx
useEffect(() => {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker
      .register('/sw.js')
      .then((registration) => {
        console.log('SW registered:', registration);
      })
      .catch((error) => {
        console.log('SW registration failed:', error);
      });
  }
}, []);
```

## ⚡ Performance

### Code Splitting
```tsx
// Lazy loading des composants
import dynamic from 'next/dynamic';

const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <p>Chargement...</p>,
  ssr: false, // Si le composant nécessite le client
});
```

### Optimisation des Fonts
```tsx
// next.config.js
module.exports = {
  optimizeFonts: true,
};

// Utilisation
import { Inter } from 'next/font/google';

const inter = Inter({ subsets: ['latin'] });
```

## 🧪 Tests

### Tests d'accessibilité
```bash
npm install --save-dev @axe-core/react
```

```tsx
// _app.tsx (dev seulement)
if (process.env.NODE_ENV !== 'production') {
  const React = require('react');
  const axe = require('@axe-core/react');
  axe(React, require('react-dom'), 1000);
}
```

## 📝 Checklist d'Implémentation

- [ ] Ajouter les attributs ARIA manquants
- [ ] Vérifier tous les contrastes de couleurs
- [ ] Implémenter la navigation au clavier
- [ ] Ajouter le lazy loading sur toutes les images
- [ ] Convertir les images en WebP avec fallback
- [ ] Améliorer les attributs alt des images
- [ ] Ajouter les micro-interactions
- [ ] Implémenter la validation du formulaire
- [ ] Ajouter la protection anti-spam (honeypot)
- [ ] Configurer Google Analytics
- [ ] Ajouter les données structurées JSON-LD
- [ ] Implémenter le breadcrumb
- [ ] Ajouter le dark mode (optionnel)
- [ ] Implémenter le Service Worker pour PWA
- [ ] Optimiser le code splitting
- [ ] Tester avec Lighthouse
- [ ] Tester l'accessibilité avec WAVE

---

**Note** : Ces recommandations doivent être adaptées selon votre architecture Next.js (App Router vs Pages Router).

