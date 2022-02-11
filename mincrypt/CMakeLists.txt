
include_directories(include)
add_library(mincrypt dsa_sig.c p256.c p256_ec.c p256_ecdsa.c rsa.c sha.c sha256.c)