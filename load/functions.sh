# jump into code project
cj () {
  #TODO: implement this using fzf
  cd "$CODE/$1"
}

#!/bin/sh
#
# Usage: extract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is macOS-specific.
#
# credit: http://nparikh.org/notes/zshrc.txt
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.dmg)      hdiutil mount $1                    ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.ZIP)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.rar)      unrar x $1                          ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

git_conflicts() {
  echo "Using git_conficts"
  OUTPUT=$(git "$@" 2>&1 | tee /dev/tty)
  if `echo ${OUTPUT} | grep -i "CONFLICT" 1>/dev/null 2>&1`
  then
    git mergetool
  fi
}

install_fucking_nokogiri() {
  gem install nokogiri -- --use-system-libraries --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2/ --with-xslt-config=/path/to/xslt-config
}