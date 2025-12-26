#!/bin/bash

# ============================================
# Script d'optimisation d'images pour BDCForce
# Convertit les images en WebP et optimise
# ============================================

echo "🖼️  Optimisation des images pour BDCForce..."

# Vérifier si ImageMagick et cwebp sont installés
if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick n'est pas installé. Installation..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install imagemagick
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get install imagemagick -y
    fi
fi

if ! command -v cwebp &> /dev/null; then
    echo "❌ WebP tools n'est pas installé. Installation..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install webp
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get install webp -y
    fi
fi

# Créer le dossier pour les images WebP
mkdir -p img/webp
mkdir -p img/portfolio/webp
mkdir -p img/intro-carousel/webp
mkdir -p img/team/webp
mkdir -p img/certifications/webp

# Fonction pour convertir une image en WebP
convert_to_webp() {
    local input_file=$1
    local output_file=$2
    local quality=${3:-85}
    
    if [ -f "$input_file" ]; then
        # Obtenir le nom de base sans extension
        local base_name=$(basename "$input_file" | sed 's/\.[^.]*$//')
        local dir_name=$(dirname "$input_file")
        
        # Créer le dossier de sortie correspondant
        local output_dir="${dir_name}/webp"
        mkdir -p "$output_dir"
        
        # Convertir en WebP
        cwebp -q "$quality" "$input_file" -o "${output_dir}/${base_name}.webp" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo "✅ Converti: $input_file -> ${output_dir}/${base_name}.webp"
        else
            echo "❌ Erreur lors de la conversion: $input_file"
        fi
    fi
}

# Optimiser les images principales
echo "📸 Conversion des images principales..."
for img in img/*.jpg img/*.png; do
    if [ -f "$img" ]; then
        convert_to_webp "$img" 85
        # Optimiser aussi l'image originale avec ImageMagick
        convert "$img" -strip -quality 85 -resize '1920x1080>' "$img"
    fi
done

# Optimiser les images du portfolio
echo "📁 Conversion des images du portfolio..."
for img in img/portfolio/*.jpg img/portfolio/*.png; do
    if [ -f "$img" ]; then
        convert_to_webp "$img" 85
        convert "$img" -strip -quality 85 -resize '1200x800>' "$img"
    fi
done

# Optimiser les images du carousel
echo "🎠 Conversion des images du carousel..."
for img in img/intro-carousel/*.jpg img/intro-carousel/*.png; do
    if [ -f "$img" ]; then
        convert_to_webp "$img" 90
        convert "$img" -strip -quality 90 -resize '1920x1080>' "$img"
    fi
done

# Optimiser les images de l'équipe
echo "👥 Conversion des images de l'équipe..."
for img in img/team/*.jpg img/team/*.png; do
    if [ -f "$img" ]; then
        convert_to_webp "$img" 85
        convert "$img" -strip -quality 85 -resize '800x800>' "$img"
    fi
done

# Optimiser les certifications
echo "🏆 Conversion des certifications..."
for img in img/certifications/*.jpg img/certifications/*.png; do
    if [ -f "$img" ]; then
        convert_to_webp "$img" 90
        convert "$img" -strip -quality 90 -resize '1200x1200>' "$img"
    fi
done

echo ""
echo "✨ Optimisation terminée !"
echo "📊 Statistiques:"
echo "   - Images WebP créées dans les dossiers /webp"
echo "   - Images originales optimisées"
echo ""
echo "💡 Pour utiliser les images WebP dans votre code HTML, utilisez:"
echo "   <picture>"
echo "     <source srcset=\"/img/webp/image.webp\" type=\"image/webp\">"
echo "     <img src=\"/img/image.jpg\" alt=\"Description\">"
echo "   </picture>"

