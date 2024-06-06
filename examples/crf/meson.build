cc = meson.get_compiler('c')
mdep = cc.find_library('m', required : false)

executable(
    'crf-talker',
    'crf-talker.c',
    
    dependencies: [avtp_dep, avtp_utils_dep, mdep],
    build_by_default: false,
)

executable(
    'crf-listener',
    'crf-listener.c',
    
    dependencies: [avtp_dep, avtp_utils_dep, mdep],
    build_by_default: false,
)
