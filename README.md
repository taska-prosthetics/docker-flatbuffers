Based on [neomantra/docker-flatbuffers](https://github.com/neomantra/docker-flatbuffers)

- Simplified-down
- Build tagged releases, rather than HEAD/latest
- Built with gcc toolchain only


## Pulling the image

Images are published to the GitHub Container Registry (GHCR):

```
docker pull ghcr.io/taska-prosthetics/docker-flatbuffers:v25.12.19-v0.6.1
```

Tags follow the pattern `<flatbuffers-version>-<flatcc-version>`.

For reproducible builds, pin by digest:

```
docker pull ghcr.io/taska-prosthetics/docker-flatbuffers:v25.12.19-v0.6.1@sha256:<digest>
```

The digest for each published image is available on the
[GHCR package page](https://github.com/taska-prosthetics/docker-flatbuffers/pkgs/container/docker-flatbuffers).


## Releasing a new image

Images are built and pushed automatically by the
[`release.yaml`](.github/workflows/release.yaml) GitHub Actions workflow
whenever a git tag is pushed to this repository.

To publish a new image:

1. Update `Dockerfile` with the desired `FLATBUFFERS_TARBALL` / `FLATCC_TARBALL` versions and labels.
2. Commit and push the changes to a branch; open a PR and merge to `main`.
3. Push a release tag matching the pattern `<flatbuffers-version>-<flatcc-version>`:

```bash
git tag v25.12.19-v0.6.1
git push origin v25.12.19-v0.6.1
```

The workflow will build the Docker image and push it to GHCR under the pushed tag.


## Local build

```bash
docker build -t flatbuffers-local .
```

## Copyright & License

Based on [neomantra/docker-flatbuffers](https://github.com/neomantra/docker-flatbuffers)

```
This software is released under the MIT License.

Copyright (c) 2018-2023, Neomantra BV and Evan Wies evan@neomantra.net

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
