Based on [neomantra/docker-flatbuffers](https://github.com/neomantra/docker-flatbuffers)

- Simplified-down
- Build tagged releases, rather than HEAD/latest
- Built with gcc toolchain only


## Build Instructions

No CI/CD yet, manual build & push to docker hub.

```
docker build -t flatbuffers-tag .
docker login
docker tag flatbuffers-tag gtaska/flatbuffers:$FLATC_VER-$FLATCC_TAG
docker push gtaska/flatbuffers:$FLATC_VER-$FLATCC_TAG
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
