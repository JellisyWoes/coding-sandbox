// Import Bun's HTTP server functionality
const server = Bun.serve({
  port: 3000, // Server listens on port 3000
  fetch(req) {
    return new Response("Hello, World!", {
      headers: { "Content-Type": "text/plain" },
    });
  },
});

console.log(`Server running at http://localhost:${server.port}`);
