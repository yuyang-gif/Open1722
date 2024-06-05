avtp_utils_lib = library(
    'avtp_utils',
    ['common.c'],
    include_directories: include_directories('.'),
)

avtp_utils_dep = declare_dependency(
    link_with: avtp_utils_lib,
    include_directories: include_directories('.'),
)

subdir('aaf')
subdir('acf-can')
subdir('crf')
subdir('cvf')
subdir('ieciidc')