set(DeepSpeech_ROOT "/home/denys/opt/deepSpeech")

add_library(DeepSpeech SHARED IMPORTED GLOBAL)

set_property(TARGET DeepSpeech PROPERTY IMPORTED_LOCATION ${DeepSpeech_ROOT}/libdeepspeech.so)

target_include_directories(DeepSpeech INTERFACE ${DeepSpeech_ROOT})
