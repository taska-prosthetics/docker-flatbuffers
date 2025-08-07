# Flatbuffers Dockerfile
#
# - Slimmed-down from https://github.com/neomantra/docker-flatbuffers
# - Build tagged releases, rather than HEAD/latest
# - Built with gcc toolchain only


FROM debian:bullseye-slim AS flatbuffer_build

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        cmake \
        curl \
        make \
        g++


###############################################################################
# FlatBuffer Build
###############################################################################

ARG FLATBUFFERS_TARBALL="https://github.com/google/flatbuffers/archive/refs/tags/v25.2.10.tar.gz"

RUN curl -fSL "${FLATBUFFERS_TARBALL}" -o flatbuffers.tar.gz \
    && tar xzf flatbuffers.tar.gz \
    && ls \
    && mv flatbuffers-* flatbuffers \
    && cd flatbuffers \
    && cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release \
    && make \
    && make test \
    && make install \
    && cp src/idl_parser.cpp src/idl_gen_text.cpp /usr/local/include/flatbuffers

# Build artifacts:
# -- Install configuration: "Release"
# -- Installing: /usr/local/include/flatbuffers
# -- Installing: /usr/local/include/flatbuffers/idl.h
# -- Installing: /usr/local/include/flatbuffers/registry.h
# -- Installing: /usr/local/include/flatbuffers/reflection.h
# -- Installing: /usr/local/include/flatbuffers/flexbuffers.h
# -- Installing: /usr/local/include/flatbuffers/flatc.h
# -- Installing: /usr/local/include/flatbuffers/minireflect.h
# -- Installing: /usr/local/include/flatbuffers/base.h
# -- Installing: /usr/local/include/flatbuffers/grpc.h
# -- Installing: /usr/local/include/flatbuffers/flatbuffers.h
# -- Installing: /usr/local/include/flatbuffers/reflection_generated.h
# -- Installing: /usr/local/include/flatbuffers/hash.h
# -- Installing: /usr/local/include/flatbuffers/stl_emulation.h
# -- Installing: /usr/local/include/flatbuffers/util.h
# -- Installing: /usr/local/include/flatbuffers/code_generators.h
# -- Installing: /usr/local/lib/cmake/flatbuffers/FlatbuffersConfig.cmake
# -- Installing: /usr/local/lib/cmake/flatbuffers/FlatbuffersConfigVersion.cmake
# -- Installing: /usr/local/lib/libflatbuffers.a
# -- Installing: /usr/local/lib/cmake/flatbuffers/FlatbuffersTargets.cmake
# -- Installing: /usr/local/lib/cmake/flatbuffers/FlatbuffersTargets-release.cmake
# -- Installing: /usr/local/bin/flatc
# -- Installing: /usr/local/lib/cmake/flatbuffers/FlatcTargets.cmake
# -- Installing: /usr/local/lib/cmake/flatbuffers/FlatcTargets-release.cmake
#
# Also want:
# src/idl_parser.cpp
# src/idl_gen_text.cpp
#


###############################################################################
# flatcc Build
###############################################################################

ARG FLATCC_TARBALL="https://github.com/dvidelabs/flatcc/archive/refs/tags/v0.6.1.tar.gz"

RUN curl -fSL "${FLATCC_TARBALL}" -o flatcc.tar.gz \
    && tar xzf flatcc.tar.gz \
    && ls \
    && mv flatcc-* flatcc \
    && cd flatcc \
    && ./scripts/initbuild.sh make \
    && ./scripts/build.sh

# Build artifacts:
# Compiler:
#   bin/flatcc                 (command line interface to schema compiler)
#   lib/libflatcc.a            (optional, for linking with schema compiler)
#   include/flatcc/flatcc.h    (optional, header and doc for libflatcc.a)
# Runtime:
#   include/flatcc/**          (runtime header files)
#   include/flatcc/reflection  (optional)
#   include/flatcc/support     (optional, only used for test and samples)
#   lib/libflatccrt.a          (runtime library)


###############################################################################
# Final Image Composition
###############################################################################

FROM debian:bullseye-slim

ARG FLATBUFFERS_IMAGE_BASE="debian"
ARG FLATBUFFERS_IMAGE_TAG="bullseye-slim"

COPY --from=flatbuffer_build /usr/local/bin/flatc /usr/local/bin/flatc
COPY --from=flatbuffer_build /usr/local/include/flatbuffers /usr/local/include/flatbuffers
COPY --from=flatbuffer_build /usr/local/lib/libflatbuffers.a /usr/local/lib/libflatbuffers.a
COPY --from=flatbuffer_build /usr/local/lib/cmake/flatbuffers /usr/local/lib/cmake/flatbuffers

COPY --from=flatbuffer_build /flatcc/bin/flatcc /usr/local/bin/flatcc
COPY --from=flatbuffer_build /flatcc/include/flatcc /usr/local/include/flatcc
COPY --from=flatbuffer_build /flatcc/lib/*.a /usr/local/lib/

LABEL OS="debian:bullseye-slim"
LABEL FLATBUFFERS="v25.2.10"
LABEL FLATCC="v0.6.1"
