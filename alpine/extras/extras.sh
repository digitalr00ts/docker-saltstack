#!/bin/sh

SOURCE="$0"
while [ -h "$SOURCE" ]; do
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

for arg in $@; do
	case $arg in
		useradd)
			[ -x "${DIR}/useradd.sh" ] && ${DIR}/useradd.sh || echo "File not found or no read perm: useradd.sh" ;;
		term)
			apk --no-cache add curl less bash bash-completion util-linux coreutils binutils findutils grep ;
			[ ! -f "${DIR}/get-pip.py" ] && curl -SsLo "${DIR}/get-pip.py" https://bootstrap.pypa.io/get-pip.py ;;
		pip)
			[ -r "${DIR}/get-pip.py" ] && python ${DIR}/get-pip.py || echo "File not found or no read perm: get-pip.py" ;;
		man)
			apk --no-cache add man man-pages mdocml-apropos less-doc bash-doc curl-doc ;;
		*)
			echo "Unrecognized option: ${arg}" ;;
	esac
done
