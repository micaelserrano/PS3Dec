FROM alpine:3.20 AS builder

RUN apk add --no-cache cmake make gcc musl-dev

WORKDIR /src
COPY . .

RUN LIBGOMP=$(gcc -print-file-name=libgomp.a) && \
    mkdir /build && \
    cd /build && \
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DOpenMP_C_FLAGS="-fopenmp" \
      -DOpenMP_C_LIB_NAMES="gomp" \
      -DOpenMP_gomp_LIBRARY="$LIBGOMP" \
      -DCMAKE_EXE_LINKER_FLAGS="-static" \
      /src && \
    make -j$(nproc)

FROM scratch
COPY --from=builder /build/Release/PS3Dec /PS3Dec
ENTRYPOINT ["/PS3Dec"]
