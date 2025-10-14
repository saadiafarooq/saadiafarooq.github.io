#!/usr/bin/env bash
set -eu

__mise_bootstrap() {
    local script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    local project_dir=$( cd -- "$( dirname -- "$script_dir" )" &> /dev/null && pwd )
    export MISE_BOOTSTRAP_PROJECT_DIR="$project_dir"
    local localized_dir="$project_dir/.mise"
    export MISE_BOOTSTRAP_PROJECT_DIR="$project_dir"
    export MISE_DATA_DIR="$localized_dir"
    export MISE_CONFIG_DIR="$localized_dir"
    export MISE_CACHE_DIR="$localized_dir/cache"
    export MISE_STATE_DIR="$localized_dir/state"
    export MISE_INSTALL_PATH="$localized_dir/mise-2025.10.8"
    export MISE_TRUSTED_CONFIG_PATHS="$project_dir${MISE_TRUSTED_CONFIG_PATHS:+:$MISE_TRUSTED_CONFIG_PATHS}"
    export MISE_IGNORED_CONFIG_PATHS="$HOME/.config/mise${MISE_IGNORED_CONFIG_PATHS:+:$MISE_IGNORED_CONFIG_PATHS}"
    install() {
        #!/bin/sh
        set -eu

        #region logging setup
        if [ "${MISE_DEBUG-}" = "true" ] || [ "${MISE_DEBUG-}" = "1" ]; then
          debug() {
            echo "$@" >&2
          }
        else
          debug() {
            :
          }
        fi

        if [ "${MISE_QUIET-}" = "1" ] || [ "${MISE_QUIET-}" = "true" ]; then
          info() {
            :
          }
        else
          info() {
            echo "$@" >&2
          }
        fi

        error() {
          echo "$@" >&2
          exit 1
        }
        #endregion

        #region environment setup
        get_os() {
          os="$(uname -s)"
          if [ "$os" = Darwin ]; then
            echo "macos"
          elif [ "$os" = Linux ]; then
            echo "linux"
          else
            error "unsupported OS: $os"
          fi
        }

        get_arch() {
          musl=""
          if type ldd >/dev/null 2>/dev/null; then
            if [ "${MISE_INSTALL_MUSL-}" = "1" ] || [ "${MISE_INSTALL_MUSL-}" = "true" ]; then
              musl="-musl"
            else
              libc=$(ldd /bin/ls | grep 'musl' | head -1 | cut -d ' ' -f1)
              if [ -n "$libc" ]; then
                musl="-musl"
              fi
            fi
          fi
          arch="$(uname -m)"
          if [ "$arch" = x86_64 ]; then
            echo "x64$musl"
          elif [ "$arch" = aarch64 ] || [ "$arch" = arm64 ]; then
            echo "arm64$musl"
          elif [ "$arch" = armv7l ]; then
            echo "armv7$musl"
          else
            error "unsupported architecture: $arch"
          fi
        }

        get_ext() {
          if [ -n "${MISE_INSTALL_EXT:-}" ]; then
            echo "$MISE_INSTALL_EXT"
          elif [ -n "${MISE_VERSION:-}" ] && echo "$MISE_VERSION" | grep -q '^v2024'; then
            # 2024 versions don't have zstd tarballs
            echo "tar.gz"
          elif tar_supports_zstd; then
            echo "tar.zst"
          elif command -v zstd >/dev/null 2>&1; then
            echo "tar.zst"
          else
            echo "tar.gz"
          fi
        }

        tar_supports_zstd() {
          # tar is bsdtar or version is >= 1.31
          if tar --version | grep -q 'bsdtar' && command -v zstd >/dev/null 2>&1; then
            true
          elif tar --version | grep -q '1\.(3[1-9]|[4-9][0-9]'; then
            true
          else
            false
          fi
        }

        shasum_bin() {
          if command -v shasum >/dev/null 2>&1; then
            echo "shasum"
          elif command -v sha256sum >/dev/null 2>&1; then
            echo "sha256sum"
          else
            error "mise install requires shasum or sha256sum but neither is installed. Aborting."
          fi
        }

        get_checksum() {
          version=$1
          os=$2
          arch=$3
          ext=$4
          url="https://github.com/jdx/mise/releases/download/v${version}/SHASUMS256.txt"

          # For current version use static checksum otherwise
          # use checksum from releases
          if [ "$version" = "v2025.10.8" ]; then
            checksum_linux_x86_64="895db0eb777b90c449c4c79a36bd5f749fd614749876782ea32ede02c45e6bc2  ./mise-v2025.10.8-linux-x64.tar.gz"
            checksum_linux_x86_64_musl="7a64cf64432ee1ee8971c8dc50d8fb438a5e1c6899c5345e4903505d5af1ca7f  ./mise-v2025.10.8-linux-x64-musl.tar.gz"
            checksum_linux_arm64="c949d574a46b68bf8d5834d099614818d6774935d908f53051f47d24ac0601c8  ./mise-v2025.10.8-linux-arm64.tar.gz"
            checksum_linux_arm64_musl="b8d9c9de14b116fc0919d0964af8d159b4bf52f59d23009a9b3401cc139b54cb  ./mise-v2025.10.8-linux-arm64-musl.tar.gz"
            checksum_linux_armv7="f8c13b9d708b4d9fa05e9d0095b3a34d80f7d32e6b9ecab03bf5cbfda62cb000  ./mise-v2025.10.8-linux-armv7.tar.gz"
            checksum_linux_armv7_musl="28e94d08a9f6299bcda44e482eb2c33011d78253c6cc0e608bce0dcb9b0911e5  ./mise-v2025.10.8-linux-armv7-musl.tar.gz"
            checksum_macos_x86_64="422260046b8a24f0c72bfad60ac94837f834c83b5e7823e79f997ae7ff660de2  ./mise-v2025.10.8-macos-x64.tar.gz"
            checksum_macos_arm64="bc7c40c48a43dfd80537e7ca5e55a2cf7dd37924bf7595d74b29848a6ab0e2ea  ./mise-v2025.10.8-macos-arm64.tar.gz"
            checksum_linux_x86_64_zstd="e6be4ce54373ff8dc21b9e627efca0ba1c097369697cedaa44b2b2f277b91db0  ./mise-v2025.10.8-linux-x64.tar.zst"
            checksum_linux_x86_64_musl_zstd="dde22facb464abed21d1fa77519a897aaff9f993fdb9e11a88b5d4e37cd1893d  ./mise-v2025.10.8-linux-x64-musl.tar.zst"
            checksum_linux_arm64_zstd="668cd5a2f8beb28479f6556a92c156c1e150afe441ad94139a1235bb59d21837  ./mise-v2025.10.8-linux-arm64.tar.zst"
            checksum_linux_arm64_musl_zstd="6ba923b9eb4184269631fafbe02bb89c3ad382ac9cc84d240fd484859202dada  ./mise-v2025.10.8-linux-arm64-musl.tar.zst"
            checksum_linux_armv7_zstd="ab16afe7c809937f34c82613eb7e75cdcdec7587bac9b531c6031f452a0275fa  ./mise-v2025.10.8-linux-armv7.tar.zst"
            checksum_linux_armv7_musl_zstd="f1f7ed4c04877f19ad702780c4db42feeeaba94c587737558e12f5001609ca4f  ./mise-v2025.10.8-linux-armv7-musl.tar.zst"
            checksum_macos_x86_64_zstd="966b044b4aacefac8851370e7d9ac561df10f52ecb541ac8bdeb075f34f7614c  ./mise-v2025.10.8-macos-x64.tar.zst"
            checksum_macos_arm64_zstd="2e28a499a623302c7bdda0ac3558a7522e383d8c8e801d5218ae884a2d32026e  ./mise-v2025.10.8-macos-arm64.tar.zst"

            # TODO: refactor this, it's a bit messy
            if [ "$ext" = "tar.zst" ]; then
              if [ "$os" = "linux" ]; then
                if [ "$arch" = "x64" ]; then
                  echo "$checksum_linux_x86_64_zstd"
                elif [ "$arch" = "x64-musl" ]; then
                  echo "$checksum_linux_x86_64_musl_zstd"
                elif [ "$arch" = "arm64" ]; then
                  echo "$checksum_linux_arm64_zstd"
                elif [ "$arch" = "arm64-musl" ]; then
                  echo "$checksum_linux_arm64_musl_zstd"
                elif [ "$arch" = "armv7" ]; then
                  echo "$checksum_linux_armv7_zstd"
                elif [ "$arch" = "armv7-musl" ]; then
                  echo "$checksum_linux_armv7_musl_zstd"
                else
                  warn "no checksum for $os-$arch"
                fi
              elif [ "$os" = "macos" ]; then
                if [ "$arch" = "x64" ]; then
                  echo "$checksum_macos_x86_64_zstd"
                elif [ "$arch" = "arm64" ]; then
                  echo "$checksum_macos_arm64_zstd"
                else
                  warn "no checksum for $os-$arch"
                fi
              else
                warn "no checksum for $os-$arch"
              fi
            else
              if [ "$os" = "linux" ]; then
                if [ "$arch" = "x64" ]; then
                  echo "$checksum_linux_x86_64"
                elif [ "$arch" = "x64-musl" ]; then
                  echo "$checksum_linux_x86_64_musl"
                elif [ "$arch" = "arm64" ]; then
                  echo "$checksum_linux_arm64"
                elif [ "$arch" = "arm64-musl" ]; then
                  echo "$checksum_linux_arm64_musl"
                elif [ "$arch" = "armv7" ]; then
                  echo "$checksum_linux_armv7"
                elif [ "$arch" = "armv7-musl" ]; then
                  echo "$checksum_linux_armv7_musl"
                else
                  warn "no checksum for $os-$arch"
                fi
              elif [ "$os" = "macos" ]; then
                if [ "$arch" = "x64" ]; then
                  echo "$checksum_macos_x86_64"
                elif [ "$arch" = "arm64" ]; then
                  echo "$checksum_macos_arm64"
                else
                  warn "no checksum for $os-$arch"
                fi
              else
                warn "no checksum for $os-$arch"
              fi
            fi
          else
            if command -v curl >/dev/null 2>&1; then
              debug ">" curl -fsSL "$url"
              checksums="$(curl --compressed -fsSL "$url")"
            else
              if command -v wget >/dev/null 2>&1; then
                debug ">" wget -qO - "$url"
                stderr=$(mktemp)
                checksums="$(wget -qO - "$url")"
              else
                error "mise standalone install specific version requires curl or wget but neither is installed. Aborting."
              fi
            fi
            # TODO: verify with minisign or gpg if available

            checksum="$(echo "$checksums" | grep "$os-$arch.$ext")"
            if ! echo "$checksum" | grep -Eq "^([0-9a-f]{32}|[0-9a-f]{64})"; then
              warn "no checksum for mise $version and $os-$arch"
            else
              echo "$checksum"
            fi
          fi
        }

        #endregion

        download_file() {
          url="$1"
          filename="$(basename "$url")"
          cache_dir="$(mktemp -d)"
          file="$cache_dir/$filename"

          info "mise: installing mise..."

          if command -v curl >/dev/null 2>&1; then
            debug ">" curl -#fLo "$file" "$url"
            curl -#fLo "$file" "$url"
          else
            if command -v wget >/dev/null 2>&1; then
              debug ">" wget -qO "$file" "$url"
              stderr=$(mktemp)
              wget -O "$file" "$url" >"$stderr" 2>&1 || error "wget failed: $(cat "$stderr")"
            else
              error "mise standalone install requires curl or wget but neither is installed. Aborting."
            fi
          fi

          echo "$file"
        }

        install_mise() {
          version="${MISE_VERSION:-v2025.10.8}"
          version="${version#v}"
          os="${MISE_INSTALL_OS:-$(get_os)}"
          arch="${MISE_INSTALL_ARCH:-$(get_arch)}"
          ext="${MISE_INSTALL_EXT:-$(get_ext)}"
          install_path="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"
          install_dir="$(dirname "$install_path")"
          install_from_github="${MISE_INSTALL_FROM_GITHUB:-}"
          if [ "$version" != "v2025.10.8" ] || [ "$install_from_github" = "1" ] || [ "$install_from_github" = "true" ]; then
            tarball_url="https://github.com/jdx/mise/releases/download/v${version}/mise-v${version}-${os}-${arch}.${ext}"
          elif [ -n "${MISE_TARBALL_URL-}" ]; then
            tarball_url="$MISE_TARBALL_URL"
          else
            tarball_url="https://mise.jdx.dev/v${version}/mise-v${version}-${os}-${arch}.${ext}"
          fi

          cache_file=$(download_file "$tarball_url")
          debug "mise-setup: tarball=$cache_file"

          debug "validating checksum"
          cd "$(dirname "$cache_file")" && get_checksum "$version" "$os" "$arch" "$ext" | "$(shasum_bin)" -c >/dev/null

          # extract tarball
          mkdir -p "$install_dir"
          rm -rf "$install_path"
          cd "$(mktemp -d)"
          if [ "$ext" = "tar.zst" ] && ! tar_supports_zstd; then
            zstd -d -c "$cache_file" | tar -xf -
          else
            tar -xf "$cache_file"
          fi
          mv mise/bin/mise "$install_path"
          info "mise: installed successfully to $install_path"
        }

        after_finish_help() {
          case "${SHELL:-}" in
          */zsh)
            info "mise: run the following to activate mise in your shell:"
            info "echo \"eval \\\"\\\$($install_path activate zsh)\\\"\" >> \"${ZDOTDIR-$HOME}/.zshrc\""
            info ""
            info "mise: run \`mise doctor\` to verify this is setup correctly"
            ;;
          */bash)
            info "mise: run the following to activate mise in your shell:"
            info "echo \"eval \\\"\\\$($install_path activate bash)\\\"\" >> ~/.bashrc"
            info ""
            info "mise: run \`mise doctor\` to verify this is setup correctly"
            ;;
          */fish)
            info "mise: run the following to activate mise in your shell:"
            info "echo \"$install_path activate fish | source\" >> ~/.config/fish/config.fish"
            info ""
            info "mise: run \`mise doctor\` to verify this is setup correctly"
            ;;
          *)
            info "mise: run \`$install_path --help\` to get started"
            ;;
          esac
        }

        install_mise
        if [ "${MISE_INSTALL_HELP-}" != 0 ]; then
          after_finish_help
        fi

        cd "$MISE_BOOTSTRAP_PROJECT_DIR"
    }
    local MISE_INSTALL_HELP=0
    test -f "$MISE_INSTALL_PATH" || install
}
__mise_bootstrap
exec "$MISE_INSTALL_PATH" "$@"
