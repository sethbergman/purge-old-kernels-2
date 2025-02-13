#!/usr/bin/env bash
#
#    purge-old-kernels-2 - remove old kernels and their headers
#    Copyright (C) 2012: Dustin Kirkland <kirkland@ubuntu.com>
#                  2017: Pjotr <pjotrvertaalt@gmail.com>
#
#    Authors: Dustin Kirkland <kirkland@ubuntu.com>
#             Kees Cook <kees@ubuntu.com>
#             Pjotr <pjotrvertaalt@gmail.com> (minor changes in the explanatory notes)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Ensure we're running as root
if [ "$(id -u)" != 0 ]; then
   echo "ERROR: This script must be run as root.  Hint:" 1>&2
   echo "  sudo sh $0 *" 1>&2
   exit 1
fi

# NOTE: This script will ALWAYS keep the currently running kernel and its headers, which should make it safe to use.
# NOTE: Default is 2, which means that it keeps one spare kernel besides the currently running kernel.
# NOTE: Before you can use it, you need to make this shell script executable.
# Usage when in folder Downloads, consists out of three steps:
# 1. Move the script from the folder Downloads to the folder /opt:
# sudo mv -v ~/Downloads/purge-old-kernels-2.sh /opt
# 2. Set the permissions right (also making it executable):
# sudo chmod -v 755 /opt/purge-old-kernels-2.sh
# 3. Launch it:
# sudo sh /opt/purge-old-kernels-2.sh
# NOTE: You can change the number of kept kernels with --keep.
# Example: sudo sh /opt/purge-old-kernels-2.sh --keep 3
KEEP=2
# NOTE: Any unrecognized option will be passed straight through to apt
APT_OPTS=
while [ -n "$1" ]; do
   case "$1" in
      --keep)
         # User specified the number of kernels to keep
         KEEP="$2"
         shift 2
      ;;
      *)
         APT_OPTS="$APT_OPTS $1"
         shift 1
      ;;
   esac
done

# Build our list of kernel packages to purge
CANDIDATES=$(find /boot/vmlinuz-* | head -n -"${KEEP}" | grep -v "$(uname -r)$" | cut -d- -f2- | awk '{print "linux-image-" $0 " linux-headers-" $0}' )
for c in $CANDIDATES; do
   dpkg-query -s "$c" >/dev/null 2>&1 && PURGE="$PURGE $c"
done

if [ -z "$PURGE" ]; then
   echo "No kernels are eligible for removal"
   exit 0
fi

apt "$APT_OPTS" remove --purge "$PURGE"
