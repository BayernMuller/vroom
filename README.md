<p align="center">
    <img src="res/vroom.png" width="400"/>
    <br/>
    <img src="https://svgshare.com/i/14GU.svg" title="vrew-license" alt="vrew-license"/>
</p>

<span align="center">

# vroom

</span>

<p align="center">
    <img src="https://img.shields.io/badge/platform-Apple Silicon-000000?style=flat&logo=apple" alt="platform">
    <img src="https://img.shields.io/github/license/BayernMuller/vroom" alt="license">
</p>

### What is vroom?
* The video editing software [Vrew](https://vrew.voyagerx.com/en/) uses x86_64 architecture FFmpeg even on Apple Silicon. It's not optimized for Apple Silicon, so it's slow.
* vroom is a script that patches the FFmpeg used by Vrew to the native FFmpeg for Apple Silicon. It replaces the original FFmpeg with the native FFmpeg for Apple Silicon.
* For the detailed information, please visit [my medium post](https://medium.com/@bayernmuller/vrew-웹-기반-영상-편집-앱-분석-그리고-더-빠르게-만들기-5a7805588c74) (Korean).

### Before installation
- **Not officially supported** by Vrew. Use at your own risk.
- Only for Apple Silicon Macs.
- Requires Homebrew and ARM64 FFmpeg. If you don't have it, vroom will ask you to install it.
- vroom is not responsible for any damage caused by using the patch.

### Installation

* Run the following command in your terminal.
```bash
curl -s https://raw.githubusercontent.com/BayernMuller/vroom/main/vroom.sh | bash
```

```bash
Checking environment
SUCCESS: It's Apple Silicon
SUCCESS: Homebrew is installed
SUCCESS: FFmpeg is installed
SUCCESS: Vrew is installed
- Which do you want to do? (install/uninstall): install
- Do you want to continue? (y/n): y
Installing patch
SUCCESS: Installed patch
```

* If you want to uninstall the patch, write `uninstall` instead of `install` when selecting the action.

### Benchmark
<p align="center">
    <img src="res/plot.png" width="700"/><br/>
    lower is better.
</p>

* comparison of the performance of the vrew and patched FFmpeg on Apple M2 chip.
* vroom makes the video editing process about 2 times faster.

