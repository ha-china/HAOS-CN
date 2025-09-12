#!/bin/bash
# shellcheck disable=SC2155

function hassos_pre_image() {
    local BOOT_DATA="$(path_boot_dir)"

    cp -t "${BOOT_DATA}" \
        "${BINARIES_DIR}/boot.scr" \
        "${BINARIES_DIR}/rv1126-sonoff-ihost.dtb" \
        "${BINARIES_DIR}/rv1109-sonoff-ihost.dtb"

    mkdir -p "${BOOT_DATA}/overlays"
    #cp "${BINARIES_DIR}"/*.dtbo "${BOOT_DATA}/overlays/"
    cp "${BOARD_DIR}/boot-env.txt" "${BOOT_DATA}/haos-config.txt"
    cp "${BOARD_DIR}/cmdline.txt" "${BOOT_DATA}/cmdline.txt"

}


function hassos_post_image() {
    convert_disk_image_xz
}


function disk_size_fixup() {
    if grep -q ^BR2_PACKAGE_HASSIO_FULL_CORE=y "${BASE_DIR}/.config"; then
        echo "${FULL_DISK_SIZE}"
    else
        echo "${DISK_SIZE}"
    fi
}

function data_size_fixup() {
    if grep -q ^BR2_PACKAGE_HASSIO_DATA_IMAGE_SIZE "${BASE_DIR}/.config"; then
        echo "${BR2_PACKAGE_HASSIO_DATA_IMAGE_SIZE}"
    else
        echo "1280M"
    fi
}