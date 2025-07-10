#!/bin/bash

# Vercel Deployment Script for Luma Labs Playground

echo "🚀 Deploying Luma Labs Playground to Vercel..."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI not found. Installing globally..."
    npm install -g vercel
fi

# Login to Vercel (if not already logged in)
echo "🔐 Checking Vercel authentication..."
vercel whoami || vercel login

# Deploy to Vercel
echo "📦 Deploying to Vercel..."
vercel --prod --name wajid-lumalabs-playground

echo "✅ Deployment complete!"
echo "🌐 Your app should be live at: https://wajid-lumalabs-playground.vercel.app"
echo ""
echo "⚠️  Don't forget to add your LUMA_API_KEY environment variable in Vercel dashboard!"
echo "   1. Go to your Vercel project dashboard"
echo "   2. Navigate to Settings > Environment Variables"
echo "   3. Add: LUMA_API_KEY = your_actual_api_key"
echo "   4. Redeploy if needed"
