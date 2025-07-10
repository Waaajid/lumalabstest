const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const axios = require('axios');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Configure multer for file uploads
const upload = multer({
    dest: 'uploads/',
    limits: {
        fileSize: 100 * 1024 * 1024 // 100MB limit
    }
});

// Ensure uploads directory exists
if (!fs.existsSync('uploads')) {
    fs.mkdirSync('uploads');
}

// Luma Labs API configuration
const LUMA_API_BASE_URL = 'https://api.lumalabs.ai/dream-machine/v1';

// API Routes

// Test API key endpoint
app.get('/api/test-key', async (req, res) => {
    try {
        const apiKey = req.headers['x-api-key'] || process.env.LUMA_API_KEY;
        
        if (!apiKey) {
            return res.status(400).json({ 
                success: false, 
                error: 'API key is required' 
            });
        }

        // Test the API key by making a simple request
        const response = await axios.get(`${LUMA_API_BASE_URL}/ping`, {
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            }
        });

        res.json({ 
            success: true, 
            message: 'API key is valid',
            data: response.data 
        });
    } catch (error) {
        console.error('API key test error:', error.response?.data || error.message);
        res.status(error.response?.status || 500).json({ 
            success: false, 
            error: error.response?.data?.message || 'Failed to validate API key' 
        });
    }
});

// Generate video from text
app.post('/api/generate-video', async (req, res) => {
    try {
        const { prompt, aspect_ratio = '16:9', loop = false, model = 'ray-1-6' } = req.body;
        const apiKey = req.headers['x-api-key'] || process.env.LUMA_API_KEY;

        if (!apiKey) {
            return res.status(400).json({ 
                success: false, 
                error: 'API key is required' 
            });
        }

        if (!prompt) {
            return res.status(400).json({ 
                success: false, 
                error: 'Prompt is required' 
            });
        }

        const requestData = {
            model: model,
            prompt: prompt,
            aspect_ratio: aspect_ratio,
            loop: loop
        };

        console.log('Generating video with data:', requestData);
        const startTime = Date.now();

        const response = await axios.post(`${LUMA_API_BASE_URL}/generations/video`, requestData, {
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            }
        });

        // Add timing information to response
        const responseData = {
            ...response.data,
            timing: {
                started_at: new Date(startTime).toISOString(),
                request_duration_ms: Date.now() - startTime
            }
        };

        res.json({ 
            success: true, 
            data: responseData 
        });
    } catch (error) {
        console.error('Video generation error:', error.response?.data || error.message);
        res.status(error.response?.status || 500).json({ 
            success: false, 
            error: error.response?.data?.message || 'Failed to generate video' 
        });
    }
});

// Generate video from image + text
app.post('/api/generate-video-from-image', upload.single('image'), async (req, res) => {
    try {
        const { prompt, aspect_ratio = '16:9', loop = false, model = 'ray-1-6' } = req.body;
        const apiKey = req.headers['x-api-key'] || process.env.LUMA_API_KEY;

        if (!apiKey) {
            return res.status(400).json({ 
                success: false, 
                error: 'API key is required' 
            });
        }

        if (!prompt) {
            return res.status(400).json({ 
                success: false, 
                error: 'Prompt is required' 
            });
        }

        if (!req.file) {
            return res.status(400).json({ 
                success: false, 
                error: 'Image file is required' 
            });
        }

        // Convert image to base64
        const imageBuffer = fs.readFileSync(req.file.path);
        const imageBase64 = imageBuffer.toString('base64');
        const mimeType = req.file.mimetype;

        const requestData = {
            model: model,
            prompt: prompt,
            aspect_ratio: aspect_ratio,
            loop: loop,
            keyframes: {
                frame0: {
                    type: 'image',
                    url: `data:${mimeType};base64,${imageBase64}`
                }
            }
        };

        console.log('Generating video from image with prompt:', prompt);
        const startTime = Date.now();

        const response = await axios.post(`${LUMA_API_BASE_URL}/generations/video`, requestData, {
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            }
        });

        // Clean up uploaded file
        fs.unlinkSync(req.file.path);

        // Add timing information to response
        const responseData = {
            ...response.data,
            timing: {
                started_at: new Date(startTime).toISOString(),
                request_duration_ms: Date.now() - startTime
            }
        };

        res.json({ 
            success: true, 
            data: responseData 
        });
    } catch (error) {
        console.error('Video generation from image error:', error.response?.data || error.message);
        
        // Clean up uploaded file in case of error
        if (req.file && fs.existsSync(req.file.path)) {
            fs.unlinkSync(req.file.path);
        }

        res.status(error.response?.status || 500).json({ 
            success: false, 
            error: error.response?.data?.message || 'Failed to generate video from image' 
        });
    }
});

// Get generation status
app.get('/api/generation/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const apiKey = req.headers['x-api-key'] || process.env.LUMA_API_KEY;

        if (!apiKey) {
            return res.status(400).json({ 
                success: false, 
                error: 'API key is required' 
            });
        }

        const response = await axios.get(`${LUMA_API_BASE_URL}/generations/${id}`, {
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            }
        });

        res.json({ 
            success: true, 
            data: response.data 
        });
    } catch (error) {
        console.error('Get generation error:', error.response?.data || error.message);
        res.status(error.response?.status || 500).json({ 
            success: false, 
            error: error.response?.data?.message || 'Failed to get generation status' 
        });
    }
});

// Get all generations
app.get('/api/generations', async (req, res) => {
    try {
        const apiKey = req.headers['x-api-key'] || process.env.LUMA_API_KEY;

        if (!apiKey) {
            return res.status(400).json({ 
                success: false, 
                error: 'API key is required' 
            });
        }

        const response = await axios.get(`${LUMA_API_BASE_URL}/generations`, {
            headers: {
                'Authorization': `Bearer ${apiKey}`,
                'Content-Type': 'application/json'
            }
        });

        res.json({ 
            success: true, 
            data: response.data 
        });
    } catch (error) {
        console.error('Get generations error:', error.response?.data || error.message);
        res.status(error.response?.status || 500).json({ 
            success: false, 
            error: error.response?.data?.message || 'Failed to get generations' 
        });
    }
});

// Serve the main page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Start server
app.listen(PORT, () => {
    console.log(`🚀 Luma Labs Playground running on http://localhost:${PORT}`);
    console.log(`📝 Make sure to set your LUMA_API_KEY in the .env file`);
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\n👋 Shutting down gracefully...');
    process.exit(0);
});
