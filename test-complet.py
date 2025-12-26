#!/usr/bin/env python3
"""
Script de test complet pour BDCForce
Vérifie la cohérence, les liens, les images, etc.
"""

import os
import re
import json
import sys
from pathlib import Path
from urllib.parse import urlparse
from html.parser import HTMLParser

class LinkExtractor(HTMLParser):
    """Extracteur de liens et images depuis le HTML"""
    def __init__(self):
        super().__init__()
        self.links = []
        self.images = []
        self.scripts = []
        self.stylesheets = []
        
    def handle_starttag(self, tag, attrs):
        attrs_dict = dict(attrs)
        
        if tag == 'a' and 'href' in attrs_dict:
            self.links.append(attrs_dict['href'])
        elif tag == 'img' and 'src' in attrs_dict:
            self.images.append(attrs_dict['src'])
        elif tag == 'script' and 'src' in attrs_dict:
            self.scripts.append(attrs_dict['src'])
        elif tag == 'link' and 'rel' in attrs_dict and attrs_dict.get('rel') == 'stylesheet':
            if 'href' in attrs_dict:
                self.stylesheets.append(attrs_dict['href'])

class SiteTester:
    def __init__(self, base_dir='.'):
        self.base_dir = Path(base_dir)
        self.errors = []
        self.warnings = []
        self.successes = []
        
    def log_error(self, message):
        self.errors.append(message)
        print(f"❌ ERREUR: {message}")
        
    def log_warning(self, message):
        self.warnings.append(message)
        print(f"⚠️  AVERTISSEMENT: {message}")
        
    def log_success(self, message):
        self.successes.append(message)
        print(f"✅ {message}")
        
    def test_file_exists(self, filepath):
        """Vérifie qu'un fichier existe"""
        full_path = self.base_dir / filepath
        if full_path.exists():
            self.log_success(f"Fichier présent: {filepath}")
            return True
        else:
            self.log_error(f"Fichier manquant: {filepath}")
            return False
            
    def test_image_exists(self, img_path):
        """Vérifie qu'une image existe"""
        # Nettoyer le chemin (enlever les paramètres de requête, etc.)
        clean_path = img_path.split('?')[0].split('#')[0]
        
        # Ignorer les images externes
        if clean_path.startswith('http://') or clean_path.startswith('https://'):
            return True
            
        full_path = self.base_dir / clean_path.lstrip('/')
        if full_path.exists():
            self.log_success(f"Image présente: {clean_path}")
            return True
        else:
            self.log_error(f"Image manquante: {clean_path}")
            return False
            
    def test_html_structure(self):
        """Teste la structure HTML"""
        index_path = self.base_dir / 'index.html'
        if not index_path.exists():
            self.log_error("index.html n'existe pas")
            return
            
        with open(index_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Vérifier les sections
        sections = ['intro', 'services', 'portfolio', 'about', 'team', 'testimonials', 'contact']
        for section in sections:
            if f'id="{section}"' in content or f"id='{section}'" in content:
                self.log_success(f"Section trouvée: #{section}")
            else:
                self.log_warning(f"Section non trouvée: #{section}")
                
        # Vérifier les métadonnées
        if '<title>' in content:
            self.log_success("Balise <title> présente")
        else:
            self.log_error("Balise <title> manquante")
            
        if 'meta name="description"' in content or "meta name='description'" in content:
            self.log_success("Meta description présente")
        else:
            self.log_error("Meta description manquante")
            
        if 'application/ld+json' in content:
            self.log_success("Données structurées JSON-LD présentes")
        else:
            self.log_warning("Données structurées JSON-LD manquantes")
            
        # Extraire les liens et images
        parser = LinkExtractor()
        parser.feed(content)
        
        # Vérifier les images
        print("\n🖼️  Vérification des images...")
        for img in parser.images:
            self.test_image_exists(img)
            
        # Vérifier les liens internes
        print("\n🔗 Vérification des liens internes...")
        for link in parser.links:
            if link.startswith('#') or link.startswith('/') or not link.startswith('http'):
                if link.startswith('#'):
                    section = link[1:]
                    if section in sections:
                        self.log_success(f"Lien interne valide: {link}")
                    else:
                        self.log_warning(f"Lien interne vers section inconnue: {link}")
                        
    def test_config_files(self):
        """Teste les fichiers de configuration"""
        print("\n⚙️  Vérification des fichiers de configuration...")
        
        # .htaccess
        htaccess_path = self.base_dir / '.htaccess'
        if htaccess_path.exists():
            with open(htaccess_path, 'r') as f:
                content = f.read()
                if 'RewriteEngine On' in content:
                    self.log_success(".htaccess: RewriteEngine activé")
                if 'mod_deflate' in content:
                    self.log_success(".htaccess: Compression configurée")
        else:
            self.log_warning(".htaccess non trouvé")
            
        # robots.txt
        robots_path = self.base_dir / 'robots.txt'
        if robots_path.exists():
            with open(robots_path, 'r') as f:
                content = f.read()
                if 'Sitemap:' in content:
                    self.log_success("robots.txt: Sitemap référencé")
        else:
            self.log_warning("robots.txt non trouvé")
            
        # sitemap.xml
        sitemap_path = self.base_dir / 'sitemap.xml'
        if sitemap_path.exists():
            with open(sitemap_path, 'r') as f:
                content = f.read()
                if '<?xml' in content:
                    self.log_success("sitemap.xml: Format XML valide")
                else:
                    self.log_error("sitemap.xml: Format XML invalide")
        else:
            self.log_warning("sitemap.xml non trouvé")
            
        # manifest.json
        manifest_path = self.base_dir / 'manifest.json'
        if manifest_path.exists():
            try:
                with open(manifest_path, 'r') as f:
                    json.load(f)
                self.log_success("manifest.json: JSON valide")
            except json.JSONDecodeError:
                self.log_error("manifest.json: JSON invalide")
        else:
            self.log_warning("manifest.json non trouvé")
            
    def test_essential_files(self):
        """Teste les fichiers essentiels"""
        print("\n📁 Vérification des fichiers essentiels...")
        
        essential_files = [
            'index.html',
            '.htaccess',
            'robots.txt',
            'sitemap.xml',
            'manifest.json',
            'favicon.ico'
        ]
        
        for file in essential_files:
            self.test_file_exists(file)
            
    def run_all_tests(self):
        """Exécute tous les tests"""
        print("🔍 Test complet du site BDCForce")
        print("=" * 50)
        print()
        
        self.test_essential_files()
        self.test_config_files()
        self.test_html_structure()
        
        # Résumé
        print("\n" + "=" * 50)
        print("📋 Résumé des tests")
        print("=" * 50)
        print()
        print(f"✅ Succès: {len(self.successes)}")
        print(f"⚠️  Avertissements: {len(self.warnings)}")
        print(f"❌ Erreurs: {len(self.errors)}")
        print()
        
        if len(self.errors) == 0 and len(self.warnings) == 0:
            print("🎉 Tous les tests sont passés avec succès !")
            print("Le site est prêt pour le déploiement.")
            return 0
        elif len(self.errors) == 0:
            print("⚠️  Des avertissements ont été détectés.")
            print("Le site peut être déployé, mais vérifiez les avertissements.")
            return 0
        else:
            print("❌ Des erreurs ont été détectées.")
            print("Veuillez corriger les erreurs avant le déploiement.")
            return 1

if __name__ == '__main__':
    base_dir = sys.argv[1] if len(sys.argv) > 1 else '.'
    tester = SiteTester(base_dir)
    sys.exit(tester.run_all_tests())

