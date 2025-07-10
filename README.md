# Luma Labs API Playground

A beautiful, modern web-based playground for testing Luma Labs text-to-video API functionality.

## 🌟 Features

- ✨ **Text to Video Generation** - Generate videos from text prompts
- 🖼️ **Image to Video Generation** - Animate images with text prompts
- 🔑 **API Key Testing** - Validate your Luma Labs API keys
- 📊 **Real-time Status Updates** - Monitor generation progress
- ⏱️ **Live Timing Display** - Real-time elapsed timer and generation duration
- 🎯 **Detailed Timing Info** - Request duration and total generation time
- 📱 **Responsive Design** - Works on desktop and mobile
- 🎛️ **Customizable Options** - Aspect ratios, looping, and more
- 📋 **Generation History** - View and manage recent generations

## 🚀 Live Demo

Visit the live application: [Luma Labs Playground](https://your-vercel-url.vercel.app)

## 🛠️ Local Development

### Prerequisites

- Node.js (v14 or higher)
- A valid Luma Labs API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/luma-labs-playground.git
   cd luma-labs-playground
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up your API key**
   ```bash
   cp .env.example .env
   ```
   
   Edit the `.env` file and add your Luma Labs API key:
   ```
   LUMA_API_KEY=your_actual_api_key_here
   PORT=3000
   ```

4. **Start the development server**
   ```bash
   npm run dev
   ```

5. **Open your browser**
   Navigate to `http://localhost:3000`

## 🎨 Design

- **Clean white interface** with light red accents
- **Modern card-based layout** with subtle shadows
- **Responsive grid system** that works on all devices
- **Intuitive user experience** with real-time feedback

## 📝 Usage

### Setting Up Your API Key

1. Enter your Luma Labs API key in the "API Configuration" section
2. Click "Test Key" to validate your key
3. Once validated, you can start generating videos

### Text to Video

1. Enter a descriptive prompt for your video
2. Choose aspect ratio (16:9, 9:16, 1:1, 4:3, or 21:9)
3. Optionally enable looping
4. Click "Generate Video"

### Image to Video

1. Upload an image (PNG, JPG, GIF up to 100MB)
2. Enter a prompt describing how the image should animate
3. Choose aspect ratio and loop settings
4. Click "Generate Video from Image"

## 🔧 API Endpoints

- `GET /api/test-key` - Test API key validity
- `POST /api/generate-video` - Generate video from text
- `POST /api/generate-video-from-image` - Generate video from image + text
- `GET /api/generation/:id` - Get generation status
- `GET /api/generations` - List recent generations

## 💡 Tips for Best Results

### Text Prompts
- Be descriptive and specific
- Include camera movements: "camera zooms in", "slow pan left"
- Mention lighting: "golden hour", "dramatic lighting"
- Describe actions: "person walking towards camera"

### Image to Video
- Use high-quality images for better results
- Ensure the main subject is clearly visible
- Describe the desired motion in your prompt
- Consider the image composition for the chosen aspect ratio

## 🚀 Deployment

This application is deployed on Vercel for seamless hosting and automatic deployments.

### Deploy to Vercel

1. Fork this repository
2. Connect your GitHub account to Vercel
3. Import the project from your GitHub
4. Add your `LUMA_API_KEY` environment variable in Vercel settings
5. Deploy!

## 🔒 Environment Variables

- `LUMA_API_KEY` - Your Luma Labs API key (required)
- `PORT` - Port for local development (default: 3000)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

MIT License - feel free to modify and use as needed!

## 🆘 Support

For Luma Labs API specific issues, refer to their official documentation or support channels.

---

**Happy video generating! 🎬✨**
