# Copyright 2012 Google Inc. All Rights Reserved.

__author__ = 'benvanik@google.com (Ben Vanik)'

# Master build file for blk-game

GF = 'third_party/games-framework'
GSS_COMPILER_JAR=GF + ':closure_stylesheets_jar'
SOY_COMPILER_JAR=GF + ':closure_templates_jar'
JS_COMPILER_JAR=GF + ':closure_compiler_jar'
CLOSURE_LINTER_PATH=GF + '/third_party/closure-linter/'
GLSL_COMPILER_JS=GF + ':glsl_compiler_js'
include_rules(glob(GF + '/anvil_rules/**/*_rules.py'))


# ----------------------------------------------------------------------------------------------------------------------
# CSS
# ----------------------------------------------------------------------------------------------------------------------

closure_gss_library(
    name='blk_css_debug_compiled',
    mode='DEBUG_COMPILED',
    pretty_print=True,
    srcs='assets/css:all_client_css',
    compiler_jar=GSS_COMPILER_JAR)

closure_gss_library(
    name='blk_css_compiled',
    mode='COMPILED',
    srcs='assets/css:all_client_css',
    compiler_jar=GSS_COMPILER_JAR)
file_set(
    name='blk_css_compiled_only',
    srcs=':blk_css_compiled',
    src_filter='*.css')


# ----------------------------------------------------------------------------------------------------------------------
# Soy Templates
# ----------------------------------------------------------------------------------------------------------------------

closure_soy_library(
    name='blk_soy_js',
    srcs=glob('src/**/*.soy'),
    compiler_jar=SOY_COMPILER_JAR)


# ----------------------------------------------------------------------------------------------------------------------
# Static Content
# ----------------------------------------------------------------------------------------------------------------------

COMMON_CLIENT_STATIC_FILES=[
    'index.html',
    'index.css',
    'index.js',
    ] + glob('assets/index/**/*')

copy_files(
    name='blk_client_static_uncompiled',
    srcs=COMMON_CLIENT_STATIC_FILES + [
        'client/game-uncompiled.html',
        'client/worker-server-uncompiled.js',
        ])

copy_files(
    name='blk_client_static_compiled',
    srcs=COMMON_CLIENT_STATIC_FILES + [
        'client/game.html',
        'client/worker-server.js',
        ])

COMMON_NODE_STATIC_FILES=[
    ]

copy_files(
    name='blk_node_static_uncompiled',
    srcs=COMMON_NODE_STATIC_FILES + [
        'server/server-uncompiled.js',
        'run-server-uncompiled.sh',
        ])

copy_files(
    name='blk_node_static_compiled',
    srcs=COMMON_NODE_STATIC_FILES + [
        'server/server.js',
        'run-server.sh',
        ])


# ----------------------------------------------------------------------------------------------------------------------
# Audio
# ----------------------------------------------------------------------------------------------------------------------

# All audio output
file_set(
    name='blk_audio_uncompiled_all',
    srcs=[
        'assets/audio/base:base',
        'assets/audio/blocks:blocks',
        'assets/audio/music:music',
        ])
file_set(
    name='blk_audio_compiled_all',
    srcs=[
        'assets/audio/base:base_optimized',
        'assets/audio/blocks:blocks_optimized',
        'assets/audio/music:music_optimized',
        ])

# All non-code audio things
file_set(
    name='blk_audio_uncompiled',
    srcs=[':blk_audio_uncompiled_all'],
    src_filter='*.wav|*.mp3|*.m4a|*.ogg|*.json')

# Just the audio files
file_set(
    name='blk_audio_compiled',
    srcs=[':blk_audio_compiled_all'],
    src_filter='*.wav|*.mp3|*.m4a|*.ogg')


# ----------------------------------------------------------------------------------------------------------------------
# Textures
# ----------------------------------------------------------------------------------------------------------------------

