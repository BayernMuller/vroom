# vroom

### What is vroom?
I found that the video editing software [Vrew](https://vrew.voyagerx.com/en/) uses x86_64 architecture FFmpeg.
So I made a script to install the patch to use the Apple Silicon FFmpeg.

For the detailed information, please visit my medium post (Korean): NOLINK

### Benchmark
![benchmark](res/plot.png)
* comparison of the performance of the vrew and patched FFmpeg on Apple M2 chip.
* lower is better.

### Before installation
vroom is not officially supported by Vrew. Use at your own risk.

- vroom is only for Apple Silicon.
- vroom requires Homebrew and ARM64 FFmpeg. If you don't have it, vroom will ask you to install it.
- vroom is not responsible for any damage caused by using the patch.
- vroom replaces the original FFmpeg with the native FFmpeg for Apple Silicon.


### Installation

```bash
curl -s https://raw.githubusercontent.com/BayernMuller/vroom/main/vroom.sh | bash
```

```bash
[2024-02-14 15:38:39] Checking environment
[2024-02-14 15:38:39] SUCCESS: It's Apple Silicon
[2024-02-14 15:38:39] SUCCESS: Homebrew is installed
[2024-02-14 15:38:39] SUCCESS: FFmpeg is installed
[2024-02-14 15:38:39] SUCCESS: Vrew is installed
[2024-02-14 15:38:39] - Which do you want to do? (install/uninstall): install
[2024-02-14 15:38:41] - Do you want to continue? (y/n): y
[2024-02-14 15:38:43] Installing patch
[2024-02-14 15:38:43] SUCCESS: Installed patch
```

