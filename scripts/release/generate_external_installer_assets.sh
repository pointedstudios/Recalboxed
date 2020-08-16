#!/bin/bash

## FUNCTIONS ##

function exitWithUsage {
  echo "Usage: $0 --images-dir <images_dir> --destination-dir <destination_dir>"
  echo
  echo "This script generates assets for external OS installers (imagers)"
  echo "such as NOOBS, PINN or Raspberry Pi Imager."
  echo
  echo "  --images-dir <images_dir>            path to Recalbox images"
  echo "  --destination-dir <destination_dir>  path where assets will be generated"
  echo
  echo "The <images_dir> expects the following file hierarchy:"
  echo
  echo "    <images_dir>/"
  echo "    ├─ rpi1/"
  echo "    │  └─ recalbox-rpi1.img.xz"
  echo "    ├─ rpi2/"
  echo "    │  └─ recalbox-rpi2.img.xz"
  echo "    └─ rpi3/"
  echo "       └─ recalbox-rpi3.img.xz"
  echo
  exit 64
}

function generateNoobsAssets {
  local templateDir="$(dirname $(readlink -f $0))/templates/noobs"
  local destinationDir="${params[destinationDir]}/noobs"
  declare -A metadata

  echo ">>> Generating assets for NOOBS (in ${destinationDir})"

  # Create destination directory hierarchy

  for arch in rpi1 rpi2 rpi3; do
    mkdir -p "${destinationDir}/${arch}"
  done

  # Gather required information from images directory

  metadata[version]=${CI_COMMIT_REF_NAME}
  metadata[releaseDate]=$(date +%Y-%m-%d)

  for arch in rpi1 rpi2 rpi3; do
    local tempMountPoint=$(mktemp -d)
    local diskImage="${params[imagesDir]}/${arch}/recalbox-${arch}.img"
    local tarball="${destinationDir}/${arch}/boot.tar"
    # Generate tarball of the filesystem from disk image (as `boot.tar.xz`)
    unxz --keep "${diskImage}.xz"
    mount -o loop,offset=$((512*2048)) "${diskImage}" "${tempMountPoint}"
    tar -C "${tempMountPoint}" -cvf "${tarball}" . > /dev/null
    # Fetch info regarding uncompressed tarball (before XZ compression, will be checked by NOOBS after XZ decompression)
    metadata["${arch}UncompressedTarballSize"]=$(du -m "${tarball}" | cut -f 1)
    # Compress tarball (will create a `.tar.xz` file and delete the `.tar`)
    xz "${tarball}"
    # Cleanup
    umount "${tempMountPoint}"
    rm "${diskImage}"
  done

  # Create assets in destination directory

  cp -n "${templateDir}/recalbox.png" "${destinationDir}/recalbox.png"
  cp -n "${templateDir}/marketing.tar" "${destinationDir}/marketing.tar"
  cp -n "${templateDir}/partition_setup.sh" "${destinationDir}/partition_setup.sh"

  cat "${templateDir}/os.json" \
  | sed -e "s|{{version}}|${metadata[version]}|" \
        -e "s|{{releaseDate}}|${metadata[releaseDate]}|" \
  > "${destinationDir}/os.json"

  for arch in rpi1 rpi2 rpi3; do
    cat "${templateDir}/partitions.json" \
    | sed -e "s|{{uncompressedTarballSize}}|${metadata["${arch}UncompressedTarballSize"]}|" \
    > "${destinationDir}/${arch}/partitions.json"
  done
}

function generateRaspberryPiImagerAssets {
  local templateDir="$(dirname $(readlink -f $0))/templates/raspi_imager"
  local destinationDir="${params[destinationDir]}/raspi-imager"
  declare -A metadata

  echo ">>> Generating assets for Raspberry Pi Imager (in ${destinationDir})"

  # Gather required information from images directory

  metadata[version]=${CI_COMMIT_REF_NAME}
  metadata[releaseDate]=$(date +%Y-%m-%d)

  for arch in rpi1 rpi2 rpi3; do
    # Fetch info regarding image downloads (XZ-compressed Recalbox image)
    metadata["${arch}ImageDownloadSize"]=$(stat --format=%s "${params[imagesDir]}/${arch}/recalbox-${arch}.img.xz")
    metadata["${arch}ImageDownloadSha256"]=$(sha256sum "${params[imagesDir]}/${arch}/recalbox-${arch}.img.xz" | cut -d' ' -f1)
    # Fetch info regarding extracted images (raw Recalbox image, after XZ decompression)
    unxz --keep "${params[imagesDir]}/${arch}/recalbox-${arch}.img.xz"
    metadata["${arch}ExtractSize"]=$(stat --format=%s "${params[imagesDir]}/${arch}/recalbox-${arch}.img")
    metadata["${arch}ExtractSha256"]=$(sha256sum "${params[imagesDir]}/${arch}/recalbox-${arch}.img" | cut -d' ' -f1)
    rm "${params[imagesDir]}/${arch}/recalbox-${arch}.img"
  done

  # Create assets in destination directory

  mkdir -p ${destinationDir}

  cat "${templateDir}/os_list_imagingutility_recalbox.json" \
  | sed -e "s|{{version}}|${metadata[version]}|" \
        -e "s|{{releaseDate}}|${metadata[releaseDate]}|" \
        -e "s|{{rpi1ExtractSize}}|${metadata[rpi1ExtractSize]}|" \
        -e "s|{{rpi2ExtractSize}}|${metadata[rpi2ExtractSize]}|" \
        -e "s|{{rpi3ExtractSize}}|${metadata[rpi3ExtractSize]}|" \
        -e "s|{{rpi1ExtractSha256}}|${metadata[rpi1ExtractSha256]}|" \
        -e "s|{{rpi2ExtractSha256}}|${metadata[rpi2ExtractSha256]}|" \
        -e "s|{{rpi3ExtractSha256}}|${metadata[rpi3ExtractSha256]}|" \
        -e "s|{{rpi1ImageDownloadSize}}|${metadata[rpi1ImageDownloadSize]}|" \
        -e "s|{{rpi2ImageDownloadSize}}|${metadata[rpi2ImageDownloadSize]}|" \
        -e "s|{{rpi3ImageDownloadSize}}|${metadata[rpi3ImageDownloadSize]}|" \
        -e "s|{{rpi1ImageDownloadSha256}}|${metadata[rpi1ImageDownloadSha256]}|" \
        -e "s|{{rpi2ImageDownloadSha256}}|${metadata[rpi2ImageDownloadSha256]}|" \
        -e "s|{{rpi3ImageDownloadSha256}}|${metadata[rpi3ImageDownloadSha256]}|" \
  > "${destinationDir}/os_list_imagingutility_recalbox.json"
  cp -n "${templateDir}/recalbox.svg" "${destinationDir}/recalbox.svg"
}

## PARAMETERS PARSING ##

declare -A params

while [ -n "$1" ]; do
  case "$1" in
    --images-dir)
      shift
      [ -n "$1" ] && params[imagesDir]=$(readlink -f "$1") || exitWithUsage
      ;;
    --destination-dir)
      shift
      [ -n "$1" ] && params[destinationDir]=$(readlink -f "$1") || exitWithUsage
      ;;
    *)
      exitWithUsage
      ;;
  esac
  shift
done

if [[ ! -d ${params[imagesDir]} || ! -d ${params[destinationDir]} ]]; then
  exitWithUsage
fi

## MAIN ##

generateNoobsAssets
generateRaspberryPiImagerAssets