texture_set(
    name='blk_blocksets',
    namespace='blk.assets.blocksets',
    srcs=glob('assets/blocksets/*.png'),
    slot_size='16x16')
file_set(
    name='blk_blockset_images',
    srcs=':blk_blocksets',
    src_filter='*.png')

texture_set(
    name='blk_textures',
    namespace='blk.assets.textures',
    srcs=glob('assets/textures/**/*.*'),
    slot_size='16x16')
file_set(
    name='blk_texture_images',
    srcs=':blk_textures',
    src_filter='*.png|*.jpg|*.gif|*.webp')

texture_set(
    name='blk_font_textures',
    namespace='blk.assets.fonts',
    srcs=glob('assets/fonts/**/*.png'))
file_set(
    name='blk_font_texture_images',
    srcs=':blk_font_textures',
    src_filter='*.png')

file_set(
    name='blk_images',
    srcs=[
        ':blk_blockset_images',
        ':blk_texture_images',
        ':blk_font_texture_images',
        ])


# ----------------------------------------------------------------------------------------------------------------------
# GLSL
# ----------------------------------------------------------------------------------------------------------------------

file_set(
    name='all_glsl',
    srcs=glob('assets/programs/**/*.glsl'))
file_set(
    name='all_glsllib',
    srcs=glob('assets/programs/**/*.glsllib'))

compile_glsl(
    name='blk_glsl',
    srcs=[':all_glsl'],
    deps=[':all_glsllib'],
    compiler_flags=[
        '--variable_renaming=false',
        '--pretty_print=true',
        '--function_renaming=false',
        '--consolidate_declarations=false'
        ],
    compiler_js=GLSL_COMPILER_JS)
file_set(
    name='blk_glsl_json',
    srcs=[':blk_glsl'],
    src_filter='*.json')


# ----------------------------------------------------------------------------------------------------------------------
# Messages/networking
# ----------------------------------------------------------------------------------------------------------------------

compile_msg(
    name='blk_msg',
    srcs=glob('src/**/*.msg'))


# ----------------------------------------------------------------------------------------------------------------------
# Simulation/replication
# ----------------------------------------------------------------------------------------------------------------------

compile_simstate(
    name='blk_simstate',
    srcs=glob('src/blk/sim/**/*.simstate'))


# ----------------------------------------------------------------------------------------------------------------------
# JavaScript
# ----------------------------------------------------------------------------------------------------------------------

file_set(
    name='all_js',
    srcs=glob('src/**/*.js'))

closure_js_fixstyle(
    name='blk_js_fixstyle',
    namespaces=['goog', 'gf', 'blk', 'WTF',],
    srcs=[':all_js'],
    linter_path=CLOSURE_LINTER_PATH)

closure_js_fixstyle(
    name='all_js_fixstyle',
    namespaces=['goog', 'gf', 'blk', 'WTF',],
    srcs=[
        GF + ':gf_js',
        ':all_js',
        ],
    linter_path=CLOSURE_LINTER_PATH)

closure_js_lint(
    name='blk_js_lint',
    namespaces=['goog', 'gf', 'blk', 'WTF',],
    srcs=[':blk_js_fixstyle'],
    linter_path=CLOSURE_LINTER_PATH)

closure_js_lint(
    name='all_js_lint',
    namespaces=['goog', 'gf', 'blk', 'WTF',],
    srcs=[':all_js_fixstyle'],
    linter_path=CLOSURE_LINTER_PATH)

BLK_JS_SRCS=[
    GF + ':all_gf_js',
    ':all_js',
    ':blk_msg',
    ':blk_simstate',
    ]

BLK_CLIENT_JS_SRCS=BLK_JS_SRCS + [
    ':blk_css_compiled',
    ':blk_soy_js',
    ':blk_glsl',
    ':blk_blocksets',
    ':blk_textures',
    ':blk_font_textures',
    ]

BLK_SERVER_JS_SRCS=BLK_JS_SRCS + [
    ]

