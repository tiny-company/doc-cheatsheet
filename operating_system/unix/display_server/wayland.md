# wayland

Wayland is a project to replace the  X11 (or Xorg) with a modern, secure, and more straightforward windowing system.

In Wayland, the **compositor** is the display server. The **compositor** is a window manager that provides applications with an off-screen buffer for each window. The window manager composites the window buffers into an image representing the screen and writes the result into the display memory.