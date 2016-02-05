#!/bin/sh

### Startup for COSclamav package
### (C) 2008-2014 by Jim Klimov, COS&HT
### $Id: freshclam.sh,v 1.5 2014/06/23 09:13:19 jim Exp $

### Use to update ClamAV virus signatures from cron:
### 0,15,30,45 * * * *       [ -x /usr/bin/freshclam.sh ] && /usr/bin/freshclam.sh

CLAMD_CONFFILE=/etc/clamd.conf
FRESHCLAM_CONFFILE=/etc/freshclam.conf
FRESHCLAM_BINFILE="/usr/bin/freshclam"

STATUS_LINES=100

PATH=/usr/bin:/bin:/usr/sbin:/bin:$PATH
export PATH

LD_LIBRARY_PATH=\
/usr/lib:/lib:/usr/ssl/lib:\
/usr/sfw/lib:/opt/sfw/lib:\
/usr/gnu/lib:/opt/gnu/lib:\
$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

if [ ! -s "$CLAMD_CONFFILE" -o ! -s "$FRESHCLAM_CONFFILE" ]; then
        # echo "ClamAV-FreshCLAM: No config file!" >&2
        exit 0
fi

adderror() {
	BUF_ERROR="$BUF_ERROR
$1"
	[ x"$RES" = x0 ] && RES="$2"
	[ "$RES_MAX" -lt "$2" ] && RES_MAX="$2"
}

case "$1" in
	status)	### Use "status nowarn" to not return errors for warnings only.
		### Use "status nowarnobs" to not return errors for warnings
		### and obsolete databases only.
		[ x"$2" != x ] && [ "$2" -gt 10 ] && STATUS_LINES="$2"
		LOGFILE="`egrep '^[^#]*UpdateLogFile ' $FRESHCLAM_CONFFILE | awk '{print $NF }'`"
		if [ x"$LOGFILE" = x -o ! -f "$LOGFILE" ]; then
			echo "ClamAV-FreshCLAM: No log file ($LOGFILE)!" >&2
			exit 1
		fi

		BUF_ERROR=""
		BUF_START=""
		RES=0
		RES_MAX=0
		tail -"$STATUS_LINES" "$LOGFILE" | ( while read LINE; do
			case "$LINE" in
			ClamAV\ update\ process\ started\ at*)
				BUF_ERROR=""
				RES=0
				RES_MAX=0
				BUF_START="$LINE"
				;;
			*connect\ timing\ out*|*Can?t\ connect\ to*)
				adderror "$LINE" 10 ;;
			*node\ name\ or\ service\ name\ not\ known*)
				adderror "$LINE" 11 ;;
			Update\ failed*)
				adderror "$LINE" 12 ;;
			*Your\ ClamAV\ installation\ is\ OUTDATED*)
				adderror "$LINE" 3 ;;
			WARNING*)
				adderror "$LINE" 2 ;;
			esac
		done
		if [ x"$RES" != x0 ]; then
			[ x"$BUF_START" != x ] && echo "$BUF_START" >&2
			echo "$BUF_ERROR" >&2
			if [ x"$2" = xnowarn -a "$RES_MAX" -le 2 ]; then
			    echo "Status: WARN"
			    RES=0
			else
			    if [ x"$2" = xnowarnobs -a "$RES_MAX" -le 3 ]; then
				echo "Status: WARN"
			        RES=0
			    else
				echo "Status: FAIL"
			    fi
			fi
		else
			echo "Status: OK"
		fi
		exit $RES )
		;;
	*)
		[ -x "$FRESHCLAM_BINFILE" ] && "$FRESHCLAM_BINFILE" "$@"
		;;
esac

