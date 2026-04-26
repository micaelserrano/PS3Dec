// Minimal mbedTLS configuration

#define MBEDTLS_AES_C
#if defined(__x86_64__) || defined(_M_X64)
#define MBEDTLS_AESNI_C
#endif
#define MBEDTLS_CIPHER_MODE_CBC
#define MBEDTLS_HAVE_ASM
#define MBEDTLS_PLATFORM_C

#include <mbedtls/check_config.h>