SHARED_JS_FLAGS=[
    '--define=gf.BUILD_CLIENT=false',
    '--define=goog.DEBUG=false',
    '--define=goog.asserts.ENABLE_ASSERTS=false',
    ]

closure_js_library(
    name='blk_js_uncompiled',
    mode='DEPS',
    entry_points=['blk.client.start', 'blk.server.start',],
    srcs=BLK_CLIENT_JS_SRCS + [
        ':blk_audio_uncompiled_all',
        ],
    compiler_jar=JS_COMPILER_JAR)

closure_js_library(
    name='blk_client_js_compiled',
    mode='ADVANCED',
    #pretty_print=True,
    entry_points='blk.client.start',
    srcs=BLK_CLIENT_JS_SRCS + [
        ':blk_audio_compiled_all',
        ],
    externs=[GF + ':closure_externs'],
    compiler_jar=JS_COMPILER_JAR,
    compiler_flags=SHARED_JS_FLAGS + [
        #'--debug',
        '--define=gf.SERVER=false',
        '--define=gf.NODE=false',
        ])

closure_js_library(
    name='blk_server_js_compiled',
    mode='ADVANCED',
    #pretty_print=True,
    entry_points='blk.server.start',
    srcs=BLK_SERVER_JS_SRCS,
    externs=[GF + ':closure_externs'],
    compiler_jar=JS_COMPILER_JAR,
    compiler_flags=SHARED_JS_FLAGS + [
        #'--debug',
        '--define=gf.SERVER=true',
        '--define=gf.NODE=false',
        ])

closure_js_library(
    name='blk_node_js_compiled',
    mode='ADVANCED',
    entry_points='blk.server.start',
    srcs=BLK_SERVER_JS_SRCS,
    externs=[GF + ':closure_externs'],
    compiler_jar=JS_COMPILER_JAR,
    compiler_flags=SHARED_JS_FLAGS + [
        '--define=gf.SERVER=true',
        '--define=gf.NODE=true',
        ],
    wrap_with_global='global')

file_set(
    name='node_modules',
    srcs=
        glob(GF + '/third_party/abbrev/**/*.*') +
        glob(GF + '/third_party/nopt/**/*.*') +
        glob(GF + '/third_party/node-closure/**/*.*') +
        glob(GF + '/third_party/options/**/*.*') +
        glob(GF + '/third_party/ws/**/*.*'))


# ----------------------------------------------------------------------------------------------------------------------
# Target rules
# ----------------------------------------------------------------------------------------------------------------------

file_set(
    name='lint',
    deps=':blk_js_lint')

file_set(
    name='debug',
    srcs=[
        GF + ':all_uncompiled_js',
        ':blk_client_static_uncompiled',
        ':blk_node_static_uncompiled',
        ':blk_audio_uncompiled',
        ':blk_images',
        ':blk_css_debug_compiled',
        ':blk_glsl_json',
        ':blk_js_uncompiled',
        ':node_modules',
        ])

archive_files(
    name='release-server',
    srcs=[
        ':blk_node_static_compiled',
        ':blk_node_js_compiled',
        ':node_modules'
        ])

file_set(
    name='gh-pages',
    srcs=[
        ':blk_client_static_compiled',
        ':blk_audio_compiled',
        ':blk_images',
        ':blk_css_compiled_only',
        ':blk_client_js_compiled',
        ':blk_server_js_compiled',
        ],
    src_exclude_filter='*-deps.js')

file_set(
    name='release',
    srcs=[
        ':blk_client_static_compiled',
        ':blk_node_static_compiled',
        ':blk_audio_compiled',
        ':blk_images',
        ':blk_css_compiled_only',
        ':blk_client_js_compiled',
        ':blk_server_js_compiled',
        ':blk_node_js_compiled',
        ':node_modules',
        ':release-server',
        ],
    deps=[
        #':blk_js_lint',
        ])
