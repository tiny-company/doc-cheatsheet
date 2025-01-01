# apt sources.list files

In Advanced Package Tool (APT), the sources.list file specifies the locations from which the system retrieves and installs software packages.

Each line in the sources.list file represents a software repository and follows this basic format:
```css
deb [options] uri distribution [components]
deb-src [options] uri distribution [components]
```

with :
- Type (deb / deb-src):
    - deb: This indicates a binary repository. APT will download precompiled packages (binaries) from this repository.
    - deb-src: This indicates a source repository. APT will download source code for packages from this repository. Useful if you need to compile the software yourself.

- Options (optional): Options can be used to modify the behavior of the repository. They are specified within square brackets [ ] and are optional.
    - Examples of options include:
        - arch=<architecture>: Specifies the architecture for which the repository is intended (e.g., amd64, i386).
        - trusted=yes|no: Marks the repository as trusted or untrusted.

- URI: This is the Uniform Resource Identifier that points to the location of the repository. It can be an HTTP/HTTPS URL, an FTP address, a file path (for local repositories), or other protocols supported by APT.
    - Example: http://deb.debian.org/debian/

- Distribution: This indicates the distribution version or codename that the repository targets. Common values include:
    - For Debian: stable, testing, unstable, or codenames like buster, bullseye, sid.
    - For Ubuntu: focal, jammy, etc.
    - Example: bullseye

- Components: These specify the subsections of the repository and help in categorizing the packages. Common components include:
    - main: Officially supported free software.
    - contrib: Free software that depends on non-free software.
    - non-free: Software that is not free (may have restrictions on use, modification, etc.).

    Multiple components can be specified separated by spaces. Example: main contrib non-free