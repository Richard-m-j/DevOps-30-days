# Dockerfile Best Practices Implemented

- **Use multi-stage builds**: This allows you to use one stage with all the build-time dependencies to compile your application, and a final, separate stage with only the necessary runtime dependencies, resulting in a much smaller and more secure final image.

- **Utilize `.dockerignore`**: Create a `.dockerignore` file to exclude files and directories not needed for the build

- **Harden security by creating a non-root user**: Avoid running containers as the `root` user. 

- **Combine user permissions with the `COPY` command**: Use the `--chown` flag with `COPY` instructions to set the ownership of files and directories as they are copied into the image, reducing the need for extra `RUN chown` layers.

- **Use light, stable base images**: Start with a minimal and stable base image for your runtime stage, such as `alpine`, `slim`, to reduce the attack surface and final image size.

- **Declare build-time arguments**: Use `ARG` to pass build-time variables like architecture, OS, or application version. This makes your Dockerfile more flexible and portable.

- **Consolidate environment variables**: Declare all environment variables in a single `ENV` layer. You can use a backslash (`\`) to separate logical groups for better readability.

- **Leverage layer caching**: place instructions that change less frequently (like installing dependencies) before instructions that change more frequently (like copying source code) to make the most of Docker's build cache.

- **Remove unnecessary cache**: After installing packages, clean up cache files from package managers within the same `RUN` layer to reduce image size.

- **Use `npm ci` for Node.js project**: Prefer `npm ci` over `npm install`. It provides faster and more reliable builds by using the `package-lock.json` file to install the same dependency versions every time.

- **Add labels for metadata**: Use the `LABEL` instruction to add metadata to your image, such as version, or a link to the source repository. This helps with image management and organization.
