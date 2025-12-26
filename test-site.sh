#!/bin/bash

# ============================================
# Script de Test Local pour BDCForce
# Vérifie la cohérence du site avant déploiement
# ============================================

echo "🔍 Test du site BDCForce - Analyse de cohérence"
echo "================================================"
echo ""

ERRORS=0
WARNINGS=0

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour compter les erreurs
error() {
    echo -e "${RED}❌ ERREUR:${NC} $1"
    ((ERRORS++))
}

warning() {
    echo -e "${YELLOW}⚠️  AVERTISSEMENT:${NC} $1"
    ((WARNINGS++))
}

success() {
    echo -e "${GREEN}✅${NC} $1"
}

# ============================================
# 1. Vérification des fichiers essentiels
# ============================================
echo "📁 Vérification des fichiers essentiels..."
echo ""

ESSENTIAL_FILES=(
    "index.html"
    ".htaccess"
    "robots.txt"
    "sitemap.xml"
    "manifest.json"
    "favicon.ico"
)

for file in "${ESSENTIAL_FILES[@]}"; do
    if [ -f "$file" ]; then
        success "Fichier présent: $file"
    else
        error "Fichier manquant: $file"
    fi
done

echo ""

# ============================================
# 2. Vérification des images référencées
# ============================================
echo "🖼️  Vérification des images..."
echo ""

# Extraire les chemins d'images du HTML (approximation)
IMAGES=(
    "img/logo-web-transparent.png"
    "img/intro-carousel/1.jpg"
    "img/portfolio/Communication.jpg"
    "img/portfolio/automation.jpg"
    "img/portfolio/skills.jpg"
    "img/portfolio/process.jpg"
    "img/portfolio/Security.jpg"
    "img/portfolio/Gest-Doc.jpg"
    "img/portfolio/Datas.jpg"
    "img/portfolio/Application.jpg"
    "img/photo-perso1.jpg"
    "img/michel-romanet.jpg"
    "img/sylvain-leguay.jpg"
    "img/team/delalin.jpg"
    "favicon.ico"
)

for img in "${IMAGES[@]}"; do
    if [ -f "$img" ]; then
        success "Image présente: $img"
    else
        error "Image manquante: $img"
    fi
done

echo ""

# ============================================
# 3. Vérification des sections HTML
# ============================================
echo "📄 Vérification de la structure HTML..."
echo ""

if [ -f "index.html" ]; then
    # Vérifier les sections principales
    SECTIONS=(
        "#intro"
        "#services"
        "#portfolio"
        "#about"
        "#team"
        "#testimonials"
        "#contact"
    )
    
    for section in "${SECTIONS[@]}"; do
        if grep -q "id=\"${section#\#}\"" index.html || grep -q "id='${section#\#}'" index.html; then
            success "Section trouvée: $section"
        else
            warning "Section non trouvée: $section"
        fi
    done
    
    # Vérifier les métadonnées
    if grep -q "<title>" index.html; then
        success "Balise <title> présente"
    else
        error "Balise <title> manquante"
    fi
    
    if grep -q "meta name=\"description\"" index.html; then
        success "Meta description présente"
    else
        error "Meta description manquante"
    fi
    
    if grep -q "application/ld+json" index.html; then
        success "Données structurées JSON-LD présentes"
    else
        warning "Données structurées JSON-LD manquantes"
    fi
fi

echo ""

# ============================================
# 4. Vérification des fichiers de configuration
# ============================================
echo "⚙️  Vérification des fichiers de configuration..."
echo ""

# Vérifier .htaccess
if [ -f ".htaccess" ]; then
    if grep -q "RewriteEngine On" .htaccess; then
        success ".htaccess: RewriteEngine activé"
    else
        warning ".htaccess: RewriteEngine non trouvé"
    fi
    
    if grep -q "mod_deflate" .htaccess; then
        success ".htaccess: Compression configurée"
    else
        warning ".htaccess: Compression non configurée"
    fi
fi

# Vérifier robots.txt
if [ -f "robots.txt" ]; then
    if grep -q "Sitemap:" robots.txt; then
        success "robots.txt: Sitemap référencé"
    else
        warning "robots.txt: Sitemap non référencé"
    fi
fi

# Vérifier sitemap.xml
if [ -f "sitemap.xml" ]; then
    if grep -q "<?xml" sitemap.xml; then
        success "sitemap.xml: Format XML valide"
    else
        error "sitemap.xml: Format XML invalide"
    fi
fi

# Vérifier manifest.json
if [ -f "manifest.json" ]; then
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool manifest.json > /dev/null 2>&1; then
            success "manifest.json: JSON valide"
        else
            error "manifest.json: JSON invalide"
        fi
    else
        warning "Python3 non disponible, impossible de valider manifest.json"
    fi
fi

echo ""

# ============================================
# 5. Vérification de la taille des fichiers
# ============================================
echo "📊 Vérification de la taille des fichiers..."
echo ""

if [ -f "index.html" ]; then
    SIZE=$(wc -c < index.html)
    SIZE_MB=$(echo "scale=2; $SIZE / 1024 / 1024" | bc)
    
    if (( $(echo "$SIZE_MB < 1" | bc -l) )); then
        success "index.html: Taille OK ($SIZE_MB MB)"
    else
        warning "index.html: Taille importante ($SIZE_MB MB) - considérer l'optimisation"
    fi
fi

echo ""

# ============================================
# 6. Vérification des liens externes
# ============================================
echo "🔗 Vérification des liens externes..."
echo ""

if [ -f "index.html" ]; then
    # Extraire les URLs externes
    EXTERNAL_LINKS=(
        "https://www.linkedin.com/company/bdcforce"
        "https://fr.linkedin.com/in/delalin-baptiste"
        "https://calendly.com/bdcforce"
    )
    
    for link in "${EXTERNAL_LINKS[@]}"; do
        if grep -q "$link" index.html; then
            success "Lien externe trouvé: $link"
        else
            warning "Lien externe non trouvé: $link"
        fi
    done
fi

echo ""

# ============================================
# 7. Résumé
# ============================================
echo "================================================"
echo "📋 Résumé des tests"
echo "================================================"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ Tous les tests sont passés avec succès !${NC}"
    echo ""
    echo "Le site est prêt pour le déploiement."
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  $WARNINGS avertissement(s) détecté(s)${NC}"
    echo ""
    echo "Le site peut être déployé, mais vérifiez les avertissements."
    exit 0
else
    echo -e "${RED}❌ $ERRORS erreur(s) et $WARNINGS avertissement(s) détecté(s)${NC}"
    echo ""
    echo "Veuillez corriger les erreurs avant le déploiement."
    exit 1
fi

