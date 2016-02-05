#!/bin/sh

### Enable the ClamAV services including starter config files and freshclam
### Use once to enable and installed but inactive ClamAV virus toolkit in this
### local zone or host
### (C) 2016 by Jim Klimov
### $Id: clamav-enable.sh,v 1.1 2016/02/05 00:00:00 jim Exp $

CLAMD_CONFFILE=/etc/clamd.conf
CLAMMILT_CONFFILE=/etc/clamav-milter.conf
FRESHCLAM_CONFFILE=/etc/freshclam.conf
FRESHCLAM_RUNFILE="/usr/bin/freshclam.sh"

for F in "$FRESHCLAM_CONFFILE" "$CLAMD_CONFFILE" "$CLAMMILT_CONFFILE" ; do
	if [ ! -s "$F" ] && [ -s "$F.sol" ] ; then
		echo "INFO: Copying default config '$F'" >&2
		cp -pf "$F.sol" "$F"
		chown root:root "$F"
		chmod 644 "$F"
	fi
	case "$F" in
		"$FRESHCLAM_CONFFILE")
			if [ -s "$F" ]; then
				echo "INFO: Enabling service: FRESHCLAM" >&2
				[ -x "$FRESHCLAM_RUNFILE" ] && "$FRESHCLAM_RUNFILE"
				theSMF_FMRI="svc:/antivirus/freshclam:default"
				svcadm refresh "$theSMF_FMRI"
				svcadm enable "$theSMF_FMRI"
				svcadm restart "$theSMF_FMRI"
				svcadm clear "$theSMF_FMRI"
				svcs -p "$theSMF_FMRI"
			fi ;;
		"$CLAMD_CONFFILE")
			if [ -s "$F" -a -x "/usr/sbin/clamd" ]; then
				echo "INFO: Enabling service: CLAMD" >&2
				theSMF_FMRI="svc:/antivirus/clamav:default"
				svcadm refresh "$theSMF_FMRI"
				svcadm enable "$theSMF_FMRI"
				svcadm restart "$theSMF_FMRI"
				svcadm clear "$theSMF_FMRI"
				svcs -p "$theSMF_FMRI"
			fi ;;
		"$CLAMMILT_CONFFILE")
			if [ -s "$F" -a -x "/usr/sbin/clamav-milter" ]; then
				echo "INFO: Enabling service: CLAMAV-MILTER" >&2
				theSMF_FMRI="svc:/antivirus/clamav-milter:default"
				svcadm refresh "$theSMF_FMRI"
				svcadm enable "$theSMF_FMRI"
				svcadm restart "$theSMF_FMRI"
				svcadm clear "$theSMF_FMRI"
				svcs -p "$theSMF_FMRI"
			fi ;;
	esac
done
