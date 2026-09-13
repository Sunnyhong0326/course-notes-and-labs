#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SUBMISSION_NAME="submission"
DEST_DIR="${ROOT_DIR}/${SUBMISSION_NAME}"

FILES=(
  "./notebooks/assignment2-part2/neural-texture/shaders/neural-texture.slang"
  "./notebooks/assignment2-part2/volume-recovery/shaders/upsampler.slang"
  "./notebooks/assignment2-part2/volume-recovery/diff-texture.ipynb"
  "./notebooks/assignment2-part2/volume-recovery/volume-recovery.ipynb"
  "./src/cs248a_renderer/model/material.py"
  "./src/cs248a_renderer/model/bvh.py"
  "./src/cs248a_renderer/model/scene_object.py"
  "./src/cs248a_renderer/slang_shaders/math/ray.slang"
  "./src/cs248a_renderer/slang_shaders/math/bounding_box.slang"
  "./src/cs248a_renderer/slang_shaders/model/bvh.slang"
  "./src/cs248a_renderer/slang_shaders/model/camera.slang"
  "./src/cs248a_renderer/slang_shaders/primitive/triangle.slang"
  "./src/cs248a_renderer/slang_shaders/primitive/sdf.slang"
  "./src/cs248a_renderer/slang_shaders/primitive/volume.slang"
  "./src/cs248a_renderer/slang_shaders/renderer/triangle_renderer.slang"
  "./src/cs248a_renderer/slang_shaders/renderer/volume_renderer.slang"
  "./src/cs248a_renderer/slang_shaders/texture/diff_texture.slang"
  "./src/cs248a_renderer/slang_shaders/texture/texture.slang"
  "./src/cs248a_renderer/slang_shaders/renderer.slang"
)

rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"

for rel in "${FILES[@]}"; do
  src="${ROOT_DIR}/${rel}"
  if [[ ! -f "$src" ]]; then
    echo "missing source file: $rel" >&2
    exit 1
  fi
  dst_dir="${DEST_DIR}/$(dirname "$rel")"
  mkdir -p "$dst_dir"
  cp "$src" "$dst_dir/"
done

# Copy recovered volume resources (.npy and .mp4 files)
# Please place the recovered volumes (.npy files) and their animations (.mp4 files) in the resources/recovered_volumes directory.
RECOVERED_DIR="${ROOT_DIR}/resources/recovered_volumes"
if [[ -d "$RECOVERED_DIR" ]]; then
  while IFS= read -r src; do
    # Make path inside submission match project-relative path
    rel="./${src#$ROOT_DIR/}"
    dst_dir="${DEST_DIR}/$(dirname "$rel")"
    mkdir -p "$dst_dir"
    cp "$src" "$dst_dir/"
  done < <(find "$RECOVERED_DIR" -type f \( -name '*.npy' -o -name '*.mp4' \))
fi

ZIP_NAME="${SUBMISSION_NAME}.zip"
rm -f "${ROOT_DIR}/${ZIP_NAME}"
(cd "$ROOT_DIR" && zip -r "$ZIP_NAME" "$(basename "$DEST_DIR")")
rm -rf "$DEST_DIR"
echo "Created $ZIP_NAME"
