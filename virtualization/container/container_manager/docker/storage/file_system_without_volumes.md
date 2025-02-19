# filesystem without volumes

This document will explain how file are stored in docker when not using volume to map them on specific path on the host.

In a Docker container, the file system is isolated from the host system. Each container has its own file system that is separate from the host file system. However, without using volumes, Docker relies on a copy-on-write file system to manage container file storage.

1. **Image Layers:**
   - Docker images are composed of multiple layers, each representing a set of file system changes. These layers are read-only and are stacked on top of each other to form the complete image. When you run a container, Docker creates a writable container layer on top of the read-only image layers.

2. **Copy-on-Write (CoW):**
   - When a container writes to its file system, Docker uses a copy-on-write mechanism. This means that instead of modifying the existing file on the image layer directly, Docker creates a copy of the file in the container's writable layer. This ensures that changes made by a container do not affect the original image.

3. **Container File System:**
   - The container's file system is initially based on the image layers, and changes made during container runtime are stored in the container's writable layer. This allows each container to have its own isolated file system, and changes made in one container do not affect others using the same image.

4. **Persistency During Runtime:**
   - Changes made to the container's file system during runtime are persisted as long as the container is running. However, once the container is stopped and removed, the changes made in its writable layer are lost. The original image layers remain unchanged.

