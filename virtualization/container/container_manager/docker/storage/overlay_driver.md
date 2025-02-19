# overlay driver (in docker)

This file will explain what is the overlay driver and how it briefly work at storing container data.

## overlay driver

The OverlayFS (Overlay File System) is a union filesystem that is used as a storage driver in container runtimes, including Docker. OverlayFS allows multiple layers to be stacked on top of one another, presenting a unified and coherent view of the file system. This union of file systems is essential for containerization as it enables efficient layering of images, copy-on-write semantics, and the ability to share common layers among multiple containers.

Here are some key aspects of the OverlayFS driver:

1. **Layered File System:**
   - OverlayFS enables a layered file system approach. Each layer represents a set of file system changes, and these layers can be combined to create a composite file system. This is particularly useful in containerization where images are composed of multiple layers, and containers can share common layers to save disk space.

2. **Copy-on-Write (CoW):**
   - OverlayFS uses a copy-on-write mechanism, meaning that when changes are made to a file in a container, a copy of the original file is created in the container's writable layer. This allows for efficient use of disk space as only the modified files need to be stored separately.

3. **Efficient Image Distribution:**
   - The layered structure of OverlayFS facilitates efficient distribution of container images. Common base layers can be shared among different images, reducing the amount of data that needs to be transferred over the network when pulling images.

4. **Speed and Performance:**
   - OverlayFS is designed for speed and performance, making it a suitable choice for container workloads. The layered approach allows for quick container start-up times as only the necessary layers need to be combined.

5. **Compatibility and Integration:**
   - OverlayFS is a standard part of the Linux kernel, making it widely available and well-integrated with the Linux ecosystem. Docker, containerd, and other container runtimes use OverlayFS as a storage driver by default on many Linux distributions.

6. **Union Mount:**
   - OverlayFS creates a union mount, which is a mount point where the content of multiple file systems is visible simultaneously. The union mount allows a container to see a unified view of the file system created from the combination of image layers.

It's worth noting that OverlayFS is just one of several storage drivers supported by Docker, and the choice of the storage driver can depend on factors such as the Linux distribution, kernel version, and specific requirements of the containerized application.

While OverlayFS has been widely adopted and is the default storage driver in many Docker installations, there are alternative storage drivers like aufs, each with its own characteristics and considerations. The choice of a storage driver may depend on factors such as performance, stability, and kernel support.

## overlay host directory content

The `overlay2` directory within the Docker root directory is where Docker stores the file system layers for containers when the OverlayFS storage driver is used. OverlayFS is a union filesystem that allows layers to be stacked on top of each other, presenting a unified view of the file system. Here's an overview of the files and directories you might find in the `overlay2` directory:

```
/var/lib/docker
|-- image
|   |-- overlay2
|       |-- <layer_id_1>
|       |   |-- diff       # Layer contents
|       |   |-- link       # Symbolic link to the real layer data
|       |   |-- lower      # Reference to the layer below
|       |   |-- upper      # Reference to the writable layer
|       |   |-- ...
|       |-- <layer_id_2>
|       |   |-- ...
|       |-- ...
```

1. **`<layer_id>`:**
   - Each layer of the image is identified by a unique identifier, typically a long alphanumeric string. These identifiers are used to reference and organize the layers in the overlay2 directory.

2. **`diff`:**
   - The `diff` directory contains the actual file system changes introduced by the corresponding layer. This directory represents the differences between the current layer and the layer immediately below it.

3. **`link`:**
   - Inside each layer directory, there is a symbolic link named `link` that points to the real data directory for that layer. This link facilitates the overlaying of layers and provides a unified view of the file system.

4. **`lower` and `upper`:**
   - The `lower` directory is a reference to the layer directly beneath the current layer, and the `upper` directory refers to the writable layer where changes made during container runtime are stored. OverlayFS uses these references to create a merged view of the file system.

5. **Other Metadata:**
   - Additionally, there might be other metadata files and directories within each layer directory, containing information about the layer, such as timestamps, permissions, and more.

The OverlayFS storage driver allows Docker to efficiently use multiple image layers by stacking them on top of each other. This union file system approach minimizes the storage space required for each image, as layers can be shared between multiple images. Each container gets its own writable layer on top of the image layers, ensuring isolation and allowing changes made during runtime to be captured without modifying the underlying image layers.
