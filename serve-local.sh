#!/bin/bash

# ============================================
# Serveur Local Simple pour Tester BDCForce
# ============================================

PORT=${1:-8000}
DIRECTORY=${2:-.}

echo "🚀 Démarrage du serveur local pour BDCForce"
echo "============================================"
echo ""
echo "📁 Répertoire: $(pwd)"
echo "🌐 URL: http://localhost:$PORT"
echo "📄 Page d'accueil: http://localhost:$PORT/index.html"
echo ""
echo "Appuyez sur Ctrl+C pour arrêter le serveur"
echo ""

# Vérifier si Python est disponible
if command -v python3 &> /dev/null; then
    echo "✅ Utilisation de Python 3"
    python3 -m http.server $PORT --directory $DIRECTORY
elif command -v python &> /dev/null; then
    echo "✅ Utilisation de Python 2"
    python -m SimpleHTTPServer $PORT
elif command -v php &> /dev/null; then
    echo "✅ Utilisation de PHP"
    php -S localhost:$PORT -t $DIRECTORY
elif command -v ruby &> /dev/null; then
    echo "✅ Utilisation de Ruby"
    ruby -run -e httpd $DIRECTORY -p $PORT
else
    echo "❌ Aucun serveur HTTP trouvé (Python, PHP, Ruby)"
    echo ""
    echo "Veuillez installer l'un des outils suivants :"
    echo "  - Python 3: brew install python3 (macOS)"
    echo "  - PHP: brew install php (macOS)"
    echo "  - Ruby: généralement pré-installé"
    exit 1
fi

