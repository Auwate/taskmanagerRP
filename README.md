# Task Manager Reverse Proxy

## Overview
The **Task Manager Reverse Proxy** is an NGINX-based reverse proxy designed to facilitate secure HTTPS communication across microservices using a unified domain name. This setup ensures that all frontend and backend services operate under a **single origin**, preventing CORS issues and enabling seamless cookie-based authentication.

## Features
- **Single-Origin Communication**: Routes requests from a unified domain, preventing CORS-related issues.
- **Secure Cookie Handling**: Supports `Secure`, `HttpOnly`, and `SameSite` cookie policies for authentication.
- **HTTPS Support**: Configured to handle TLS termination for encrypted connections.
- **Load Balancing (Optional)**: Can be extended to distribute traffic efficiently.
- **Dockerized Deployment**: Runs as a lightweight container for easy scalability and management.

## Why Use a Reverse Proxy?
In a microservice architecture, different services (e.g., frontend, authentication, backend) may be deployed on separate machines or cloud instances. However, browsers enforce **Same-Origin Policy (SOP)**, which prevents cross-origin requests unless explicitly allowed via **CORS headers**.

By routing all requests through a **single domain (e.g., apps.example.com)**, the reverse proxy ensures that:
- **CORS checks are not triggered** because the frontend and backend share the same origin.
- **Cookies can be securely shared** across services since they are scoped to the same domain.
- **Microservices remain hidden** from the public, improving security.

## Architecture
```
User → Reverse Proxy (NGINX) → Microservices

Frontend (React) → / → Forwarded to frontend service
Auth Service → /auth → Forwarded to authentication microservice
Task Service → /tasks → Forwarded to backend task microservice
```

### Example Flow:
1. **User visits** `apps.example.com`, which serves the React frontend.
2. **Frontend makes a request** to `apps.example.com/auth/login` to authenticate.
3. **Auth service responds with a cookie**, which is stored under `.example.com`.
4. **User requests tasks** via `apps.example.com/tasks`, and the cookie is automatically sent with the request.
5. **Backend verifies the cookie**, ensuring authentication and authorization.

## Setup & Deployment
### Prerequisites
- Docker
- NGINX
- A registered domain name
- TLS certificates (e.g., Let’s Encrypt)

### Running the Proxy
The application relies heavily on GitHub secrets to provide environment variables to the Docker container. However, in the situation where this is not possible, then:

1. Clone the repository:
   ```sh
   git clone https://github.com/Auwate/taskmanagerrp.git
   cd taskmanagerrp/
   ```
2. Build the Dockerfile
3. Run the Docker container with appropriate environment variables:
   ```sh
   docker run -p 443:443 -e <...> taskmanagerrp
   ```

## Security Considerations
- **Ensure cookies are set with `Secure; HttpOnly; SameSite=Strict|Lax`** to prevent unauthorized access.
- **Enforce HTTPS** to protect data in transit.
- **Use proper authentication** between microservices (e.g., JWT, session-based authentication).