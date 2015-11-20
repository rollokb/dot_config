cd() {      
   if [ -f $1/venv/bin/activate ]; then 
     source $1/venv/bin/activate
   fi
   builtin cd "$1"
}

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile


function setjdk() {
if [ $# -ne 0 ]; then
  removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
  if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
  fi
  export JAVA_HOME=`/usr/libexec/java_home -v $@`
  export PATH=$JAVA_HOME/bin:$PATH
fi
}

function removeFromPath() {
 export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

setjdk 1.8




if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
	source '/usr/local/share/chruby/chruby.sh'
	source '/usr/local/share/chruby/auto.sh'
fi


if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 2)\]\W\[$(tput setaf 4)\]]\\$ \[$(tput sgr0)\]"

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:~/usr/bin

gi() { curl -L -s https://www.gitignore.io/api/\$@ ;}

aa_256 () { ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`; for i in {0..256}; do o=00$i; echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x; done ); }
