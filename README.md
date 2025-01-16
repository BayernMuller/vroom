<p align="center">
    <img src="/assets/vroom.png" width="400"/>
    <br/>
    <img src="/assets/logo_license.svg" title="vrew-license" alt="vrew-license"/>
</p>

<span align="center">

# vroom

</span>

<p align="center">
    <img src="https://img.shields.io/badge/platform-Apple Silicon-000000?style=flat&logo=apple" alt="platform">
    <img src="https://img.shields.io/github/license/BayernMuller/vroom" alt="license">
</p>

### What is *vroom*?
* [Vrew](https://vrew.voyagerx.com/en/) is a video editing software that uses x86_64 architecture FFmpeg on Apple Silicon, resulting in slower performance.
* vroom is a script that updates [Vrew](https://vrew.voyagerx.com/en/)'s FFmpeg to a native Apple Silicon version, enhancing speed.
* For more details, read [**my Medium post**](https://medium.com/@bayernmuller/vrew-웹-기반-영상-편집-앱-분석-그리고-더-빠르게-만들기-5a7805588c74) (Korean).

### Before installation
- **Not officially supported** by [Vrew](https://vrew.voyagerx.com/en/). Use at your own risk.
- **[Homebrew](https://brew.sh/)** is required.
- Compatible only with Apple Silicon Macs.

- ***vroom*** is not liable for any damage from using the patch.

### Installation

* Run the following command in your terminal.
```bash
curl -s https://raw.githubusercontent.com/BayernMuller/vroom/main/vroom.sh | bash
```

<p align="center">
    <img src="/assets/terminal.png"/>
</p>


### Benchmark
<p align="center">
    <img src="/assets/plot.png" width="700"/><br/>
    lower is better.
</p>

* comparison of the performance of the vrew and patched FFmpeg on Apple M2 chip.
* ***vroom*** makes the video editing process about **2 times faster**.

