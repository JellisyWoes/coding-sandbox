# Hello Server (Bun.js)

This project is a simple HTTP server built with [Bun](https://bun.sh) that responds with "Hello, World!" when accessed. The server runs on port 3000 by default.

## 🚀 Getting Started

Follow these instructions to set up and run the server on your local machine.

### Prerequisites

You need to have **Bun** installed. If Bun is not installed, follow the installation instructions from the official Bun website: [https://bun.sh](https://bun.sh).

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/hello-server.git
   ```
   
2. Navigate to the project directory:
   ```bash
   cd hello-server
   ```

3. Install dependencies (if there are any in future projects):
   ```bash
   bun install
   ```

### Usage

To start the server:

1. Run the following command:
   ```bash
   bun hello-server.js
   ```

2. The server will be running at [http://localhost:3000](http://localhost:3000). You can access this URL in your browser or use a tool like `curl`:
   ```bash
   curl http://localhost:3000
   ```

   You should see the output:
   ```
   Hello, World!
   ```

### Customization

You can modify the server port or response message by editing the `hello-server.js` file. For example, to change the port:

```javascript
port: 4000, // Server will now listen on port 4000
```