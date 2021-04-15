#!/bin/sh

# ccache-update-symlinks - keep ccache symlinks in sync with installed
# versions of compatible compilers
# Copyright (C) 2021 by Jim Klimov

# Caller may `export DEBUG=yes` to trace the decisions in the script
# Caller may `export DRYRUN=echo` to avoid actual link manipulations

# This is where symlinks named identically to compiler binaries are present.
# These symlinks point to the ccache binary however, and it knows how to
# wrap the real thing if called (gcc, clang, maybe icc... and compatibles).
# Users who want build stuff with a speedup add this to front of their PATH,
# and their PATH must later contain the location of the real tool's binary.
# While it is not generally a problem for common /usr/bin it may be for e.g.
# gcc-4.4.4-il or other not-exposed compilers.
# Also note that even if the caller has this location in their PATH, they
# can turn off effects of ccache without changing runtime PATHs just by
# `export CCACHE_DISABLE=1` before a build.
LINKDIR="/usr/lib/ccache"
SYMLINK="../../bin/ccache"

# These are the filenames we manage symlinks for, either exact or suffixed
# by a dash and number:
TOOLS="
    gcc g++ gcpp
    clang clang++ clang-cpp
    c++ cc cpp
    i386-pc-solaris2.11-c++ i386-pc-solaris2.11-cpp i386-pc-solaris2.11-g++ i386-pc-solaris2.11-gcc
"
# TODO? Add values from SMF instance
# Rearrange for easier parsing below
TOOLS="`echo $TOOLS | tr ' ' '\n' | sort -n | uniq`"

cd "$LINKDIR" || exit

# TODO: Option in the SMF service to enable additions to PATH for gcc-4.4.4-il
# (/opt/gcc/4.4.4/bin/...) or other special compilers? It would help everyone
# if that particular system's admin rather symlinked the custom compiler to
# common /usr/bin/ instead.
# TODO: Set value from SMF instance if present there
[ "${ALLOW_DELETE-}" = true ] || { echo "Defaulting ALLOW_DELETE=false" >&2; ALLOW_DELETE=false; }

# Begin work
echo "Trawling PATH='$PATH' for TOOLS:" $TOOLS >&2

NAMES=""
for T in $TOOLS ; do
    for P in `echo "\"$PATH\"" | sed 's,:," ",g'` ; do
        P="`echo "$P" | sed 's|^"\(.*\)"$|\1|'`"
        [ "$P" = "$LINKDIR" ] && continue
        for F in `ls -1d "$P/$T"* 2>/dev/null` ; do
            [ -f "$F" ] && [ -x "$F" ] || continue
            # F represents an existing filename in PATH component P
            # that starts with tool name T
            B="`basename "$F"`"
            case "$B" in
                ccache*) ;; # Quiet skip
                "$T"|"$T"-{0,1,2,3,4,5,6,7,8,9}|"$T"-[0123456789]|"$T"-{0,1,2,3,4,5,6,7,8,9}*|"$T"-[0123456789]*)
                    # We have either the default tool name, or one suffixed
                    # by the version number (may be dotted)
                    # Assumes no whitespace in compiler filenames
                    if [ -n "$NAMES" ]; then
                        NAMES="$NAMES $B"
                    else
                        NAMES="$B"
                    fi
                    [ "$DEBUG" = yes ] && echo "ADDED:   $B ($F) ($T)" >&2
                    ;;
                *)  # Skip other tools with the same prefix
                    # Note that while looking at T=clang we skip hits of clang++*
                    [ "$DEBUG" = yes ] && echo "SKIPPED: $B ($F) ($T)" >&2
                    ;;
            esac
        done
    done
done

# Dedup
NAMES="`echo "$NAMES" | tr ' ' '\n' | sort -n | uniq`"
[ "$DEBUG" = yes ] && echo "=== PATH:" && echo "$NAMES"

LINKS="`ls -1 "$LINKDIR" | sort -n | uniq`"
[ "$DEBUG" = yes ] && echo "=== LINKDIR:" && echo "$LINKS"

if [ "$NAMES" = "$LINKS" ]; then
    echo "CCACHE symlinks are up to date for current PATH='$PATH'" >&2
    exit 0
fi

# Link missing compilers to get wrapped by ccache for its consumers
for N in $NAMES ; do
    echo "$LINKS" | fgrep "$N" >/dev/null || \
    { echo "ADDING LINK: $N" >&2; $DRYRUN ln -sf "$SYMLINK" "$LINKDIR/$N"; }
done

# (optionally) Remove links to compilers that are not in PATH
$ALLOW_DELETE || DRYRUN="echo Would exec:"
for L in $LINKS ; do
    echo "$NAMES" | fgrep "$L" >/dev/null || \
    { echo "REMOVE LINK: $L" >&2; $DRYRUN rm -f "$LINKDIR/$L"; }
done
